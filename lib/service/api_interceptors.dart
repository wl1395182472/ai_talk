import 'dart:convert' show jsonDecode;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../util/log.dart';
import '../util/secure_storage.dart';

/// API 认证拦截器
/// 自动添加认证 token 到请求头中
class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      // 从安全存储中获取 token
      final token = await SecureStorage.instance.read(key: 'auth_token');

      if (token != null && token.isNotEmpty) {
        // 添加 Bearer token 到请求头
        options.headers['Authorization'] = 'Bearer $token';
      }

      // 添加用户代理
      options.headers['User-Agent'] = 'AiTalk/1.0.0';

      // 添加设备信息（可选）
      if (kDebugMode) {
        options.headers['X-Debug-Mode'] = 'true';
      }
    } catch (e) {
      Log.instance.logger.w('获取认证 token 失败: $e');
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // 检查响应中是否包含新的 token
    final newToken = response.headers.value('session-token');
    if (newToken != null) {
      // 保存新的 token
      SecureStorage.instance.write(key: 'auth_token', value: newToken);
    }

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // 处理 401 未授权错误
    if (err.response?.statusCode == 401) {
      // 清除过期的 token
      SecureStorage.instance.delete(key: 'auth_token');

      // 可以在这里触发重新登录逻辑
      Log.instance.logger.w('认证过期，需要重新登录');
    }

    // 处理 403 禁止访问错误
    if (err.response?.statusCode == 403) {
      Log.instance.logger.w('访问被禁止，权限不足');
    }

    super.onError(err, handler);
  }
}

/// API 响应转换拦截器
/// 统一处理 API 响应格式
class ResponseTransformerInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    try {
      // 检查 HTTP 状态码
      if (response.statusCode != 200) {
        final errorMessage = _getHttpErrorMessage(response.statusCode);
        final dioError = DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          message: errorMessage,
        );
        handler.reject(dioError);
        return;
      }

      // 处理响应体数据
      Map<String, dynamic> parsedData;

      if (response.data is String) {
        // 如果响应是字符串，尝试解析 JSON
        try {
          parsedData = jsonDecode(response.data) as Map<String, dynamic>;
        } catch (e) {
          Log.instance.logger.e('JSON 解析失败: $e');
          final dioError = DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
            message: '服务器返回的数据格式错误',
          );
          handler.reject(dioError);
          return;
        }
      } else if (response.data is Map<String, dynamic>) {
        parsedData = response.data as Map<String, dynamic>;
      } else {
        // 如果响应数据不是预期格式，直接返回
        super.onResponse(response, handler);
        return;
      }

      // 检查是否符合统一响应格式 {code, message, result}
      if (!parsedData.containsKey('code')) {
        Log.instance.logger.w('响应数据缺少 code 字段');
        final dioError = DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          message: '服务器返回的数据格式不正确',
        );
        handler.reject(dioError);
        return;
      }

      final code = parsedData['code'];
      final message = parsedData['message'] ?? parsedData['msg'] ?? '';
      final result = parsedData['result'];

      // 检查业务状态码
      if (code != 0) {
        final errorMessage = message.isNotEmpty ? message : '请求失败';
        Log.instance.logger.w('业务错误 [code: $code]: $errorMessage');

        final dioError = DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          message: errorMessage,
        );
        handler.reject(dioError);
        return;
      }

      // 成功时，将 result 作为响应数据返回
      response.data = result;

      Log.instance.logger.d('请求成功: ${response.requestOptions.uri}');
    } catch (e) {
      Log.instance.logger.e('响应转换失败: $e');
      final dioError = DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
        message: '响应数据处理失败',
      );
      handler.reject(dioError);
      return;
    }

    super.onResponse(response, handler);
  }

  /// 获取 HTTP 状态码对应的错误信息
  String _getHttpErrorMessage(int? statusCode) {
    switch (statusCode) {
      case 400:
        return '请求参数错误';
      case 401:
        return '未授权访问';
      case 403:
        return '访问被禁止';
      case 404:
        return '请求的资源不存在';
      case 405:
        return '请求方法不被允许';
      case 408:
        return '请求超时';
      case 422:
        return '请求参数验证失败';
      case 429:
        return '请求过于频繁';
      case 500:
        return '服务器内部错误';
      case 502:
        return '网关错误';
      case 503:
        return '服务暂不可用';
      case 504:
        return '网关超时';
      default:
        return '请求失败 (HTTP $statusCode)';
    }
  }
}

/// API 重试拦截器
/// 自动重试失败的请求
class RetryInterceptor extends Interceptor {
  final int maxRetries;
  final Duration retryDelay;
  final List<int> retryStatusCodes;

  RetryInterceptor({
    this.maxRetries = 3,
    this.retryDelay = const Duration(seconds: 1),
    this.retryStatusCodes = const [500, 502, 503, 504],
  });

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final options = err.requestOptions;

    // 检查是否应该重试
    if (_shouldRetry(err)) {
      final retryCount = options.extra['retry_count'] as int? ?? 0;

      if (retryCount < maxRetries) {
        options.extra['retry_count'] = retryCount + 1;

        Log.instance.logger.i(
          '重试请求 (${retryCount + 1}/$maxRetries): ${options.uri}',
        );

        // 延迟后重试
        await Future.delayed(retryDelay);

        try {
          final dio = Dio();
          final response = await dio.fetch(options);
          handler.resolve(response);
          return;
        } catch (e) {
          // 如果重试失败，继续原来的错误处理
        }
      }
    }

    super.onError(err, handler);
  }

  bool _shouldRetry(DioException err) {
    // 网络错误或连接超时，可以重试
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionError) {
      return true;
    }

    // 特定的HTTP状态码可以重试
    if (err.response != null &&
        retryStatusCodes.contains(err.response!.statusCode)) {
      return true;
    }

    return false;
  }
}

/// API 缓存拦截器
/// 缓存GET请求的响应
class CacheInterceptor extends Interceptor {
  final Map<String, _CacheItem> _cache = {};
  final Duration defaultCacheDuration;

  CacheInterceptor({
    this.defaultCacheDuration = const Duration(minutes: 5),
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 只缓存 GET 请求
    if (options.method.toUpperCase() != 'GET') {
      super.onRequest(options, handler);
      return;
    }

    // 检查是否有缓存
    final cacheKey = _getCacheKey(options);
    final cacheItem = _cache[cacheKey];

    if (cacheItem != null && !cacheItem.isExpired) {
      Log.instance.logger.d('从缓存返回: ${options.uri}');

      final response = Response(
        requestOptions: options,
        data: cacheItem.data,
        statusCode: 200,
      );

      handler.resolve(response);
      return;
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // 只缓存成功的 GET 请求
    if (response.requestOptions.method.toUpperCase() == 'GET' &&
        response.statusCode == 200) {
      final cacheKey = _getCacheKey(response.requestOptions);
      final cacheDuration = _getCacheDuration(response.requestOptions);

      _cache[cacheKey] = _CacheItem(
        data: response.data,
        expiredAt: DateTime.now().add(cacheDuration),
      );

      Log.instance.logger.d('缓存响应: ${response.requestOptions.uri}');
    }

    super.onResponse(response, handler);
  }

  String _getCacheKey(RequestOptions options) {
    final uri = options.uri.toString();
    final headers = options.headers.toString();
    return '$uri|$headers';
  }

  Duration _getCacheDuration(RequestOptions options) {
    // 可以根据请求的特定参数设置不同的缓存时间
    final cacheControl = options.extra['cache_duration'] as Duration?;
    return cacheControl ?? defaultCacheDuration;
  }

  /// 清除所有缓存
  void clearAll() {
    _cache.clear();
  }

  /// 清除特定 URL 的缓存
  void clearUrl(String url) {
    _cache.removeWhere((key, value) => key.startsWith(url));
  }
}

class _CacheItem {
  final dynamic data;
  final DateTime expiredAt;

  _CacheItem({
    required this.data,
    required this.expiredAt,
  });

  bool get isExpired => DateTime.now().isAfter(expiredAt);
}
