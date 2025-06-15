import 'package:ai_talk/model/group_list_item.dart';

import '../model/api_response.dart';
import '../model/chat_room.dart';
import '../service/http_service.dart';
import '../service/user_service.dart';
import '../util/log.dart';

/// 群聊相关 API 服务类
class GroupApiService {
  /// 单例模式实例
  static final GroupApiService instance = GroupApiService._privateConstructor();

  /// 工厂构造函数，返回单例实例
  factory GroupApiService() => instance;

  /// 私有构造函数，防止外部实例化
  GroupApiService._privateConstructor();

  final HttpService _httpService = HttpService.instance;

  /// 14.1 获取群聊资料
  Future<ApiResponse<ChatRoom>> getGroupProfile({
    required int groupId,
    required String lang,
  }) async {
    try {
      final response = await _httpService.post(
        '/character/group/profile',
        data: {
          'user_id': UserService.instance.userId,
          'group_id': groupId,
          'lang': lang,
        },
        fromJsonT: (data) => ChatRoom.fromJson(data),
      );
      return ApiResponse<ChatRoom>(
        code: response.code,
        msg: response.msg,
        result: response.result as ChatRoom?,
      );
    } catch (e) {
      throw Exception('获取群聊资料失败: $e');
    }
  }

  /// 14.2 创建/编辑群聊
  Future<ApiResponse<Map<String, dynamic>>> createOrEditGroup({
    int? groupId,
    required String title,
    required String coverPrompt,
    required String cover,
    required String background,
    required String scenario,
    required List<int> characterIds,
    required List<GroupRelationship> relationship,
    required List<GroupGreeting> greetings,
  }) async {
    try {
      final response = await _httpService.post(
        '/character/group/craft',
        data: {
          'user_id': UserService.instance.userId,
          if (groupId != null) 'group_id': groupId,
          'title': title,
          'cover_prompt': coverPrompt,
          'cover': cover,
          'background': background,
          'scenario': scenario,
          'character_ids': characterIds,
          'relationship': relationship.map((e) => e.toJson()).toList(),
          'greetings': greetings.map((e) => e.toJson()).toList(),
        },
      );
      return ApiResponse<Map<String, dynamic>>(
        code: response.code,
        msg: response.msg,
        result: response.result as Map<String, dynamic>?,
      );
    } catch (e) {
      throw Exception('创建/编辑群聊失败: $e');
    }
  }

  /// 14.3 删除群聊
  Future<ApiResponse<Map<String, dynamic>>> deleteGroup({
    required int groupId,
  }) async {
    try {
      final response = await _httpService.post(
        '/character/group/delete',
        data: {
          'user_id': UserService.instance.userId,
          'group_id': groupId,
        },
      );
      return ApiResponse<Map<String, dynamic>>(
        code: response.code,
        msg: response.msg,
        result: response.result as Map<String, dynamic>?,
      );
    } catch (e) {
      throw Exception('删除群聊失败: $e');
    }
  }

  /// 14.4 创建群聊会话 / 通过session_id打开群聊会话
  Future<ApiResponse<GroupSession>> openGroupSession({
    required int groupId,
    int? sessionId,
    required String system,
    required int limit,
    required int pageNo,
    int? toCreate,
    int? personalId,
  }) async {
    try {
      final response = await _httpService.post(
        '/character/group/session/open',
        data: {
          'user_id': UserService.instance.userId,
          'group_id': groupId,
          if (sessionId != null) 'session_id': sessionId,
          'system': system,
          'limit': limit,
          'page_no': pageNo,
          if (toCreate != null) 'to_create': toCreate,
          if (personalId != null) 'personal_id': personalId,
        },
        fromJsonT: (data) => GroupSession.fromJson(data),
      );
      return ApiResponse<GroupSession>(
        code: response.code,
        msg: response.msg,
        result: response.result as GroupSession?,
      );
    } catch (e) {
      throw Exception('打开群聊会话失败: $e');
    }
  }

  /// 14.5 更新会话资料
  Future<ApiResponse<Map<String, dynamic>>> updateSessionProfile({
    required int sessionId,
    required int personalId,
    Map<String, dynamic>? extion,
    String? lang,
  }) async {
    try {
      final response = await _httpService.post(
        '/character/group/session/update',
        data: {
          'user_id': UserService.instance.userId,
          'session_id': sessionId,
          'personal_id': personalId,
          if (extion != null) 'extion': extion,
          if (lang != null) 'lang': lang,
        },
      );
      return ApiResponse<Map<String, dynamic>>(
        code: response.code,
        msg: response.msg,
        result: response.result as Map<String, dynamic>?,
      );
    } catch (e) {
      throw Exception('更新会话资料失败: $e');
    }
  }

  /// 14.6 提交用户内容
  Future<ApiResponse<GroupUserCommitResponse>> commitUserContent({
    required int sessionId,
    String? content,
    int? uniqId,
    String? lang,
  }) async {
    try {
      final response = await _httpService.post(
        '/character/group/user/commit',
        data: {
          'user_id': UserService.instance.userId,
          'session_id': sessionId,
          if (content != null) 'content': content,
          if (uniqId != null) 'uniq_id': uniqId,
          if (lang != null) 'lang': lang,
        },
        fromJsonT: (data) => GroupUserCommitResponse.fromJson(data),
      );
      return ApiResponse<GroupUserCommitResponse>(
        code: response.code,
        msg: response.msg,
        result: response.result as GroupUserCommitResponse?,
      );
    } catch (e) {
      throw Exception('提交用户内容失败: $e');
    }
  }

  /// 14.7 群聊生成（SSE流式响应）
  Stream<GroupGenerateResponse> generateGroupChat({
    required int sessionId,
    int? uniqId,
    String? speaker,
    int? batchSize,
  }) async* {
    try {
      final queryParams = {
        'user_id': UserService.instance.userId,
        'session_id': sessionId.toString(),
        if (uniqId != null) 'uniq_id': uniqId.toString(),
        if (speaker != null) 'speaker': speaker,
        if (batchSize != null) 'batch_size': batchSize.toString(),
      };

      await for (final event in _httpService.connectSSE(
        '/character/group/generate/sse',
        queryParameters: queryParams,
      )) {
        if (event is Map<String, dynamic>) {
          try {
            yield GroupGenerateResponse.fromJson(event);
          } catch (e) {
            Log.instance.logger.e('解析群聊生成响应失败: $e');
          }
        }
      }
    } catch (e) {
      throw Exception('群聊生成失败: $e');
    }
  }

  /// 14.8 群聊重新生成（SSE流式响应）
  Stream<GroupGenerateResponse> regenerateGroupChat({
    required int sessionId,
    int? replyId,
  }) async* {
    try {
      final queryParams = {
        'user_id': UserService.instance.userId,
        'session_id': sessionId.toString(),
        if (replyId != null) 'reply_id': replyId.toString(),
      };

      await for (final event in _httpService.connectSSE(
        '/character/group/regenerate/sse',
        queryParameters: queryParams,
      )) {
        if (event is Map<String, dynamic>) {
          try {
            yield GroupGenerateResponse.fromJson(event);
          } catch (e) {
            Log.instance.logger.e('解析群聊重新生成响应失败: $e');
          }
        }
      }
    } catch (e) {
      throw Exception('群聊重新生成失败: $e');
    }
  }

  /// 14.9 获取最后的内容（SSE流式响应）
  Stream<GroupGenerateResponse> getLastContent({
    required int sessionId,
  }) async* {
    try {
      final queryParams = {
        'user_id': UserService.instance.userId,
        'session_id': sessionId.toString(),
      };

      await for (final event in _httpService.connectSSE(
        '/character/group/latest/content/sse',
        queryParameters: queryParams,
      )) {
        if (event is Map<String, dynamic>) {
          try {
            yield GroupGenerateResponse.fromJson(event);
          } catch (e) {
            Log.instance.logger.e('解析最后内容响应失败: $e');
          }
        }
      }
    } catch (e) {
      throw Exception('获取最后内容失败: $e');
    }
  }

  /// 14.10 编辑AI内容
  Future<ApiResponse<Map<String, dynamic>>> editAIContent({
    required int sessionId,
    required int uniqId,
    required String content,
    String? lang,
  }) async {
    try {
      final response = await _httpService.post(
        '/character/group/chat/edit',
        data: {
          'user_id': UserService.instance.userId,
          'session_id': sessionId,
          'uniq_id': uniqId,
          'content': content,
          if (lang != null) 'lang': lang,
        },
      );
      return ApiResponse<Map<String, dynamic>>(
        code: response.code,
        msg: response.msg,
        result: response.result as Map<String, dynamic>?,
      );
    } catch (e) {
      throw Exception('编辑AI内容失败: $e');
    }
  }

  /// 14.11 从索引删除内容
  Future<ApiResponse<Map<String, dynamic>>> deleteContentFromIdx({
    required int sessionId,
    required int idx,
  }) async {
    try {
      final response = await _httpService.post(
        '/character/group/content/delete',
        data: {
          'user_id': UserService.instance.userId,
          'session_id': sessionId,
          'idx': idx,
        },
      );
      return ApiResponse<Map<String, dynamic>>(
        code: response.code,
        msg: response.msg,
        result: response.result as Map<String, dynamic>?,
      );
    } catch (e) {
      throw Exception('删除内容失败: $e');
    }
  }

  /// 14.12 删除群聊会话
  Future<ApiResponse<Map<String, dynamic>>> deleteGroupSession({
    int? groupId,
    int? sessionId,
  }) async {
    try {
      final response = await _httpService.post(
        '/character/group/session/delete',
        data: {
          'user_id': UserService.instance.userId,
          if (groupId != null) 'group_id': groupId,
          if (sessionId != null) 'session_id': sessionId,
        },
      );
      return ApiResponse<Map<String, dynamic>>(
        code: response.code,
        msg: response.msg,
        result: response.result as Map<String, dynamic>?,
      );
    } catch (e) {
      throw Exception('删除群聊会话失败: $e');
    }
  }

  /// 14.13 列出用户的群聊（创建的/聊过的）
  Future<ApiResponse<List<GroupListItem>>> listUserGroups({
    required String type,
    required int limit,
    required int pageNo,
  }) async {
    try {
      final response = await _httpService.post(
        '/character/group/user/list',
        data: {
          'user_id': UserService.instance.userId,
          'type': type,
          'limit': limit,
          'page_no': pageNo,
        },
        fromJsonT: (data) {
          if (data is List) {
            return data
                .map((e) => GroupListItem.fromJson(e as Map<String, dynamic>))
                .toList();
          } else {
            Log.instance.logger.w('获取用户群聊列表返回的数据格式不正确: [${data.runtimeType}]');
            return <GroupListItem>[];
          }
        },
      );

      return ApiResponse<List<GroupListItem>>(
        code: response.code,
        msg: response.msg,
        result: response.result as List<GroupListItem>?,
      );
    } catch (e) {
      throw Exception('获取用户群聊列表失败: $e');
    }
  }

  /// 14.14 发布/取消发布群聊
  Future<ApiResponse<Map<String, dynamic>>> releaseGroup({
    required int groupId,
  }) async {
    try {
      final response = await _httpService.post(
        '/character/group/release',
        data: {
          'user_id': UserService.instance.userId,
          'group_id': groupId,
        },
      );
      return ApiResponse<Map<String, dynamic>>(
        code: response.code,
        msg: response.msg,
        result: response.result as Map<String, dynamic>?,
      );
    } catch (e) {
      throw Exception('发布/取消发布群聊失败: $e');
    }
  }

  /// 14.15 获取首页群聊列表
  Future<ApiResponse> getHomePageGroups({
    required int limit,
    required int pageNo,
  }) async {
    try {
      return await _httpService.post(
        '/character/group/list',
        data: {
          'user_id': UserService.instance.userId,
          'limit': limit,
          'page_no': pageNo,
        },
        fromJsonT: (data) {
          if (data is List) {
            return data
                .map((e) => ChatRoom.fromJson(e as Map<String, dynamic>))
                .toList();
          } else {
            Log.instance.logger.w('获取首页群聊列表返回的数据格式不正确: [${data.runtimeType}');
            return <ChatRoom>[];
          }
        },
      );
    } catch (error, stackTrace) {
      Log.instance.logger.e('获取首页群聊列表失败', error: error, stackTrace: stackTrace);
      throw Exception('获取首页群聊列表失败: $error');
    }
  }

  /// 14.16 聊天会话迁移到群聊会话
  Future<ApiResponse<GroupMigrateResponse>> migrateToGroupSession({
    required int chatSessionId,
    required List<int> characterIds,
  }) async {
    try {
      final response = await _httpService.post(
        '/character/group/migrate',
        data: {
          'user_id': UserService.instance.userId,
          'chat_session_id': chatSessionId,
          'character_ids': characterIds,
        },
        fromJsonT: (data) => GroupMigrateResponse.fromJson(data),
      );
      return ApiResponse<GroupMigrateResponse>(
        code: response.code,
        msg: response.msg,
        result: response.result as GroupMigrateResponse?,
      );
    } catch (e) {
      throw Exception('迁移到群聊会话失败: $e');
    }
  }

  /// 14.17 举报群聊
  Future<ApiResponse<Map<String, dynamic>>> reportGroup({
    required int groupId,
  }) async {
    try {
      final response = await _httpService.post(
        '/character/group/report',
        data: {
          'user_id': UserService.instance.userId,
          'group_id': groupId,
        },
      );
      return ApiResponse<Map<String, dynamic>>(
        code: response.code,
        msg: response.msg,
        result: response.result as Map<String, dynamic>?,
      );
    } catch (e) {
      throw Exception('举报群聊失败: $e');
    }
  }

  /// 获取最近的用户列表
  Future<ApiResponse<List<GroupListItem>>> fetchRecentList({
    required String category,
    int? limit,
    int? pageNumber,
  }) async {
    try {
      final response = await _httpService.post(
        '/character/group/user/list',
        data: {
          'user_id': UserService.instance.userId,
          'category': category,
          if (limit != null) 'limit': limit,
          if (pageNumber != null) 'page_no': pageNumber,
        },
        fromJsonT: (data) {
          if (data is List) {
            return data
                .map((e) => GroupListItem.fromJson(e as Map<String, dynamic>))
                .toList();
          } else {
            Log.instance.logger.w('获取最近用户列表返回的数据格式不正确: [${data.runtimeType}]');
            return <GroupListItem>[];
          }
        },
      );

      return ApiResponse<List<GroupListItem>>(
        code: response.code,
        msg: response.msg,
        result: response.result as List<GroupListItem>?,
      );
    } catch (e) {
      throw Exception('获取最近用户列表失败: $e');
    }
  }

  /// 群聊制作
  Future<ApiResponse<Map<String, dynamic>>> groupCraft({
    int? groupId,
    required String title,
    String? cover,
    String? background,
    required String scenario,
    required List<int> characterIds,
    required List<Map<String, dynamic>> relationship,
    List<Map<String, dynamic>>? greetings,
  }) async {
    try {
      final response = await _httpService.post(
        '/character/group/craft',
        data: {
          'user_id': UserService.instance.userId,
          if (groupId != null) 'group_id': groupId,
          'title': title,
          if (cover != null) 'cover': cover,
          if (background != null) 'background': background,
          'scenario': scenario,
          'character_ids': characterIds,
          'relationship': relationship,
          if (greetings != null) 'greetings': greetings,
        },
      );

      return ApiResponse<Map<String, dynamic>>(
        code: response.code,
        msg: response.msg,
        result: response.result as Map<String, dynamic>?,
      );
    } catch (e) {
      throw Exception('群聊制作失败: $e');
    }
  }

  /// 会话打开
  Future<ApiResponse<GroupSession>> sessionOpen({
    required int groupId,
    int? sessionId,
    int? page,
    int? limit,
    required bool isCreate,
  }) async {
    try {
      final response = await _httpService.post(
        '/character/group/session/open',
        data: {
          'user_id': UserService.instance.userId,
          'group_id': groupId,
          if (sessionId != null) 'session_id': sessionId,
          if (page != null) 'page': page,
          if (limit != null) 'limit': limit,
          'to_create': isCreate ? 1 : 0,
        },
        fromJsonT: (data) => GroupSession.fromJson(data),
      );

      return ApiResponse<GroupSession>(
        code: response.code,
        msg: response.msg,
        result: response.result as GroupSession?,
      );
    } catch (e) {
      throw Exception('打开会话失败: $e');
    }
  }

  /// 会话更新
  Future<ApiResponse<void>> sessionUpdate({
    int? sessionId,
    int? personalId,
    Map<String, dynamic>? extion,
  }) async {
    try {
      final response = await _httpService.post(
        '/character/group/session/update',
        data: {
          'user_id': UserService.instance.userId,
          if (sessionId != null) 'session_id': sessionId,
          if (personalId != null) 'personal_id': personalId,
          if (extion != null) 'extion': extion,
        },
      );

      return ApiResponse<void>(
        code: response.code,
        msg: response.msg,
      );
    } catch (e) {
      throw Exception('更新会话失败: $e');
    }
  }

  /// 群聊生成 SSE
  Stream<Map<String, dynamic>> groupGenerateSse({
    required int sessionId,
    int? uniqueId,
    String? speaker,
    int? batchSize,
  }) {
    try {
      return _httpService.connectSSE(
        '/character/group/generate/sse',
        queryParameters: {
          'user_id': UserService.instance.userId,
          'session_id': sessionId.toString(),
          if (uniqueId != null) 'unique_id': uniqueId.toString(),
          if (speaker != null) 'speaker': speaker,
          if (batchSize != null) 'batch_size': batchSize.toString(),
        },
      ).cast<Map<String, dynamic>>();
    } catch (e) {
      throw Exception('群聊生成SSE失败: $e');
    }
  }

  /// 用户提交
  Future<ApiResponse<void>> userCommit({
    required int sessionId,
    String? content,
    int? uniqId,
  }) async {
    try {
      final response = await _httpService.post(
        '/character/group/user/commit',
        data: {
          'user_id': UserService.instance.userId,
          'session_id': sessionId,
          if (content != null) 'content': content,
          if (uniqId != null) 'uniq_id': uniqId,
        },
      );

      return ApiResponse<void>(
        code: response.code,
        msg: response.msg,
      );
    } catch (e) {
      throw Exception('用户提交失败: $e');
    }
  }

  /// 重新生成 SSE
  Stream<Map<String, dynamic>> regenerateSse({
    required int sessionId,
    int? uniqueId,
    int? replyId,
  }) {
    try {
      return _httpService.connectSSE(
        '/character/group/regenerate/sse',
        queryParameters: {
          'user_id': UserService.instance.userId,
          'session_id': sessionId.toString(),
          if (uniqueId != null) 'unique_id': uniqueId.toString(),
          if (replyId != null) 'reply_id': replyId.toString(),
        },
      ).cast<Map<String, dynamic>>();
    } catch (e) {
      throw Exception('重新生成SSE失败: $e');
    }
  }

  /// 获取记忆列表
  Future<ApiResponse<List<Map<String, dynamic>>>> retrieveMemoryList({
    int? maxItems,
    int? currentPage,
  }) async {
    try {
      final response = await _httpService.post(
        '/character/memory/list',
        data: {
          'user_id': UserService.instance.userId,
          if (maxItems != null) 'limit': maxItems,
          if (currentPage != null) 'page_no': currentPage,
        },
        fromJsonT: (data) {
          if (data is List) {
            return data.cast<Map<String, dynamic>>();
          } else {
            Log.instance.logger.w('获取记忆列表返回的数据格式不正确: [${data.runtimeType}]');
            return <Map<String, dynamic>>[];
          }
        },
      );

      return ApiResponse<List<Map<String, dynamic>>>(
        code: response.code,
        msg: response.msg,
        result: response.result as List<Map<String, dynamic>>?,
      );
    } catch (e) {
      throw Exception('获取记忆列表失败: $e');
    }
  }
}

class GroupRelationship {
  final String character1;
  final String character2;
  final String relationship;

  const GroupRelationship({
    required this.character1,
    required this.character2,
    required this.relationship,
  });

  Map<String, dynamic> toJson() {
    return {
      'character1': character1,
      'character2': character2,
      'relationship': relationship,
    };
  }

  factory GroupRelationship.fromJson(Map<String, dynamic> json) {
    return GroupRelationship(
      character1: json['character1'] as String,
      character2: json['character2'] as String,
      relationship: json['relationship'] as String,
    );
  }
}

class GroupGreeting {
  final String speaker;
  final String content;

  const GroupGreeting({
    required this.speaker,
    required this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      'speaker': speaker,
      'content': content,
    };
  }

  factory GroupGreeting.fromJson(Map<String, dynamic> json) {
    return GroupGreeting(
      speaker: json['speaker'] as String,
      content: json['content'] as String,
    );
  }
}

class GroupUserCommitResponse {
  final bool success;
  final String? message;

  const GroupUserCommitResponse({
    required this.success,
    this.message,
  });

  factory GroupUserCommitResponse.fromJson(Map<String, dynamic> json) {
    return GroupUserCommitResponse(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      if (message != null) 'message': message,
    };
  }
}

class GroupGenerateResponse {
  final String type;
  final String? content;
  final String? speaker;
  final int? uniqId;

  const GroupGenerateResponse({
    required this.type,
    this.content,
    this.speaker,
    this.uniqId,
  });

  factory GroupGenerateResponse.fromJson(Map<String, dynamic> json) {
    return GroupGenerateResponse(
      type: json['type'] as String,
      content: json['content'] as String?,
      speaker: json['speaker'] as String?,
      uniqId: json['uniq_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      if (content != null) 'content': content,
      if (speaker != null) 'speaker': speaker,
      if (uniqId != null) 'uniq_id': uniqId,
    };
  }
}

class GroupMigrateResponse {
  final int sessionId;
  final String status;

  const GroupMigrateResponse({
    required this.sessionId,
    required this.status,
  });

  factory GroupMigrateResponse.fromJson(Map<String, dynamic> json) {
    return GroupMigrateResponse(
      sessionId: json['session_id'] as int,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'session_id': sessionId,
      'status': status,
    };
  }
}
