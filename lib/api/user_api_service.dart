import '../model/api_response.dart';
import '../model/user.dart';
import '../service/http_service.dart';
import '../service/user_service.dart';

/// 登录请求模型
class LoginRequest {
  final String email;
  final String verificationCode;
  final String guestClientToken;
  final String? invitationCode;

  const LoginRequest({
    required this.email,
    required this.verificationCode,
    required this.guestClientToken,
    this.invitationCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'email_valid_code': verificationCode,
      'guest_client_token': guestClientToken,
      'invitation_code': invitationCode,
    };
  }
}

/// 注册请求模型
class RegisterRequest {
  final String? email;
  final String? phone;
  final String? password;
  final String? username;
  final String? verificationCode;

  const RegisterRequest({
    this.email,
    this.phone,
    this.password,
    this.username,
    this.verificationCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone': phone,
      'password': password,
      'username': username,
      'verification_code': verificationCode,
    };
  }
}

/// 认证响应模型
class AuthResponse {
  final int userId;
  final String username;
  final int level;
  final String email;
  final String avatar;

  const AuthResponse({
    required this.userId,
    required this.username,
    required this.level,
    required this.email,
    required this.avatar,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      userId: json['user_id'] ?? 0,
      username: json['username'] ?? '',
      level: json['level'] ?? 0,
      email: json['email'] ?? '',
      avatar: json['avatar'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'username': username,
      'level': level,
      'email': email,
      'avatar': avatar,
    };
  }
}

/// 用户相关 API 服务类
class UserApiService {
  /// 单例模式实例
  static final UserApiService instance = UserApiService._privateConstructor();

  /// 工厂构造函数，返回单例实例
  factory UserApiService() => instance;

  /// 私有构造函数，防止外部实例化
  UserApiService._privateConstructor();

  final HttpService _httpService = HttpService.instance;

  /// 登录
  Future<ApiResponse<AuthResponse>> codeLogin(LoginRequest request) async {
    try {
      final response = await _httpService.post(
        '/user/code_login',
        data: request.toJson(),
        fromJsonT: (data) => AuthResponse.fromJson(data),
      );

      return ApiResponse<AuthResponse>(
        code: response.code,
        msg: response.msg,
        result: response.result as AuthResponse?,
      );
    } catch (e) {
      throw Exception('登录失败: $e');
    }
  }

  /// 注册
  Future<ApiResponse<AuthResponse>> register(RegisterRequest request) async {
    try {
      final response = await _httpService.post(
        '/user/register',
        data: request.toJson(),
        fromJsonT: (data) => AuthResponse.fromJson(data),
      );

      return ApiResponse<AuthResponse>(
        code: response.code,
        msg: response.msg,
        result: response.result as AuthResponse?,
      );
    } catch (e) {
      throw Exception('注册失败: $e');
    }
  }

  /// 发送验证码
  Future<ApiResponse<void>> sendEmailCode({
    String? email,
  }) async {
    try {
      final data = {
        'email': email,
      };

      final response = await _httpService.post(
        '/user/sendEmailCode',
        data: data,
      );

      return ApiResponse<void>(
        code: response.code,
        msg: response.msg,
        result: null,
      );
    } catch (e) {
      throw Exception('发送验证码失败: $e');
    }
  }

  /// 刷新token
  Future<ApiResponse<AuthResponse>> refreshToken({
    required String refreshToken,
  }) async {
    try {
      final response = await _httpService.post(
        '/user/refreshToken',
        data: {'refresh_token': refreshToken},
        fromJsonT: (data) => AuthResponse.fromJson(data),
      );

      return ApiResponse<AuthResponse>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('刷新token失败: $e');
    }
  }

  /// 获取用户基础信息
  Future<ApiResponse<User>> getUserBaseInfo() async {
    try {
      final response = await _httpService.post(
        '/user/getUserBaseInfo',
        data: {
          'user_id': UserService.instance.userId,
        },
        fromJsonT: (data) => User.fromJson(data),
      );
      return ApiResponse<User>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('获取用户基础信息失败: $e');
    }
  }

  /// 更新用户信息
  Future<ApiResponse<User>> updateUserInfo({
    String? username,
    String? email,
    String? avatar,
  }) async {
    try {
      final data = {
        'user_id': UserService.instance.userId,
        if (username != null) 'username': username,
        if (email != null) 'email': email,
        if (avatar != null) 'avatar': avatar,
      };

      final response = await _httpService.post(
        '/user/updateInfo',
        data: data,
        fromJsonT: (data) => User.fromJson(data),
      );

      return ApiResponse<User>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('更新用户信息失败: $e');
    }
  }

  /// 修改密码
  Future<ApiResponse<void>> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final response = await _httpService.post(
        '/user/changePassword',
        data: {
          'user_id': UserService.instance.userId,
          'old_password': oldPassword,
          'new_password': newPassword,
        },
      );

      return ApiResponse<void>(
        code: response.code,
        msg: response.msg,
        result: null,
      );
    } catch (e) {
      throw Exception('修改密码失败: $e');
    }
  }

  /// 重置密码
  Future<ApiResponse<void>> resetPassword({
    String? email,
    String? phone,
    required String newPassword,
    required String verificationCode,
  }) async {
    try {
      final data = {
        'new_password': newPassword,
        'verification_code': verificationCode,
        if (email != null) 'email': email,
        if (phone != null) 'phone': phone,
      };

      final response = await _httpService.post(
        '/user/resetPassword',
        data: data,
      );

      return ApiResponse<void>(
        code: response.code,
        msg: response.msg,
        result: null,
      );
    } catch (e) {
      throw Exception('重置密码失败: $e');
    }
  }

  /// 登出
  Future<ApiResponse<void>> logout() async {
    try {
      final response = await _httpService.post(
        '/user/logout',
        data: {
          'user_id': UserService.instance.userId,
        },
      );

      return ApiResponse<void>(
        code: response.code,
        msg: response.msg,
        result: null,
      );
    } catch (e) {
      throw Exception('登出失败: $e');
    }
  }

  /// 删除账户
  Future<ApiResponse<void>> deleteAccount({
    required String password,
  }) async {
    try {
      final response = await _httpService.post(
        '/user/deleteAccount',
        data: {
          'user_id': UserService.instance.userId,
          'password': password,
        },
      );

      return ApiResponse<void>(
        code: response.code,
        msg: response.msg,
        result: null,
      );
    } catch (e) {
      throw Exception('删除账户失败: $e');
    }
  }

  /// 邮箱登录
  Future<ApiResponse<AuthResponse>> loginByEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _httpService.post(
        '/user/loginByEmail',
        data: {
          'email': email,
          'password': password,
        },
        fromJsonT: (data) => AuthResponse.fromJson(data),
      );
      return ApiResponse<AuthResponse>(
        code: response.code,
        msg: response.msg,
        result: response.result as AuthResponse?,
      );
    } catch (e) {
      throw Exception('邮箱登录失败: $e');
    }
  }

  /// 游客登录
  Future<ApiResponse<AuthResponse>> guestLogin({
    required String deviceToken,
  }) async {
    try {
      final response = await _httpService.post(
        '/user/guest_login',
        data: {
          'device_token': deviceToken,
        },
        fromJsonT: (data) => AuthResponse.fromJson(data),
      );

      return ApiResponse<AuthResponse>(
        code: response.code,
        msg: response.msg,
        result: response.result as AuthResponse?,
      );
    } catch (e) {
      throw Exception('游客登录失败: $e');
    }
  }

  /// 执行随机登录
  Future<ApiResponse<AuthResponse>> executeRandomLogin({
    required String deviceToken,
  }) async {
    try {
      final response = await _httpService.post(
        '/user/random_login',
        data: {
          'device_token': deviceToken,
        },
        fromJsonT: (data) => AuthResponse.fromJson(data),
      );

      return ApiResponse<AuthResponse>(
        code: response.code,
        msg: response.msg,
        result: response.result as AuthResponse?,
      );
    } catch (e) {
      throw Exception('随机登录失败: $e');
    }
  }

  /// 关联用户邮箱
  Future<ApiResponse<AuthResponse>> associateEmail({
    required String deviceToken,
    required String emailAddress,
    required String accountPassword,
  }) async {
    try {
      final response = await _httpService.post(
        '/user/associate_email',
        data: {
          'device_token': deviceToken,
          'email': emailAddress,
          'password': accountPassword,
        },
        fromJsonT: (data) => AuthResponse.fromJson(data),
      );

      return ApiResponse<AuthResponse>(
        code: response.code,
        msg: response.msg,
        result: response.result as AuthResponse?,
      );
    } catch (e) {
      throw Exception('关联邮箱失败: $e');
    }
  }

  /// 使用邮箱验证码登录
  Future<ApiResponse<AuthResponse>> loginWithEmailCode({
    required String email,
    required String verificationCode,
    required String clientToken,
    required String inviteCode,
  }) async {
    try {
      final response = await _httpService.post(
        '/user/email_code_login',
        data: {
          'email': email,
          'verification_code': verificationCode,
          'client_token': clientToken,
          'invite_code': inviteCode,
        },
        fromJsonT: (data) => AuthResponse.fromJson(data),
      );

      return ApiResponse<AuthResponse>(
        code: response.code,
        msg: response.msg,
        result: response.result as AuthResponse?,
      );
    } catch (e) {
      throw Exception('邮箱验证码登录失败: $e');
    }
  }

  /// 发送邮箱验证码
  Future<ApiResponse<void>> sendVerificationCode({
    required String email,
  }) async {
    try {
      final response = await _httpService.post(
        '/user/send_verification_code',
        data: {
          'email': email,
        },
      );

      return ApiResponse<void>(
        code: response.code,
        msg: response.msg,
      );
    } catch (e) {
      throw Exception('发送验证码失败: $e');
    }
  }

  /// 获取用户基本信息
  Future<ApiResponse<User>> retrieveUserInfo() async {
    try {
      final response = await _httpService.post(
        '/user/get_info',
        data: {
          'user_id': UserService.instance.userId,
        },
        fromJsonT: (data) => User.fromJson(data),
      );

      return ApiResponse<User>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('获取用户信息失败: $e');
    }
  }

  /// 关联 Apple 账号
  Future<ApiResponse<AuthResponse>> linkAppleAccount({
    required String appleId,
    required String identityToken,
  }) async {
    try {
      final response = await _httpService.post(
        '/user/link_apple',
        data: {
          'user_id': UserService.instance.userId,
          'apple_id': appleId,
          'identity_token': identityToken,
        },
        fromJsonT: (data) => AuthResponse.fromJson(data),
      );

      return ApiResponse<AuthResponse>(
        code: response.code,
        msg: response.msg,
        result: response.result as AuthResponse?,
      );
    } catch (e) {
      throw Exception('关联Apple账号失败: $e');
    }
  }

  /// 通过 Apple 账号注册或登录
  Future<ApiResponse<AuthResponse>> registOrLoginByApple({
    required String appleId,
    required String identityToken,
    String? email,
    String? username,
  }) async {
    try {
      final response = await _httpService.post(
        '/user/apple_login',
        data: {
          'apple_id': appleId,
          'identity_token': identityToken,
          if (email != null) 'email': email,
          if (username != null) 'username': username,
        },
        fromJsonT: (data) => AuthResponse.fromJson(data),
      );

      return ApiResponse<AuthResponse>(
        code: response.code,
        msg: response.msg,
        result: response.result as AuthResponse?,
      );
    } catch (e) {
      throw Exception('Apple登录失败: $e');
    }
  }

  /// 通过 Google 账号注册或登录（移动端专用）
  Future<ApiResponse<AuthResponse>> mobileRegistOrLoginByGoogle({
    required String googleId,
    required String idToken,
    String? email,
    String? username,
  }) async {
    try {
      final response = await _httpService.post(
        '/user/mobile_google_login',
        data: {
          'google_id': googleId,
          'id_token': idToken,
          if (email != null) 'email': email,
          if (username != null) 'username': username,
        },
        fromJsonT: (data) => AuthResponse.fromJson(data),
      );

      return ApiResponse<AuthResponse>(
        code: response.code,
        msg: response.msg,
        result: response.result as AuthResponse?,
      );
    } catch (e) {
      throw Exception('移动端Google登录失败: $e');
    }
  }

  /// 通过 Google 账号注册或登录
  Future<ApiResponse<AuthResponse>> registOrLoginByGoogle({
    required String googleId,
    required String idToken,
    String? email,
    String? username,
  }) async {
    try {
      final response = await _httpService.post(
        '/user/google_login',
        data: {
          'google_id': googleId,
          'id_token': idToken,
          if (email != null) 'email': email,
          if (username != null) 'username': username,
        },
        fromJsonT: (data) => AuthResponse.fromJson(data),
      );

      return ApiResponse<AuthResponse>(
        code: response.code,
        msg: response.msg,
        result: response.result as AuthResponse?,
      );
    } catch (e) {
      throw Exception('Google登录失败: $e');
    }
  }

  /// 关联 Google 账号
  Future<ApiResponse<AuthResponse>> linkGoogleAccount({
    required String googleId,
    required String idToken,
  }) async {
    try {
      final response = await _httpService.post(
        '/user/link_google',
        data: {
          'user_id': UserService.instance.userId,
          'google_id': googleId,
          'id_token': idToken,
        },
        fromJsonT: (data) => AuthResponse.fromJson(data),
      );

      return ApiResponse<AuthResponse>(
        code: response.code,
        msg: response.msg,
        result: response.result as AuthResponse?,
      );
    } catch (e) {
      throw Exception('关联Google账号失败: $e');
    }
  }

  /// 删除用户账户
  Future<ApiResponse<void>> removeUserAccount() async {
    try {
      final response = await _httpService.post(
        '/user/delete_account',
        data: {
          'user_id': UserService.instance.userId,
        },
      );

      return ApiResponse<void>(
        code: response.code,
        msg: response.msg,
      );
    } catch (e) {
      throw Exception('删除用户账户失败: $e');
    }
  }

  /// 获取用户代币余额
  Future<ApiResponse<int>> fetchUserTokenBalance() async {
    try {
      final response = await _httpService.post(
        '/user/get_token_balance',
        data: {
          'user_id': UserService.instance.userId,
        },
        fromJsonT: (data) => data as int,
      );

      return ApiResponse<int>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('获取代币余额失败: $e');
    }
  }

  /// 获取免费次数
  Future<ApiResponse<int>> getFreeTimes() async {
    try {
      final response = await _httpService.post(
        '/user/get_free_times',
        data: {
          'user_id': UserService.instance.userId,
        },
        fromJsonT: (data) => data as int,
      );

      return ApiResponse<int>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('获取免费次数失败: $e');
    }
  }

  /// 设置用户的 Adjust 相关信息
  Future<ApiResponse<void>> configureAdjustInfo({
    required Map<String, dynamic> adjustData,
  }) async {
    try {
      final response = await _httpService.post(
        '/user/set_adjust_info',
        data: {
          'user_id': UserService.instance.userId,
          ...adjustData,
        },
      );

      return ApiResponse<void>(
        code: response.code,
        msg: response.msg,
      );
    } catch (e) {
      throw Exception('设置Adjust信息失败: $e');
    }
  }

  /// 获取用户的 Adjust 相关信息
  Future<ApiResponse<Map<String, dynamic>>> retrieveAdjustInfo() async {
    try {
      final response = await _httpService.post(
        '/user/get_adjust_info',
        data: {
          'user_id': UserService.instance.userId,
        },
        fromJsonT: (data) => data as Map<String, dynamic>,
      );

      return ApiResponse<Map<String, dynamic>>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('获取Adjust信息失败: $e');
    }
  }

  /// 获取 Adjust 状态
  Future<ApiResponse<Map<String, dynamic>>> getAdjustState() async {
    try {
      final response = await _httpService.post(
        '/user/get_adjust_state',
        data: {
          'user_id': UserService.instance.userId,
        },
        fromJsonT: (data) => data as Map<String, dynamic>,
      );

      return ApiResponse<Map<String, dynamic>>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('获取Adjust状态失败: $e');
    }
  }

  /// 设置用户标签
  Future<ApiResponse<void>> setUserTags({
    required List<String> tags,
  }) async {
    try {
      final response = await _httpService.post(
        '/user/set_tags',
        data: {
          'user_id': UserService.instance.userId,
          'tags': tags,
        },
      );

      return ApiResponse<void>(
        code: response.code,
        msg: response.msg,
      );
    } catch (e) {
      throw Exception('设置用户标签失败: $e');
    }
  }

  /// 设置用户名
  Future<ApiResponse<void>> setUsername({
    required String username,
  }) async {
    try {
      final response = await _httpService.post(
        '/user/set_username',
        data: {
          'user_id': UserService.instance.userId,
          'username': username,
        },
      );

      return ApiResponse<void>(
        code: response.code,
        msg: response.msg,
      );
    } catch (e) {
      throw Exception('设置用户名失败: $e');
    }
  }

  /// 设置头像
  Future<ApiResponse<void>> setAvatar({
    required String avatarUrl,
  }) async {
    try {
      final response = await _httpService.post(
        '/user/set_avatar',
        data: {
          'user_id': UserService.instance.userId,
          'avatar': avatarUrl,
        },
      );

      return ApiResponse<void>(
        code: response.code,
        msg: response.msg,
      );
    } catch (e) {
      throw Exception('设置头像失败: $e');
    }
  }

  /// 收藏角色
  Future<ApiResponse<void>> favoriteCharacter({
    required int characterId,
  }) async {
    try {
      final response = await _httpService.post(
        '/user/favorite_character',
        data: {
          'user_id': UserService.instance.userId,
          'character_id': characterId,
        },
      );

      return ApiResponse<void>(
        code: response.code,
        msg: response.msg,
      );
    } catch (e) {
      throw Exception('收藏角色失败: $e');
    }
  }

  /// 关注作者
  Future<ApiResponse<void>> followAuthor({
    required int authorId,
  }) async {
    try {
      final response = await _httpService.post(
        '/user/follow_author',
        data: {
          'user_id': UserService.instance.userId,
          'author_id': authorId,
        },
      );

      return ApiResponse<void>(
        code: response.code,
        msg: response.msg,
      );
    } catch (e) {
      throw Exception('关注作者失败: $e');
    }
  }
}
