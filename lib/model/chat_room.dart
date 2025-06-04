/// 群聊信息
class ChatRoom {
  final int groupId;
  final String title;
  final String coverPrompt;
  final String cover;
  final String background;
  final String scenario;
  final List<GroupCharacter> characters;
  final List<GroupRelationship> relationship;
  final List<GroupGreeting> greetings;
  final String creater;
  final int? createrId;
  final int? genCount;
  final bool isReleased;
  final int reviewLevel;
  final List<int> characterIds;

  ChatRoom({
    required this.groupId,
    required this.title,
    required this.coverPrompt,
    required this.cover,
    required this.background,
    required this.scenario,
    required this.characters,
    required this.relationship,
    required this.greetings,
    required this.creater,
    this.createrId,
    this.genCount,
    this.isReleased = false,
    this.reviewLevel = 0,
    required this.characterIds,
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    final allCharacterIds = json['all_character_ids'];
    return ChatRoom(
      groupId: json['group_id'] ?? 0,
      title: json['title'] ?? '',
      coverPrompt: json['cover_prompt'] ?? '',
      cover: json['cover'] ?? '',
      background: json['background'] ?? '',
      scenario: json['scenario'],
      characters: (json['characters'] as List<dynamic>?)
              ?.map((e) => GroupCharacter.fromJson(e))
              .toList() ??
          [],
      relationship: (json['relationship'] as List<dynamic>?)
              ?.map((e) => GroupRelationship.fromJson(e))
              .toList() ??
          [],
      greetings: (json['greetings'] as List<dynamic>?)
              ?.map((e) => GroupGreeting.fromJson(e))
              .toList() ??
          [],
      creater: json['creater'] ?? '',
      createrId: json['creater_id'],
      genCount: json['gen_count'],
      isReleased: json['is_released'] == 1,
      reviewLevel: json['review_level'] ?? 0,
      characterIds: allCharacterIds is String
          ? allCharacterIds.isNotEmpty
              ? allCharacterIds
                  .split(',')
                  .map((e) => int.tryParse(e) ?? 0)
                  .toList()
              : []
          : allCharacterIds is List<dynamic>
              ? allCharacterIds
                  .map((value) => value is String
                      ? int.tryParse(value) ?? 0
                      : (value is int ? value : 0))
                  .toList()
              : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'group_id': groupId,
      'title': title,
      'cover_prompt': coverPrompt,
      'cover': cover,
      'background': background,
      'scenario': scenario,
      'characters': characters.map((e) => e.toJson()).toList(),
      'relationship': relationship.map((e) => e.toJson()).toList(),
      'greetings': greetings.map((e) => e.toJson()).toList(),
      'creater': creater,
      'creater_id': createrId,
      'gen_count': genCount,
      'is_released': isReleased ? 1 : 0,
      'review_level': reviewLevel,
      'character_ids': characterIds,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

/// 群聊角色信息
class GroupCharacter {
  final int characterId;
  final String name;
  final String avatar;
  final String? background;
  final int charge;
  final bool isPurchase;
  final bool needToPurchase;

  GroupCharacter({
    required this.characterId,
    required this.name,
    required this.avatar,
    this.background,
    required this.charge,
    required this.isPurchase,
    required this.needToPurchase,
  });

  factory GroupCharacter.fromJson(Map<String, dynamic> json) {
    return GroupCharacter(
      characterId: json['character_id'] ?? 0,
      name: json['name'] ?? '',
      avatar: json['avatar'] ?? '',
      background: json['background'],
      charge: json['charge'] ?? 0,
      isPurchase: json['is_purchase'] ?? false,
      needToPurchase: json['need_to_purchase'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'character_id': characterId,
      'name': name,
      'avatar': avatar,
      'background': background,
      'charge': charge,
      'is_purchase': isPurchase,
      'need_to_purchase': needToPurchase,
    };
  }
}

/// 群聊角色关系
class GroupRelationship {
  final int char1Id;
  final int char2Id;
  final String detail;
  final String? id;

  GroupRelationship({
    required this.char1Id,
    required this.char2Id,
    required this.detail,
    this.id,
  });

  factory GroupRelationship.fromJson(Map<String, dynamic> json) {
    return GroupRelationship(
      char1Id: json['char1_id'] ?? 0,
      char2Id: json['char2_id'] ?? 0,
      detail: json['detail'] ?? '',
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'char1_id': char1Id,
      'char2_id': char2Id,
      'detail': detail,
      'id': id,
    };
  }
}

/// 群聊问候语
class GroupGreeting {
  final int characterId;
  final String greeting;

  GroupGreeting({
    required this.characterId,
    required this.greeting,
  });

  factory GroupGreeting.fromJson(Map<String, dynamic> json) {
    return GroupGreeting(
      characterId: json['character_id'] ?? 0,
      greeting: json['greeting'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'character_id': characterId,
      'greeting': greeting,
    };
  }
}

/// 群聊会话信息
class GroupSession {
  final int sessionId;
  final bool isLatest;
  final GroupCustomProfile? customProfile;
  final List<GroupContent> context;
  final GroupExtension? extion;
  final String? timestamp;
  final bool isGenerate;

  GroupSession({
    required this.sessionId,
    required this.isLatest,
    this.customProfile,
    required this.context,
    this.extion,
    this.timestamp,
    required this.isGenerate,
  });

  factory GroupSession.fromJson(Map<String, dynamic> json) {
    return GroupSession(
      sessionId: json['session_id'] ?? 0,
      isLatest: json['is_latest'] ?? false,
      customProfile: json['custom_profile'] != null
          ? GroupCustomProfile.fromJson(json['custom_profile'])
          : null,
      context: (json['context'] as List<dynamic>?)
              ?.map((e) => GroupContent.fromJson(e))
              .toList() ??
          [],
      extion: json['extion'] != null
          ? GroupExtension.fromJson(json['extion'])
          : null,
      timestamp: json['timestamp'],
      isGenerate: json['is_generate'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'session_id': sessionId,
      'is_latest': isLatest,
      'custom_profile': customProfile?.toJson(),
      'context': context.map((e) => e.toJson()).toList(),
      'extion': extion?.toJson(),
      'timestamp': timestamp,
      'is_generate': isGenerate,
    };
  }
}

/// 群聊自定义资料
class GroupCustomProfile {
  final String? avatar;
  final String? username;
  final int? age;
  final String? sex;

  GroupCustomProfile({
    this.avatar,
    this.username,
    this.age,
    this.sex,
  });

  factory GroupCustomProfile.fromJson(Map<String, dynamic> json) {
    return GroupCustomProfile(
      avatar: json['avatar'],
      username: json['username'],
      age: json['age'],
      sex: json['sex'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'avatar': avatar,
      'username': username,
      'age': age,
      'sex': sex,
    };
  }
}

/// 群聊内容
class GroupContent {
  final int idx;
  final String name;
  final String timestamp;
  final String? audio;
  final String? image;
  final String? imageFromApp;
  final String? targetMessage;
  final String? targetLang;
  final String content;
  final String? characterId;
  final String? replyId;
  final int? uniqId;

  GroupContent({
    required this.idx,
    required this.name,
    required this.timestamp,
    this.audio,
    this.image,
    this.imageFromApp,
    this.targetMessage,
    this.targetLang,
    required this.content,
    this.characterId,
    this.replyId,
    this.uniqId,
  });

  factory GroupContent.fromJson(Map<String, dynamic> json) {
    return GroupContent(
      idx: json['idx'] ?? 0,
      name: json['name'] ?? '',
      timestamp: json['timestamp'] ?? '',
      audio: json['audio'],
      image: json['image'],
      imageFromApp: json['image_from_app'],
      targetMessage: json['target_message'],
      targetLang: json['target_lang'],
      content: json['content'] ?? '',
      characterId: json['character_id']?.toString(),
      replyId: json['reply_id']?.toString(),
      uniqId: json['uniq_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idx': idx,
      'name': name,
      'timestamp': timestamp,
      'audio': audio,
      'image': image,
      'image_from_app': imageFromApp,
      'target_message': targetMessage,
      'target_lang': targetLang,
      'content': content,
      'character_id': characterId,
      'reply_id': replyId,
      'uniq_id': uniqId,
    };
  }
}

/// 群聊扩展信息
class GroupExtension {
  final int? groupId;
  final String? title;
  final String? scenario;
  final List<GroupRelationship> relationship;
  final List<int> characterIds;
  final int? tokensScenario;
  final int? tokensRelationship;
  final List<GroupCharacter> characters;
  final String? background;

  GroupExtension({
    this.groupId,
    this.title,
    this.scenario,
    required this.relationship,
    required this.characterIds,
    this.tokensScenario,
    this.tokensRelationship,
    required this.characters,
    this.background,
  });

  factory GroupExtension.fromJson(Map<String, dynamic> json) {
    return GroupExtension(
      groupId: json['group_id'],
      title: json['title'],
      scenario: json['scenario'],
      relationship: (json['relationship'] as List<dynamic>?)
              ?.map((e) => GroupRelationship.fromJson(e))
              .toList() ??
          [],
      characterIds: (json['character_ids'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          [],
      tokensScenario: json['tokens_scenario'],
      tokensRelationship: json['tokens_relationship'],
      characters: (json['characters'] as List<dynamic>?)
              ?.map((e) => GroupCharacter.fromJson(e))
              .toList() ??
          [],
      background: json['background'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'group_id': groupId,
      'title': title,
      'scenario': scenario,
      'relationship': relationship.map((e) => e.toJson()).toList(),
      'character_ids': characterIds,
      'tokens_scenario': tokensScenario,
      'tokens_relationship': tokensRelationship,
      'characters': characters.map((e) => e.toJson()).toList(),
      'background': background,
    };
  }
}

/// 群聊生成响应
class GroupGenerateResponse {
  final int sessionId;
  final int idx;
  final bool done;
  final String? content;
  final String? targetMessage;
  final String? targetLang;
  final int? uniqId;
  final List<GroupGenerateContent>? contents;

  GroupGenerateResponse({
    required this.sessionId,
    required this.idx,
    required this.done,
    this.content,
    this.targetMessage,
    this.targetLang,
    this.uniqId,
    this.contents,
  });

  factory GroupGenerateResponse.fromJson(Map<String, dynamic> json) {
    return GroupGenerateResponse(
      sessionId: json['session_id'] ?? 0,
      idx: json['idx'] ?? 0,
      done: json['done'] ?? false,
      content: json['content'],
      targetMessage: json['target_message'],
      targetLang: json['target_lang'],
      uniqId: json['uniq_id'],
      contents: (json['contents'] as List<dynamic>?)
          ?.map((e) => GroupGenerateContent.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'session_id': sessionId,
      'idx': idx,
      'done': done,
      'content': content,
      'target_message': targetMessage,
      'target_lang': targetLang,
      'uniq_id': uniqId,
      'contents': contents?.map((e) => e.toJson()).toList(),
    };
  }
}

/// 群聊生成内容
class GroupGenerateContent {
  final String content;
  final String targetMessage;
  final String targetLang;

  GroupGenerateContent({
    required this.content,
    required this.targetMessage,
    required this.targetLang,
  });

  factory GroupGenerateContent.fromJson(Map<String, dynamic> json) {
    return GroupGenerateContent(
      content: json['content'] ?? '',
      targetMessage: json['target_message'] ?? '',
      targetLang: json['target_lang'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'target_message': targetMessage,
      'target_lang': targetLang,
    };
  }
}

/// 用户提交内容响应
class GroupUserCommitResponse {
  final int userUniqId;
  final int idx;

  GroupUserCommitResponse({
    required this.userUniqId,
    required this.idx,
  });

  factory GroupUserCommitResponse.fromJson(Map<String, dynamic> json) {
    return GroupUserCommitResponse(
      userUniqId: json['user_uniq_id'] ?? 0,
      idx: json['idx'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_uniq_id': userUniqId,
      'idx': idx,
    };
  }
}

/// 群聊迁移响应
class GroupMigrateResponse {
  final int groupId;
  final int sessionId;

  GroupMigrateResponse({
    required this.groupId,
    required this.sessionId,
  });

  factory GroupMigrateResponse.fromJson(Map<String, dynamic> json) {
    return GroupMigrateResponse(
      groupId: json['group_id'] ?? 0,
      sessionId: json['session_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'group_id': groupId,
      'session_id': sessionId,
    };
  }
}
