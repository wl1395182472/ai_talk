/// 聊天消息数据模型
class ChatMessage {
  /// 消息ID
  final int? id;

  /// 会话ID
  final int? sessionId;

  /// 用户ID
  final int? userId;

  /// 角色ID
  final int? characterId;

  /// 消息内容
  final String content;

  /// 消息类型 (user/assistant)
  final String type;

  /// 创建时间
  final String? createdAt;

  /// 更新时间
  final String? updatedAt;

  const ChatMessage({
    this.id,
    this.sessionId,
    this.userId,
    this.characterId,
    required this.content,
    required this.type,
    this.createdAt,
    this.updatedAt,
  });

  /// 从JSON创建实例
  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'] as int?,
      sessionId: json['session_id'] as int?,
      userId: json['user_id'] as int?,
      characterId: json['character_id'] as int?,
      content: json['content'] as String,
      type: json['type'] as String,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'session_id': sessionId,
      'user_id': userId,
      'character_id': characterId,
      'content': content,
      'type': type,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  @override
  String toString() {
    return 'ChatMessage(id: $id, type: $type, content: $content)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ChatMessage && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
