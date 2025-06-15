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
      name: json['name'] is String ? json['name'] : '',
      description: json['description'] is String ? json['description'] : null,
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
      id: json['id'] is String ? json['id'] : '',
      name: json['name'] is String ? json['name'] : '',
      language: json['language'] is String ? json['language'] : null,
      gender: json['gender'] is String ? json['gender'] : null,
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
  final String background;
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
    this.background = '',
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
      characterId: json['character_id'] is int ? json['character_id'] : 0,
      avatar: json['avatar'] is String ? json['avatar'] : '',
      appearance: json['appearance'] is String ? json['appearance'] : '',
      background: json['background'] is String ? json['background'] : '',
      name: json['name'] is String ? json['name'] : '',
      greeting: json['greeting'] is String ? json['greeting'] : '',
      longDescription:
          json['long_description'] is String ? json['long_description'] : '',
      shortDescription:
          json['short_description'] is String ? json['short_description'] : '',
      tags: tag is String
          ? tag.isNotEmpty
              ? tag.split(',')
              : []
          : tag is List
              ? List<String>.from(tag.map((item) => item is String ? item : ''))
              : [],
      voice: json['voice'] is String ? json['voice'] : '',
      context: json['context'] is List
          ? List<Map<String, dynamic>>.from(
              (json['context'] as List).map(
                (item) =>
                    item is Map<String, dynamic> ? item : <String, dynamic>{},
              ),
            )
          : null,
      params: json['params'] is Map<String, dynamic> ? json['params'] : null,
      lang: json['lang'] is String ? json['lang'] : null,
      charge: json['charge'] is int ? json['charge'] : 0,
      sex: json['sex'] is String ? json['sex'] : '',
      style: json['style'] is String ? json['style'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'character_id': characterId,
      'avatar': avatar,
      'appearance': appearance,
      'background': background,
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
      sessionId: json['session_id'] is int ? json['session_id'] : 0,
      characterId: json['character_id'] is int ? json['character_id'] : 0,
      userId: json['user_id'] is int ? json['user_id'] : 0,
      createdAt: json['created_at'] is String
          ? (DateTime.tryParse(json['created_at']) ?? DateTime.now())
          : DateTime.now(),
      updatedAt: json['updated_at'] is String
          ? DateTime.tryParse(json['updated_at'])
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
      id: json['id'] is int ? json['id'] : null,
      sessionId: json['session_id'] is int ? json['session_id'] : 0,
      content: json['content'] is String ? json['content'] : '',
      role: json['role'] is String ? json['role'] : '',
      timestamp: json['timestamp'] is String
          ? (DateTime.tryParse(json['timestamp']) ?? DateTime.now())
          : DateTime.now(),
      audioUrl: json['audio_url'] is String ? json['audio_url'] : null,
      imageUrl: json['image_url'] is String ? json['image_url'] : null,
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
