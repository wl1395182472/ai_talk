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
      groupId: json['group_id'] is int ? json['group_id'] : 0,
      createrId: json['creater_id'] is int ? json['creater_id'] : 0,
      characterIds: json['character_ids'] is List
          ? List<int>.from((json['character_ids'] as List).map((item) =>
              item is int ? item : (int.tryParse(item.toString()) ?? 0)))
          : [],
      title: json['title'] is String ? json['title'] : '',
      cover: json['cover'] is String ? json['cover'] : '',
      sessionId: json['session_id'] is int ? json['session_id'] : null,
      ext: json['ext'] is String ? json['ext'] : null,
      characters: (json['characters'] is List<dynamic>
          ? (json['characters'] as List<dynamic>)
              .map((e) => e is Map<String, dynamic>
                  ? GroupCharacter.fromJson(e)
                  : GroupCharacter(
                      characterId: 0,
                      createrId: 0,
                      name: '',
                      avatar: '',
                      background: '',
                      shortDescription: '',
                      charge: 0,
                      isPurchase: false,
                      needToPurchase: false,
                    ))
              .toList()
          : <GroupCharacter>[]),
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
      characterId: json['character_id'] is int ? json['character_id'] : 0,
      createrId: json['creater_id'] is int ? json['creater_id'] : 0,
      name: json['name'] is String ? json['name'] : '',
      avatar: json['avatar'] is String ? json['avatar'] : '',
      background: json['background'] is String ? json['background'] : '',
      shortDescription:
          json['short_description'] is String ? json['short_description'] : '',
      charge: json['charge'] is int ? json['charge'] : 0,
      isPurchase: json['is_purchase'] is bool ? json['is_purchase'] : false,
      needToPurchase:
          json['need_to_purchase'] is bool ? json['need_to_purchase'] : false,
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
