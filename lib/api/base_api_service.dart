import 'dart:io' show File;

import 'package:ai_talk/service/user_service.dart';
import 'package:dio/dio.dart' show CancelToken, ProgressCallback;

import '../model/api_response.dart';
import '../model/character.dart';
import '../model/common.dart';
import '../service/http_service.dart';

/// 基础 API 服务类
/// 提供通用的功能接口
class BaseApiService {
  /// 单例模式实例
  static final BaseApiService instance = BaseApiService._privateConstructor();

  /// 工厂构造函数，返回单例实例
  factory BaseApiService() => instance;

  /// 私有构造函数，防止外部实例化
  BaseApiService._privateConstructor();

  final HttpService _httpService = HttpService.instance;

  /// 0.0 获取所有角色标签列表
  Future<ApiResponse<List<CharacterTag>>> getCompleteTagList({
    required int fromApp, // 0/1
    String? lang,
  }) async {
    try {
      final response = await _httpService.get(
        '/tags/complete/list',
        queryParameters: {
          'user_id': UserService.instance.userId,
          'from_app': fromApp,
          if (lang != null) 'lang': lang,
        },
        fromJsonT: (data) =>
            (data as List).map((item) => CharacterTag.fromJson(item)).toList(),
      );
      return ApiResponse<List<CharacterTag>>(
        code: response.code,
        msg: response.msg,
        result: response.result as List<CharacterTag>?,
      );
    } catch (e) {
      throw Exception('获取标签列表失败: $e');
    }
  }

  /// 0.1 获取创建角色时可用的标签列表
  Future<ApiResponse<List<CharacterTag>>> getAvailableTagsForCharacter() async {
    try {
      final response = await _httpService.get(
        '/tags/listAvailableTags',
        fromJsonT: (data) =>
            (data as List).map((item) => CharacterTag.fromJson(item)).toList(),
      );

      return ApiResponse<List<CharacterTag>>(
        code: response.code,
        msg: response.msg,
        result: response.result as List<CharacterTag>?,
      );
    } catch (e) {
      throw Exception('获取可用标签列表失败: $e');
    }
  }

  /// 0.2 上传音频
  Future<ApiResponse<UploadResponse>> uploadAudio({
    required File audio,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
  }) async {
    try {
      final response = await _httpService.upload(
        '/user/uploadAudio',
        file: audio,
        fileName: audio.path.split('/').last,
        fileKey: 'audio',
        extraData: {
          'user_id': UserService.instance.userId,
        },
        fromJsonT: (data) => UploadResponse.fromJson(data),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
      );

      return ApiResponse<UploadResponse>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('上传音频失败: $e');
    }
  }

  /// 0.3 上传图片
  Future<ApiResponse<UploadResponse>> uploadImage({
    required File image,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
  }) async {
    try {
      final response = await _httpService.upload(
        '/user/uploadImage',
        file: image,
        fileName: image.path.split('/').last,
        fileKey: 'img',
        extraData: {
          'user_id': UserService.instance.userId,
        },
        fromJsonT: (data) => UploadResponse.fromJson(data),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
      );

      return ApiResponse<UploadResponse>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('上传图片失败: $e');
    }
  }

  /// 0.4 获取角色语音列表
  Future<ApiResponse<List<CharacterVoice>>> getCharacterVoiceList({
    String? lang,
  }) async {
    try {
      final response = await _httpService.get(
        '/character/listVoices',
        queryParameters: {
          if (lang != null) 'lang': lang,
        },
        fromJsonT: (data) => (data as List)
            .map((item) => CharacterVoice.fromJson(item))
            .toList(),
      );

      return ApiResponse<List<CharacterVoice>>(
        code: response.code,
        msg: response.msg,
        result: response.result as List<CharacterVoice>?,
      );
    } catch (e) {
      throw Exception('获取语音列表失败: $e');
    }
  }

  /// 0.48 记录用户付费
  Future<ApiResponse<void>> recordPaid({
    required int characterId,
    required String platform,
    required int isSubscription,
    required String productId,
    String? system,
    int? worldId,
  }) async {
    try {
      final data = {
        'user_id': UserService.instance.userId,
        'character_id': characterId,
        'platform': platform,
        'is_subscription': isSubscription,
        'product_id': productId,
        if (system != null) 'system': system,
        if (worldId != null) 'world_id': worldId,
      };
      final response = await _httpService.post(
        '/character/paid/record',
        data: data,
      );
      return ApiResponse<void>(
        code: response.code,
        msg: response.msg,
        result: null,
      );
    } catch (e) {
      throw Exception('记录用户付费失败: $e');
    }
  }

  /// 0.47 检查聊天是否合法
  Future<ApiResponse<bool>> checkValidChat({
    required String message,
  }) async {
    try {
      final data = {
        'message': message,
        'user_id': UserService.instance.userId,
      };
      final response = await _httpService.post(
        '/character/message/valid',
        data: data,
        fromJsonT: (data) => data as bool,
      );
      return ApiResponse<bool>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('检查聊天是否合法失败: $e');
    }
  }

  /// 1.34 获取提示示例
  Future<ApiResponse<List<String>>> getHintExamples({
    int? num,
    String? lang,
  }) async {
    try {
      final params = <String, dynamic>{};
      if (num != null) params['num'] = num;
      if (lang != null) params['lang'] = lang;
      final response = await _httpService.get(
        '/character/getExamples',
        queryParameters: params,
        fromJsonT: (data) => (data as List).cast<String>(),
      );
      return ApiResponse<List<String>>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('获取提示示例失败: $e');
    }
  }

  /// 0.7 获取支付页面的图片
  Future<ApiResponse<List<String>>> getPaymentImages() async {
    try {
      final response = await _httpService.get(
        '/api/getPaymentImages',
        fromJsonT: (data) => (data as List).cast<String>(),
      );

      return ApiResponse<List<String>>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('获取支付图片失败: $e');
    }
  }

  /// 0.8 URL 记录
  Future<ApiResponse<void>> recordUrl({
    required String url,
    required String orgUrl,
  }) async {
    try {
      final response = await _httpService.get(
        '/notif/record/url',
        queryParameters: {
          'url': url,
          'org_url': orgUrl,
        },
      );

      return ApiResponse<void>(
        code: response.code,
        msg: response.msg,
        result: null,
      );
    } catch (e) {
      throw Exception('记录URL失败: $e');
    }
  }

  /// 0.9 翻译
  Future<ApiResponse<TranslateResponse>> translate(
    TranslateRequest request,
  ) async {
    try {
      final response = await _httpService.post(
        '/api/translate',
        data: request.toJson(),
        fromJsonT: (data) => TranslateResponse.fromJson(data),
      );

      return ApiResponse<TranslateResponse>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('翻译失败: $e');
    }
  }

  /// 0.10 生成图片
  Future<ApiResponse<TaskResponse>> generateImage(
    GenerateImageRequest request,
  ) async {
    try {
      final response = await _httpService.post(
        '/character/generate/image',
        data: request.toJson(),
        fromJsonT: (data) => TaskResponse.fromJson(data),
      );

      return ApiResponse<TaskResponse>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('生成图片失败: $e');
    }
  }

  /// 0.11 生成音频
  Future<ApiResponse<TaskResponse>> generateAudio(
    GenerateAudioRequest request,
  ) async {
    try {
      final response = await _httpService.post(
        '/character/generate/audio',
        data: request.toJson(),
        fromJsonT: (data) => TaskResponse.fromJson(data),
      );

      return ApiResponse<TaskResponse>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('生成音频失败: $e');
    }
  }

  /// 0.12 根据create_id查询图片/音频
  Future<ApiResponse<TaskResponse>> queryTask(
    QueryTaskRequest request,
  ) async {
    try {
      final response = await _httpService.post(
        '/character/query',
        data: request.toJson(),
        fromJsonT: (data) => TaskResponse.fromJson(data),
      );

      return ApiResponse<TaskResponse>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('查询任务失败: $e');
    }
  }
}
