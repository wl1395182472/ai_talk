import '../model/api_response.dart';
import '../model/character.dart';
import '../model/recent_chat_character.dart';
import '../service/http_service.dart';
import '../service/user_service.dart';
import '../util/log.dart';

/// 角色聊天相关 API 服务类
class CharacterApiService {
  /// 单例模式实例
  static final CharacterApiService instance =
      CharacterApiService._privateConstructor();

  /// 工厂构造函数，返回单例实例
  factory CharacterApiService() => instance;

  /// 私有构造函数，防止外部实例化
  CharacterApiService._privateConstructor();

  final HttpService _httpService = HttpService.instance;

  /// 1.0 获取角色资料
  Future<ApiResponse<Character>> getCharacterProfile({
    required int characterId,
  }) async {
    try {
      final response = await _httpService.post(
        '/character/getProfile',
        data: {
          'user_id': UserService.instance.userId,
          'character_id': characterId,
        },
        fromJsonT: (data) => Character.fromJson(data),
      );

      return ApiResponse<Character>(
        code: response.code,
        msg: response.msg,
        result: response.result as Character?,
      );
    } catch (e) {
      throw Exception('获取角色资料失败: $e');
    }
  }

  /// 1.1.1 创建或编辑角色（仅私有角色可编辑）
  Future<ApiResponse<Character>> createOrEditCharacter({
    int? characterId,
    required String avatar,
    required String appearance,
    required String name,
    String? greeting,
    required String longDescription,
    required String shortDescription,
    List<String>? tags,
    String? voice,
    List<Map<String, dynamic>>? context,
    Map<String, dynamic>? params,
    String? lang,
    required int charge,
    required String sex, // Male, Female, Non-Binary
    String? style, // anime, 2D, realistic
  }) async {
    try {
      final data = {
        'user_id': UserService.instance.userId,
        'avatar': avatar,
        'appearance': appearance,
        'name': name,
        'long_description': longDescription,
        'short_description': shortDescription,
        'charge': charge,
        'sex': sex,
        if (characterId != null) 'character_id': characterId,
        if (greeting != null) 'greeting': greeting,
        if (tags != null) 'tags': tags,
        if (voice != null) 'voice': voice,
        if (context != null) 'context': context,
        if (params != null) 'params': params,
        if (lang != null) 'lang': lang,
        if (style != null) 'style': style,
      };

      final response = await _httpService.post(
        '/character/new/createOrEdit',
        data: data,
        fromJsonT: (data) => Character.fromJson(data),
      );

      return ApiResponse<Character>(
        code: response.code,
        msg: response.msg,
        result: response.result as Character?,
      );
    } catch (e) {
      throw Exception('创建或编辑角色失败: $e');
    }
  }

  /// 1.3 生成对话信息
  Future<ApiResponse<List<String>>> generateDialogMessages({
    required int count, // 1~5
    required String name,
    required String greeting,
    required String longDescription,
    required List<String> tags,
    required List<Map<String, dynamic>> context,
    required Map<String, dynamic> params,
  }) async {
    try {
      final response = await _httpService.post(
        '/character/generatMsgs',
        data: {
          'user_id': UserService.instance.userId,
          'count': count,
          'name': name,
          'greeting': greeting,
          'long_description': longDescription,
          'tags': tags,
          'context': context,
          'params': params,
        },
        fromJsonT: (data) => (data as List).cast<String>(),
      );

      return ApiResponse<List<String>>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('生成对话信息失败: $e');
    }
  }

  /// 1.5 创建新头像
  Future<ApiResponse<String>> createAvatar({
    required String data,
    int? fromApp,
    String? sex, // Male, Female, Non-Binary
    String? style, // anime, 2D, realistic
    int? background, // 0/1
  }) async {
    try {
      final requestData = {
        'user_id': UserService.instance.userId,
        'data': data,
        if (fromApp != null) 'from_app': fromApp,
        if (sex != null) 'sex': sex,
        if (style != null) 'style': style,
        if (background != null) 'background': background,
      };

      final response = await _httpService.post(
        '/character/new/createAvatar',
        data: requestData,
        fromJsonT: (data) => data as String,
      );

      return ApiResponse<String>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('创建头像失败: $e');
    }
  }

  /// 1.6 根据标签获取角色
  Future<ApiResponse<List<Character>>> getCharactersByTag({
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
        '/character/getCharactersByTag',
        data: data,
        fromJsonT: (data) =>
            (data as List).map((item) => Character.fromJson(item)).toList(),
      );

      return ApiResponse<List<Character>>(
        code: response.code,
        msg: response.msg,
        result: response.result as List<Character>?,
      );
    } catch (e) {
      throw Exception('根据标签获取角色失败: $e');
    }
  }

  /// 1.7 获取最近聊天的角色
  Future<ApiResponse<List<RecentChatCharacter>>> getCharactersChatRecently({
    required int limit,
    required int pageNo,
  }) async {
    try {
      final response = await _httpService.post(
        '/character/getCharactersChatRecently',
        data: {
          'user_id': UserService.instance.userId,
          'limit': limit,
          'page_no': pageNo,
        },
        fromJsonT: (data) {
          Log.instance.logger.d(data);
          return (data as List)
              .map((item) => RecentChatCharacter.fromJson(item))
              .toList();
        },
      );

      return ApiResponse<List<RecentChatCharacter>>(
        code: response.code,
        msg: response.msg,
        result: response.result as List<RecentChatCharacter>?,
      );
    } catch (e) {
      throw Exception('获取最近聊天角色失败: $e');
    }
  }

  /// 1.8 根据角色获取聊天历史
  Future<ApiResponse<List<ChatMessage>>> getChatHistory({
    required int characterId,
  }) async {
    try {
      final response = await _httpService.post(
        '/character/getChatHistory',
        data: {
          'user_id': UserService.instance.userId,
          'character_id': characterId,
        },
        fromJsonT: (data) =>
            (data as List).map((item) => ChatMessage.fromJson(item)).toList(),
      );

      return ApiResponse<List<ChatMessage>>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('获取聊天历史失败: $e');
    }
  }

  /// 1.9 继续聊天
  Future<ApiResponse<ChatSession>> continueChat({
    required int characterId,
    int? sessionId,
    int? fromApp,
  }) async {
    try {
      final data = {
        'user_id': UserService.instance.userId,
        'character_id': characterId,
        if (sessionId != null) 'session_id': sessionId,
        if (fromApp != null) 'from_app': fromApp,
      };

      final response = await _httpService.post(
        '/character/continueChat',
        data: data,
        fromJsonT: (data) => ChatSession.fromJson(data),
      );

      return ApiResponse<ChatSession>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('继续聊天失败: $e');
    }
  }

  /// 1.10 创建聊天会话
  Future<ApiResponse<ChatSession>> createChat({
    required int characterId,
    int? fromApp,
  }) async {
    try {
      final data = {
        'user_id': UserService.instance.userId,
        'character_id': characterId,
        if (fromApp != null) 'from_app': fromApp,
      };

      final response = await _httpService.post(
        '/character/createChat',
        data: data,
        fromJsonT: (data) => ChatSession.fromJson(data),
      );

      return ApiResponse<ChatSession>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('创建聊天会话失败: $e');
    }
  }

  /// 发送聊天消息 (SSE连接)
  Stream<dynamic> sendChatMessage({
    required int sessionId,
    required String message,
    Map<String, dynamic>? headers,
  }) {
    try {
      return _httpService.connectSSE(
        '/character/chat/stream',
        queryParameters: {
          'user_id': UserService.instance.userId,
          'session_id': sessionId.toString(),
          'message': message,
        },
        headers: headers,
      );
    } catch (e) {
      throw Exception('发送聊天消息失败: $e');
    }
  }
}
