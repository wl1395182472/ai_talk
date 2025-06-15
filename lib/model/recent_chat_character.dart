/// 最近聊天角色数据模型
class RecentChatCharacter {
  /// 角色ID
  final int characterId;

  /// 会话ID
  final int sessionId;

  /// 角色名称
  final String name;

  /// 角色外观描述
  final String appearance;

  /// 头像URL
  final String avatar;

  /// 简短描述
  final String shortDescription;

  /// 背景图片URL
  final String? background;

  /// 创建者ID
  final int createrId;

  /// 创建者名称
  final String creater;

  /// 收费金额
  final int charge;

  /// 是否已发布
  final int isReleased;

  /// 网页可见性
  final int visibleWeb;

  /// 应用可见性
  final int visibleApp;

  /// 可见性
  final int visibility;

  /// 游客可见性
  final int guestVisibility;

  /// 游客应用可见性
  final int guestVisibilityApp;

  /// 背景可见性
  final int visibileBackground;

  /// 是否收藏
  final bool isCollect;

  /// 是否购买
  final bool isPurchase;

  /// 是否点赞
  final bool isStar;

  const RecentChatCharacter({
    required this.characterId,
    required this.sessionId,
    required this.name,
    required this.appearance,
    required this.avatar,
    required this.shortDescription,
    this.background,
    required this.createrId,
    required this.creater,
    required this.charge,
    required this.isReleased,
    required this.visibleWeb,
    required this.visibleApp,
    required this.visibility,
    required this.guestVisibility,
    required this.guestVisibilityApp,
    required this.visibileBackground,
    required this.isCollect,
    required this.isPurchase,
    required this.isStar,
  });

  /// 从JSON创建实例
  factory RecentChatCharacter.fromJson(Map<String, dynamic> json) {
    return RecentChatCharacter(
      characterId: json['character_id'] is int ? json['character_id'] : 0,
      sessionId: json['session_id'] is int ? json['session_id'] : 0,
      name: json['name'] is String ? json['name'] : '',
      appearance: json['appearance'] is String ? json['appearance'] : '',
      avatar: json['avatar'] is String ? json['avatar'] : '',
      shortDescription:
          json['short_description'] is String ? json['short_description'] : '',
      background: json['background'] is String ? json['background'] : null,
      createrId: json['creater_id'] is int ? json['creater_id'] : 0,
      creater: json['creater'] is String ? json['creater'] : '',
      charge: json['charge'] is int ? json['charge'] : 0,
      isReleased: json['is_released'] is int ? json['is_released'] : 0,
      visibleWeb: json['visible_web'] is int ? json['visible_web'] : 0,
      visibleApp: json['visible_app'] is int ? json['visible_app'] : 0,
      visibility: json['visibility'] is int ? json['visibility'] : 0,
      guestVisibility:
          json['guest_visibility'] is int ? json['guest_visibility'] : 0,
      guestVisibilityApp: json['guest_visibility_app'] is int
          ? json['guest_visibility_app']
          : 0,
      visibileBackground:
          json['visibile_background'] is int ? json['visibile_background'] : 0,
      isCollect: json['is_collect'] is bool ? json['is_collect'] : false,
      isPurchase: json['is_purchase'] is bool ? json['is_purchase'] : false,
      isStar: json['is_star'] is bool ? json['is_star'] : false,
    );
  }

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'character_id': characterId,
      'session_id': sessionId,
      'name': name,
      'appearance': appearance,
      'avatar': avatar,
      'short_description': shortDescription,
      'background': background,
      'creater_id': createrId,
      'creater': creater,
      'charge': charge,
      'is_released': isReleased,
      'visible_web': visibleWeb,
      'visible_app': visibleApp,
      'visibility': visibility,
      'guest_visibility': guestVisibility,
      'guest_visibility_app': guestVisibilityApp,
      'visibile_background': visibileBackground,
      'is_collect': isCollect,
      'is_purchase': isPurchase,
      'is_star': isStar,
    };
  }

  @override
  String toString() {
    return 'RecentChatCharacter(characterId: $characterId, sessionId: $sessionId, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RecentChatCharacter &&
        other.characterId == characterId &&
        other.sessionId == sessionId;
  }

  @override
  int get hashCode => characterId.hashCode ^ sessionId.hashCode;
}
