import '../model/api_response.dart';
import '../model/novel.dart';
import '../service/http_service.dart';
import '../service/user_service.dart';

/// 小说相关 API 服务类
class NovelApiService {
  /// 单例模式实例
  static final NovelApiService instance = NovelApiService._privateConstructor();

  /// 工厂构造函数，返回单例实例
  factory NovelApiService() => instance;

  /// 私有构造函数，防止外部实例化
  NovelApiService._privateConstructor();

  final HttpService _httpService = HttpService.instance;

  /// 0.5 获取小说标签列表
  Future<ApiResponse<List<NovelTag>>> getNovelTagList() async {
    try {
      final response = await _httpService.get(
        '/novel/listTags',
        fromJsonT: (data) =>
            (data as List).map((item) => NovelTag.fromJson(item)).toList(),
      );

      return ApiResponse<List<NovelTag>>(
        code: response.code,
        msg: response.msg,
        result: response.result as List<NovelTag>?,
      );
    } catch (e) {
      throw Exception('获取小说标签列表失败: $e');
    }
  }

  /// 0.6 获取创建小说时可用的标签列表
  Future<ApiResponse<List<NovelTag>>> getAvailableTagsForNovel() async {
    try {
      final response = await _httpService.get(
        '/novel/listAvailableTags',
        fromJsonT: (data) =>
            (data as List).map((item) => NovelTag.fromJson(item)).toList(),
      );

      return ApiResponse<List<NovelTag>>(
        code: response.code,
        msg: response.msg,
        result: response.result as List<NovelTag>?,
      );
    } catch (e) {
      throw Exception('获取可用小说标签列表失败: $e');
    }
  }

  /// 创建小说（根据接口文档推测的接口）
  Future<ApiResponse<Novel>> createNovel({
    required String title,
    required String description,
    String? coverImage,
    List<String>? tags,
  }) async {
    try {
      final data = {
        'user_id': UserService.instance.userId,
        'title': title,
        'description': description,
        if (coverImage != null) 'cover_image': coverImage,
        if (tags != null) 'tags': tags,
      };

      final response = await _httpService.post(
        '/novel/create',
        data: data,
        fromJsonT: (data) => Novel.fromJson(data),
      );

      return ApiResponse<Novel>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('创建小说失败: $e');
    }
  }

  /// 获取小说列表（根据接口文档推测的接口）
  Future<ApiResponse<List<Novel>>> getNovelList({
    String? tag,
    required int limit,
    required int pageNo,
  }) async {
    try {
      final data = {
        'limit': limit,
        'page_no': pageNo,
        'user_id': UserService.instance.userId,
        if (tag != null) 'tag': tag,
      };

      final response = await _httpService.post(
        '/novel/list',
        data: data,
        fromJsonT: (data) =>
            (data as List).map((item) => Novel.fromJson(item)).toList(),
      );

      return ApiResponse<List<Novel>>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('获取小说列表失败: $e');
    }
  }

  /// 获取小说详情（根据接口文档推测的接口）
  Future<ApiResponse<Novel>> getNovelDetail({
    required int novelId,
  }) async {
    try {
      final response = await _httpService.post(
        '/novel/detail',
        data: {
          'user_id': UserService.instance.userId,
          'novel_id': novelId,
        },
        fromJsonT: (data) => Novel.fromJson(data),
      );

      return ApiResponse<Novel>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('获取小说详情失败: $e');
    }
  }

  /// 编辑小说（根据接口文档推测的接口）
  Future<ApiResponse<Novel>> editNovel({
    required int novelId,
    String? title,
    String? description,
    String? coverImage,
    List<String>? tags,
  }) async {
    try {
      final data = {
        'user_id': UserService.instance.userId,
        'novel_id': novelId,
        if (title != null) 'title': title,
        if (description != null) 'description': description,
        if (coverImage != null) 'cover_image': coverImage,
        if (tags != null) 'tags': tags,
      };

      final response = await _httpService.post(
        '/novel/edit',
        data: data,
        fromJsonT: (data) => Novel.fromJson(data),
      );

      return ApiResponse<Novel>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('编辑小说失败: $e');
    }
  }

  /// 删除小说（根据接口文档推测的接口）
  Future<ApiResponse<void>> deleteNovel({
    required int novelId,
  }) async {
    try {
      final response = await _httpService.post(
        '/novel/delete',
        data: {
          'user_id': UserService.instance.userId,
          'novel_id': novelId,
        },
      );

      return ApiResponse<void>(
        code: response.code,
        msg: response.msg,
        result: null,
      );
    } catch (e) {
      throw Exception('删除小说失败: $e');
    }
  }

  /// 2.0 获取小说资料
  Future<ApiResponse<Novel>> getNovelProfile({
    required int novelId,
  }) async {
    try {
      final response = await _httpService.post(
        '/novel/getProfile',
        data: {
          'user_id': UserService.instance.userId,
          'novel_id': novelId,
        },
        fromJsonT: (data) => Novel.fromJson(data),
      );
      return ApiResponse<Novel>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('获取小说资料失败: $e');
    }
  }

  /// 2.1 创建或编辑小说
  Future<ApiResponse<Novel>> createOrEditNovel({
    int? novelId,
    required String cover,
    required String title,
    required String worldView,
    required String scene,
    required String foreword,
    required String characters, // JSON字符串: [{"name":"","desc":""}]
    List<String>? tags,
    String? lang,
  }) async {
    try {
      final data = {
        'user_id': UserService.instance.userId,
        'cover': cover,
        'title': title,
        'world_view': worldView,
        'scene': scene,
        'foreword': foreword,
        'characters': characters,
        if (novelId != null) 'novel_id': novelId,
        if (tags != null) 'tags': tags,
        if (lang != null) 'lang': lang,
      };
      final response = await _httpService.post(
        '/novel/createOrEdit',
        data: data,
        fromJsonT: (data) => Novel.fromJson(data),
      );
      return ApiResponse<Novel>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('创建或编辑小说失败: $e');
    }
  }

  /// 2.3 发布小说
  Future<ApiResponse<void>> releaseNovel({
    required int novelId,
  }) async {
    try {
      final response = await _httpService.post(
        '/novel/release',
        data: {
          'user_id': UserService.instance.userId,
          'novel_id': novelId,
        },
      );
      return ApiResponse<void>(
        code: response.code,
        msg: response.msg,
        result: null,
      );
    } catch (e) {
      throw Exception('发布小说失败: $e');
    }
  }

  /// 2.4 取消发布小说
  Future<ApiResponse<void>> unreleaseNovel({
    required int novelId,
  }) async {
    try {
      final response = await _httpService.post(
        '/novel/unrelease',
        data: {
          'user_id': UserService.instance.userId,
          'novel_id': novelId,
        },
      );
      return ApiResponse<void>(
        code: response.code,
        msg: response.msg,
        result: null,
      );
    } catch (e) {
      throw Exception('取消发布小说失败: $e');
    }
  }

  /// 2.6 根据标签获取小说
  Future<ApiResponse<List<Novel>>> getNovelsByTag({
    required String tag,
    required int limit,
    required int pageNo,
  }) async {
    try {
      final data = {
        'tag': tag,
        'limit': limit,
        'page_no': pageNo,
        'user_id': UserService.instance.userId,
      };
      final response = await _httpService.post(
        '/novel/getNovelsByTag',
        data: data,
        fromJsonT: (data) =>
            (data as List).map((item) => Novel.fromJson(item)).toList(),
      );
      return ApiResponse<List<Novel>>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('根据标签获取小说失败: $e');
    }
  }

  /// 2.11 生成小说内容
  Future<ApiResponse<dynamic>> generateNovel({
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await _httpService.post(
        '/novel/generate',
        data: data,
      );
      return ApiResponse<dynamic>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('生成小说内容失败: $e');
    }
  }
}
