class User {
  final int userId;
  final String username;
  final int level;
  final String type;
  final String email;
  final String? relatedEmail;
  final int age;
  final String sex;
  final String avatar;
  final int inviterId;
  final String inviteCode;
  final int inviteCount;
  final String registeTime;
  final String lastLoginTime;
  final int totalAmount;
  final int totalSubscribeAmount;
  final int availableAmount;
  final int withdrawAmount;
  final int pendingWithdrawAmount;
  final String? vipExpireTime;
  final int isSubscribe;
  final int freeToken;
  final int tokenBalance;
  final String? subscriptionId;
  final String? stripeUserId;
  final String? stripeSubscriptionId;
  final int superiorAgent1Id;
  final int superiorAgent2Id;
  final String utmSource;
  final int patreonId;
  final String? appleSubscriptionId;
  final String? googleSubscriptionId;
  final String subscriptionPayChannel;
  final String? googleSubscriptionReceipt;
  final int isSubscribeToken;
  final String? deletedDate;
  final int deleted;
  final int tokenByInvite;
  final bool isBindEmail;
  final int rechargeToken;
  final int totalProfit;
  final int followCount;
  final int followersCount;
  final int popularity;
  final bool createWorldPermission;

  User({
    required this.userId,
    required this.username,
    required this.level,
    required this.type,
    required this.email,
    this.relatedEmail,
    required this.age,
    required this.sex,
    required this.avatar,
    required this.inviterId,
    required this.inviteCode,
    required this.inviteCount,
    required this.registeTime,
    required this.lastLoginTime,
    required this.totalAmount,
    required this.totalSubscribeAmount,
    required this.availableAmount,
    required this.withdrawAmount,
    required this.pendingWithdrawAmount,
    this.vipExpireTime,
    required this.isSubscribe,
    required this.freeToken,
    required this.tokenBalance,
    this.subscriptionId,
    this.stripeUserId,
    this.stripeSubscriptionId,
    required this.superiorAgent1Id,
    required this.superiorAgent2Id,
    required this.utmSource,
    required this.patreonId,
    this.appleSubscriptionId,
    this.googleSubscriptionId,
    required this.subscriptionPayChannel,
    this.googleSubscriptionReceipt,
    required this.isSubscribeToken,
    this.deletedDate,
    required this.deleted,
    required this.tokenByInvite,
    required this.isBindEmail,
    required this.rechargeToken,
    required this.totalProfit,
    required this.followCount,
    required this.followersCount,
    required this.popularity,
    required this.createWorldPermission,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'] ?? 0,
      username: json['username'] ?? '',
      level: json['level'] ?? 0,
      type: json['type'] ?? '',
      email: json['email'] ?? '',
      relatedEmail: json['related_email'],
      age: json['age'] ?? 0,
      sex: json['sex'] ?? '',
      avatar: json['avatar'] ?? '',
      inviterId: json['inviter_id'] ?? 0,
      inviteCode: json['invite_code'] ?? '',
      inviteCount: json['invite_count'] ?? 0,
      registeTime: json['registe_time'] ?? '',
      lastLoginTime: json['last_login_time'] ?? '',
      totalAmount: json['total_amount'] ?? 0,
      totalSubscribeAmount: json['total_subscribe_amount'] ?? 0,
      availableAmount: json['available_amount'] ?? 0,
      withdrawAmount: json['withdraw_amount'] ?? 0,
      pendingWithdrawAmount: json['pending_withdraw_amount'] ?? 0,
      vipExpireTime: json['vip_expire_time'],
      isSubscribe: json['is_subscribe'] ?? 0,
      freeToken: json['free_token'] ?? 0,
      tokenBalance: json['token_balance'] ?? 0,
      subscriptionId: json['subscription_id'],
      stripeUserId: json['stripe_user_id'],
      stripeSubscriptionId: json['stripe_subscription_id'],
      superiorAgent1Id: json['superior_agent1_id'] ?? 0,
      superiorAgent2Id: json['superior_agent2_id'] ?? 0,
      utmSource: json['utm_source'] ?? '',
      patreonId: json['patreon_id'] ?? 0,
      appleSubscriptionId: json['apple_subscription_id'],
      googleSubscriptionId: json['google_subscription_id'],
      subscriptionPayChannel: json['subscription_pay_channel'] ?? '',
      googleSubscriptionReceipt: json['google_subscription_receipt'],
      isSubscribeToken: json['is_subscribe_token'] ?? 0,
      deletedDate: json['deleted_date'],
      deleted: json['deleted'] ?? 0,
      tokenByInvite: json['token_by_invite'] ?? 0,
      isBindEmail: json['is_bind_email'] ?? false,
      rechargeToken: json['recharge_token'] ?? 0,
      totalProfit: json['total_profit'] ?? 0,
      followCount: json['follow_count'] ?? 0,
      followersCount: json['followers_count'] ?? 0,
      popularity: json['popularity'] ?? 0,
      createWorldPermission: json['create_world_permission'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'username': username,
        'level': level,
        'type': type,
        'email': email,
        'related_email': relatedEmail,
        'age': age,
        'sex': sex,
        'avatar': avatar,
        'inviter_id': inviterId,
        'invite_code': inviteCode,
        'invite_count': inviteCount,
        'registe_time': registeTime,
        'last_login_time': lastLoginTime,
        'total_amount': totalAmount,
        'total_subscribe_amount': totalSubscribeAmount,
        'available_amount': availableAmount,
        'withdraw_amount': withdrawAmount,
        'pending_withdraw_amount': pendingWithdrawAmount,
        'vip_expire_time': vipExpireTime,
        'is_subscribe': isSubscribe,
        'free_token': freeToken,
        'token_balance': tokenBalance,
        'subscription_id': subscriptionId,
        'stripe_user_id': stripeUserId,
        'stripe_subscription_id': stripeSubscriptionId,
        'superior_agent1_id': superiorAgent1Id,
        'superior_agent2_id': superiorAgent2Id,
        'utm_source': utmSource,
        'patreon_id': patreonId,
        'apple_subscription_id': appleSubscriptionId,
        'google_subscription_id': googleSubscriptionId,
        'subscription_pay_channel': subscriptionPayChannel,
        'google_subscription_receipt': googleSubscriptionReceipt,
        'is_subscribe_token': isSubscribeToken,
        'deleted_date': deletedDate,
        'deleted': deleted,
        'token_by_invite': tokenByInvite,
        'is_bind_email': isBindEmail,
        'recharge_token': rechargeToken,
        'total_profit': totalProfit,
        'follow_count': followCount,
        'followers_count': followersCount,
        'popularity': popularity,
        'create_world_permission': createWorldPermission,
      };
}
