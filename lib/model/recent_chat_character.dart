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
      characterId: json['character_id'] as int,
      sessionId: json['session_id'] as int,
      name: json['name'] as String,
      appearance: json['appearance'] as String,
      avatar: json['avatar'] as String,
      shortDescription: json['short_description'] as String,
      background: json['background'] as String?,
      createrId: json['creater_id'] as int,
      creater: json['creater'] as String,
      charge: json['charge'] as int,
      isReleased: json['is_released'] as int,
      visibleWeb: json['visible_web'] as int,
      visibleApp: json['visible_app'] as int,
      visibility: json['visibility'] as int,
      guestVisibility: json['guest_visibility'] as int,
      guestVisibilityApp: json['guest_visibility_app'] as int,
      visibileBackground: json['visibile_background'] as int,
      isCollect: json['is_collect'] as bool,
      isPurchase: json['is_purchase'] as bool,
      isStar: json['is_star'] as bool,
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
