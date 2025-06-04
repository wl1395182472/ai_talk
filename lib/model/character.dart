/// 角色标签模型
class CharacterTag {
  final String name;
  final String? description;

  const CharacterTag({
    required this.name,
    this.description,
  });

  factory CharacterTag.fromJson(Map<String, dynamic> json) {
    return CharacterTag(
      name: json['name'] as String,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
    };
  }
}

/// 角色语音模型
class CharacterVoice {
  final String id;
  final String name;
  final String? language;
  final String? gender;

  const CharacterVoice({
    required this.id,
    required this.name,
    this.language,
    this.gender,
  });

  factory CharacterVoice.fromJson(Map<String, dynamic> json) {
    return CharacterVoice(
      id: json['id'] as String,
      name: json['name'] as String,
      language: json['language'] as String?,
      gender: json['gender'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'language': language,
      'gender': gender,
    };
  }
}

/// 角色模型
class Character {
  final int characterId;
  final String avatar;
  final String appearance;
  final String name;
  final String greeting;
  final String longDescription;
  final String shortDescription;
  final List<String>? tags;
  final String voice;
  final List<Map<String, dynamic>>? context;
  final Map<String, dynamic>? params;
  final String? lang;
  final int charge;
  final String sex; // Male, Female, Non-Binary
  final String? style; // anime, 2D, realistic

  const Character({
    this.characterId = 0,
    this.avatar = '',
    this.appearance = '',
    required this.name,
    this.greeting = '',
    this.longDescription = '',
    this.shortDescription = '',
    this.tags,
    this.voice = '',
    this.context,
    this.params,
    this.lang,
    required this.charge,
    required this.sex,
    this.style,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    final tag = json['tags'];
    return Character(
      characterId: json['character_id'] ?? 0,
      avatar: json['avatar'] ?? '',
      appearance: json['appearance'] ?? '',
      name: json['name'] ?? '',
      greeting: json['greeting'] ?? '',
      longDescription: json['long_description'] ?? '',
      shortDescription: json['short_description'] ?? '',
      tags: tag is String
          ? tag.isNotEmpty
              ? tag.split(',')
              : []
          : tag is List<String>
              ? tag
              : [],
      voice: json['voice'] ?? '',
      context:
          (json['context'] as List<dynamic>?)?.cast<Map<String, dynamic>>(),
      params: json['params'] as Map<String, dynamic>?,
      lang: json['lang'] as String?,
      charge: json['charge'] as int,
      sex: json['sex'] as String,
      style: json['style'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'character_id': characterId,
      'avatar': avatar,
      'appearance': appearance,
      'name': name,
      'greeting': greeting,
      'long_description': longDescription,
      'short_description': shortDescription,
      'tags': tags,
      'voice': voice,
      'context': context,
      'params': params,
      'lang': lang,
      'charge': charge,
      'sex': sex,
      'style': style,
    };
  }
}

/// 聊天会话模型
class ChatSession {
  final int sessionId;
  final int characterId;
  final int userId;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const ChatSession({
    required this.sessionId,
    required this.characterId,
    required this.userId,
    required this.createdAt,
    this.updatedAt,
  });

  factory ChatSession.fromJson(Map<String, dynamic> json) {
    return ChatSession(
      sessionId: json['session_id'] as int,
      characterId: json['character_id'] as int,
      userId: json['user_id'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'session_id': sessionId,
      'character_id': characterId,
      'user_id': userId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

/// 聊天消息模型
class ChatMessage {
  final int? id;
  final int sessionId;
  final String content;
  final String role; // user, assistant
  final DateTime timestamp;
  final String? audioUrl;
  final String? imageUrl;

  const ChatMessage({
    this.id,
    required this.sessionId,
    required this.content,
    required this.role,
    required this.timestamp,
    this.audioUrl,
    this.imageUrl,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'] as int?,
      sessionId: json['session_id'] as int,
      content: json['content'] as String,
      role: json['role'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      audioUrl: json['audio_url'] as String?,
      imageUrl: json['image_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'session_id': sessionId,
      'content': content,
      'role': role,
      'timestamp': timestamp.toIso8601String(),
      'audio_url': audioUrl,
      'image_url': imageUrl,
    };
  }
}
