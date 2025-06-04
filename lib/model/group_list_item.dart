/// 群聊列表项数据模型
class GroupListItem {
  final int groupId;
  final int createrId;
  final List<int> characterIds;
  final String title;
  final String cover;
  final int? sessionId;
  final String? ext;
  final List<GroupCharacter> characters;

  GroupListItem({
    required this.groupId,
    required this.createrId,
    required this.characterIds,
    required this.title,
    required this.cover,
    this.sessionId,
    this.ext,
    required this.characters,
  });

  factory GroupListItem.fromJson(Map<String, dynamic> json) {
    return GroupListItem(
      groupId: json['group_id'] as int,
      createrId: json['creater_id'] as int,
      characterIds: List<int>.from(json['character_ids'] as List),
      title: json['title'] as String,
      cover: json['cover'] as String? ?? '',
      sessionId: json['session_id'] as int?,
      ext: json['ext'] as String?,
      characters: (json['characters'] as List<dynamic>?)
              ?.map((e) => GroupCharacter.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'group_id': groupId,
      'creater_id': createrId,
      'character_ids': characterIds,
      'title': title,
      'cover': cover,
      if (sessionId != null) 'session_id': sessionId,
      if (ext != null) 'ext': ext,
      'characters': characters.map((e) => e.toJson()).toList(),
    };
  }
}

/// 群聊中的角色信息
class GroupCharacter {
  final int characterId;
  final int createrId;
  final String name;
  final String avatar;
  final String background;
  final String shortDescription;
  final int charge;
  final bool isPurchase;
  final bool needToPurchase;

  GroupCharacter({
    required this.characterId,
    required this.createrId,
    required this.name,
    required this.avatar,
    required this.background,
    required this.shortDescription,
    required this.charge,
    required this.isPurchase,
    required this.needToPurchase,
  });

  factory GroupCharacter.fromJson(Map<String, dynamic> json) {
    return GroupCharacter(
      characterId: json['character_id'] as int,
      createrId: json['creater_id'] as int,
      name: json['name'] as String,
      avatar: json['avatar'] as String? ?? '',
      background: json['background'] as String? ?? '',
      shortDescription: json['short_description'] as String? ?? '',
      charge: json['charge'] as int? ?? 0,
      isPurchase: json['is_purchase'] as bool? ?? false,
      needToPurchase: json['need_to_purchase'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'character_id': characterId,
      'creater_id': createrId,
      'name': name,
      'avatar': avatar,
      'background': background,
      'short_description': shortDescription,
      'charge': charge,
      'is_purchase': isPurchase,
      'need_to_purchase': needToPurchase,
    };
  }
}
