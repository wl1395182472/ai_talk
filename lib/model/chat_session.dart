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

  const ChatSession({
    required this.id,
    required this.userId,
    required this.characterId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.lastMessageAt,
  });

  /// 从JSON创建实例
  factory ChatSession.fromJson(Map<String, dynamic> json) {
    return ChatSession(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      characterId: json['character_id'] as int,
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      lastMessageAt: json['last_message_at'] as String?,
    );
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
    };
  }

  @override
  String toString() {
    return 'ChatSession(id: $id, userId: $userId, characterId: $characterId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ChatSession && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
