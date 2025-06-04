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
}
