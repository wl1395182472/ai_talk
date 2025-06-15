import 'dart:convert' show jsonDecode;
import 'dart:io' show File, Platform;

import 'package:dio/dio.dart';

import '../model/api_response.dart';
import '../model/http_method.dart';
import '../util/log.dart';
import 'api_interceptors.dart';

/// HTTP服务类，封装dio插件实现网络请求
/// 提供GET、POST、文件上传下载、SSE连接等功能
/// 使用单例模式确保全局唯一实例
class HttpService {
  /// 单例模式实例
  static final HttpService instance = HttpService._privateConstructor();

  /// 工厂构造函数，返回单例实例
  factory HttpService() => instance;

  /// 私有构造函数，防止外部实例化
  HttpService._privateConstructor();

  /// dio实例，用于发起HTTP请求
  late final Dio _dio = _createDio();

  /// 创建dio实例并配置基础设置和拦截器
  Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://prod.lightcornerltd.com',
        followRedirects: true, // 启用重定向
        headers: {
          'Accept': 'application/json',
        },
      ),
    );

    // 添加认证拦截器
    dio.interceptors.add(AuthInterceptor());

    // 添加响应转换拦截器
    // dio.interceptors.add(ResponseTransformerInterceptor());

    // 添加重试拦截器
    dio.interceptors.add(RetryInterceptor());

    // 添加缓存拦截器（可选）
    // dio.interceptors.add(CacheInterceptor());

    // 添加日志拦截器，用于调试网络请求
    dio.interceptors.add(LogInterceptor(
      request: false,
      requestHeader: false,
      requestBody: true,
      responseHeader: false,
      responseBody: true,
      error: true,
      logPrint: (object) {
        Log.instance.logger.d(object.toString());
      },
    ));

    return dio;
  }

  /// 基础请求方法
  /// [url] 请求地址
  /// [method] 请求方法
  /// [queryParameters] 查询参数
  /// [data] 请求体数据
  /// [options] 请求选项
  /// [cancelToken] 取消令牌
  /// [onSendProgress] 上传进度回调
  /// [onReceiveProgress] 下载进度回调
  Future<ApiResponse> request({
    required String url,
    required HttpMethod method,
    dynamic Function(dynamic)? fromJsonT,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      options ??= Options();
      options.method = method.name.toUpperCase();

      queryParameters?.putIfAbsent('system', () => Platform.operatingSystem);
      queryParameters?.putIfAbsent('lang', () => 'en');

      // Prepare data for the Dio request
      dynamic dataForDioRequest = data;
      if (data is Map) {
        // If data is a Map, create a new Map<String, dynamic>
        // to ensure 'system' and 'lang' can be added without type conflicts.
        Map<String, dynamic> newMapData = {};
        data.forEach((key, value) {
          // Ensure keys are strings for the new map.
          newMapData[key.toString()] = value;
        });

        newMapData.putIfAbsent('system', () => Platform.operatingSystem);
        newMapData.putIfAbsent('lang', () => 'en');
        dataForDioRequest = newMapData;
      }
      // If data is not a Map (e.g., String, FormData), it's used as is.

      final response = await _dio.request(
        url,
        queryParameters:
            queryParameters, // Assuming this is correctly typed by caller or null
        data: dataForDioRequest, // Use the processed data
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      if (response.statusCode == 200) {
        return ApiResponse.fromJson(
          response.data,
          fromJsonT,
        );
      } else {
        return ApiResponse(
          code: response.statusCode ?? 500,
          msg: response.statusMessage ?? '网络错误',
          result: null,
        );
      }
    } catch (error, stackTrace) {
      Log.instance.logger.e(
        '网络请求异常: $error',
        error: error,
        stackTrace: stackTrace,
      );
      return ApiResponse(
        code: -1,
        msg: '网络请求异常: $error',
        result: null,
      );
    }
  }

  /// GET请求
  Future<ApiResponse> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    dynamic Function(dynamic)? fromJsonT,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    return request(
      url: url,
      method: HttpMethod.get,
      queryParameters: queryParameters,
      fromJsonT: fromJsonT,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  /// POST请求
  Future<ApiResponse> post(
    String url, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    dynamic Function(dynamic)? fromJsonT,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return request(
      url: url,
      method: HttpMethod.post,
      data: data,
      queryParameters: queryParameters,
      fromJsonT: fromJsonT,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  /// PUT请求
  Future<ApiResponse> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    dynamic Function(dynamic)? fromJsonT,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return request(
      url: url,
      method: HttpMethod.put,
      data: data,
      queryParameters: queryParameters,
      fromJsonT: fromJsonT,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  /// DELETE请求
  Future<ApiResponse> delete(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    dynamic Function(dynamic)? fromJsonT,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return request(
      url: url,
      method: HttpMethod.delete,
      data: data,
      queryParameters: queryParameters,
      fromJsonT: fromJsonT,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  /// 文件上传请求
  Future<ApiResponse> upload(
    String url, {
    required File file,
    required String fileName,
    required String fileKey,
    Map<String, dynamic>? extraData,
    dynamic Function(dynamic)? fromJsonT,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
  }) async {
    try {
      final formData = FormData();

      // 添加文件
      formData.files.add(MapEntry(
        fileKey,
        await MultipartFile.fromFile(file.path, filename: fileName),
      ));

      // 添加额外数据
      if (extraData != null) {
        extraData.forEach((key, value) {
          formData.fields.add(MapEntry(key, value.toString()));
        });
      }

      return request(
        url: url,
        method: HttpMethod.post,
        data: formData,
        fromJsonT: fromJsonT,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
      );
    } catch (e) {
      throw Exception('文件上传失败: $e');
    }
  }

  /// SSE连接
  Stream<dynamic> connectSSE(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async* {
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Accept': 'text/event-stream',
            'Cache-Control': 'no-cache',
            ...?headers,
          },
          responseType: ResponseType.stream,
        ),
      );

      final stream = response.data.stream as Stream<List<int>>;
      String buffer = '';

      await for (final chunk in stream) {
        buffer += String.fromCharCodes(chunk);

        // 处理SSE消息
        final lines = buffer.split('\n');
        buffer = lines.removeLast();

        for (final line in lines) {
          if (line.startsWith('data: ')) {
            final data = line.substring(6);
            if (data.trim() == '[DONE]') {
              return;
            }

            try {
              final decoded = jsonDecode(data);
              yield decoded;
            } catch (e) {
              // 忽略解析错误，继续处理下一行
            }
          }
        }
      }
    } catch (e) {
      throw Exception('SSE连接失败: $e');
    }
  }
}
