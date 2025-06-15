import './chat_message.dart'; // 添加导入
import '../util/log.dart';

/// 聊天会话数据模型
class ChatSession {
  /// 会话ID
  final int id;

  /// 用户ID
  final int userId;

  /// 角色ID
  final int characterId;

  /// 会话状态
  final String? status;

  /// 创建时间
  final String? createdAt;

  /// 更新时间
  final String? updatedAt;

  /// 最后消息时间
  final String? lastMessageAt;

  /// 是否为最新聊天
  final bool? latestChat;

  /// 个人ID (用途待确认)
  final int? personalId;

  /// 自定义配置 (用途待确认)
  final Map<String, dynamic>? customProfile;

  /// 聊天消息列表
  final List<ChatMessage>? messages; // 修改为 messages

  const ChatSession({
    required this.id,
    required this.userId,
    required this.characterId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.lastMessageAt,
    this.latestChat,
    this.personalId,
    this.customProfile,
    this.messages, // 修改为 messages
  });

  /// 从JSON创建实例
  factory ChatSession.fromJson(Map<String, dynamic> json) {
    Log.instance.logger.d('ChatSession.fromJson 开始解析: ${json['context']}');

    // 从 'context' 字段解析聊天消息
    List<ChatMessage>? chatMessages;
    if (json['context'] != null && json['context'] is List) {
      Log.instance.logger
          .d('解析 context 字段，消息数量: ${(json['context'] as List).length}');
      chatMessages = (json['context'] as List)
          .map((item) => ChatMessage.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      Log.instance.logger.d('context 字段为空或不是列表类型');
    }

    final session = ChatSession(
      id: json['session_id'] is int ? json['session_id'] : 0, // 对应 session_id
      userId: json['user_id'] is int
          ? json['user_id']
          : (json['custom_profile']?['user_id'] ?? 0), // 尝试从 custom_profile 获取
      characterId: json['character_id'] is int
          ? json['character_id']
          : 0, // 假设 character_id 存在于顶层或需要确认来源
      status: json['status'] is String ? json['status'] : null,
      createdAt: json['created_at'] is String ? json['created_at'] : null,
      updatedAt: json['updated_at'] is String ? json['updated_at'] : null,
      lastMessageAt:
          json['last_message_at'] is String ? json['last_message_at'] : null,
      latestChat: json['latest_chat'] is bool ? json['latest_chat'] : null,
      personalId: json['personal_id'] is int ? json['personal_id'] : null,
      customProfile: json['custom_profile'] is Map<String, dynamic>
          ? json['custom_profile']
          : null,
      messages: chatMessages, // 使用解析后的消息
    );

    Log.instance.logger.d(
        'ChatSession.fromJson 解析完成: sessionId=${session.id}, userId=${session.userId}, characterId=${session.characterId}, messagesCount=${session.messages?.length ?? 0}');

    return session;
  }

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'character_id': characterId,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'last_message_at': lastMessageAt,
      'latest_chat': latestChat,
      'personal_id': personalId,
      'custom_profile': customProfile,
      // 注意：'context' 字段通常用于API请求，而不是本地存储或序列化。
      // 如果需要将 messages 转换回 'context'，需要在此处添加逻辑。
      'messages': messages?.map((m) => m.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'ChatSession(id: $id, userId: $userId, characterId: $characterId, messages: ${messages?.length ?? 0})';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ChatSession && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
