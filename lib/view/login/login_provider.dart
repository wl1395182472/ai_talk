import 'package:ai_talk/service/user_service.dart';
import 'package:ai_talk/util/navigate.dart';
import 'package:bot_toast/bot_toast.dart' show BotToast;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart' show GoogleSignIn;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../api/api.dart';
import '../../constant/app_config.dart' show AppConfig;
import '../../service/storage_service.dart';
import '../../util/log.dart' show Log;
import '../../util/toast.dart' show Toast;
import '../../util/tool.dart' show Tool;

/// 登录状态枚举
enum LoginStatus {
  idle, // 空闲状态
  loading, // 登录中
  success, // 登录成功
  failed, // 登录失败
}

/// 登录状态类
class LoginState {
  final LoginStatus status;
  final String? errorMessage;
  final String? email; // 新增邮箱字段

  const LoginState({
    this.status = LoginStatus.idle,
    this.errorMessage,
    this.email,
  });

  LoginState copyWith({
    LoginStatus? status,
    String? token,
    String? errorMessage,
    String? email,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      email: email ?? this.email,
    );
  }
}

/// 登录状态管理器
class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier() : super(const LoginState());

  /// 谷歌登录工具单例
  final _googleSignIn = GoogleSignIn(
    scopes: ['email', 'openid'],
    serverClientId: AppConfig.instance.androidWebServerClientId,
  );

  /// 处理Apple登录
  Future<void> handleAppleLogin() async {
    // 设置加载状态
    state = state.copyWith(status: LoginStatus.loading);

    // 显示加载提示
    final cancel = BotToast.showLoading();

    try {
      // 生成防重放攻击的nonce值
      final rawNonce = generateNonce();
      final nonce = Tool.instance.generateSHA256(rawNonce);

      // 获取apple验证信息
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: AppConfig.instance.appleLoginOnAndroidClientId,
          redirectUri:
              Uri.parse(AppConfig.instance.appleLoginOnAndroidRedirectUri),
        ),
      );

      // 提取身份令牌
      final appleToken = credential.identityToken;
      if (appleToken != null) {
        // 更新成功状态
        state = state.copyWith(
          status: LoginStatus.success,
          token: appleToken,
        );
        Toast.show('Apple login successful: $appleToken');
      } else {
        // 更新失败状态
        state = state.copyWith(
          status: LoginStatus.failed,
          errorMessage: 'identityToken is null',
        );
        Toast.show('Apple login failed: identityToken is null');
      }
    } catch (error, stackTrace) {
      // 处理Apple登录相关异常
      String errorMessage = _handleAppleLoginError(error);
      state = state.copyWith(
        status: LoginStatus.failed,
        errorMessage: errorMessage,
      );

      if (error is! SignInWithAppleAuthorizationException ||
          error.code != AuthorizationErrorCode.canceled) {
        Log.instance.logger.e(
          'Apple login failed',
          error: error,
          stackTrace: stackTrace,
        );
      }
    } finally {
      // 关闭加载提示
      cancel();
    }
  }

  /// 处理Google登录
  Future<void> handleGoogleLogin() async {
    // 设置加载状态
    state = state.copyWith(status: LoginStatus.loading);

    // 显示加载提示
    final cancel = BotToast.showLoading();

    try {
      // 先登出已有账户，确保用户可以选择账户
      await _googleSignIn.signOut();

      // 发起Google登录请求
      final googleSignInAccount = await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        // 获取认证信息
        final authentication = await googleSignInAccount.authentication;
        final googleToken = authentication.idToken;

        if (googleToken != null) {
          // 更新成功状态
          state = state.copyWith(
            status: LoginStatus.success,
            token: googleToken,
          );
          Toast.show('Google Play login successful: $googleToken');
        } else {
          // 更新失败状态
          state = state.copyWith(
            status: LoginStatus.failed,
            errorMessage: 'idToken is null',
          );
          Toast.show('Google Play login failed: idToken is null');
        }
      } else {
        // 用户取消了登录
        state = state.copyWith(status: LoginStatus.idle);
        Toast.show('Google Play login canceled');
      }
    } catch (error, stackTrace) {
      // 更新失败状态
      state = state.copyWith(
        status: LoginStatus.failed,
        errorMessage: error.toString(),
      );

      Log.instance.logger.e(
        'Google login failed',
        error: error,
        stackTrace: stackTrace,
      );
      Toast.show('Google login failed: $error');
    } finally {
      // 关闭加载提示
      cancel();
    }
  }

  /// 邮箱密码登录
  Future<void> handleEmailPasswordLogin(
      {required String email,
      required String password,
      required context}) async {
    state = state.copyWith(status: LoginStatus.loading);
    final cancel = BotToast.showLoading();
    try {
      final response = await ApiService.instance.user.loginByEmail(
        email: email,
        password: password,
      );
      if (response.code == 0 && response.result != null) {
        UserService.instance.userId = response.result!.userId;
        // 拉取用户信息并缓存
        final userInfoResp = await ApiService.instance.user.getUserBaseInfo();
        if (userInfoResp.code == 0 && userInfoResp.result != null) {
          UserService.instance.userId = userInfoResp.result!.userId;
          // 假设 StorageService 有 setUser 方法
          StorageService.instance.setUser(userInfoResp.result!);
        }
        state = state.copyWith(
          status: LoginStatus.success,
          email: email,
        );
        Navigate.instance.back();
        Toast.show('邮箱密码登录成功');
      } else {
        state = state.copyWith(
          status: LoginStatus.failed,
          errorMessage: response.msg,
        );
        Toast.show(response.msg);
      }
    } catch (e) {
      state = state.copyWith(
        status: LoginStatus.failed,
        errorMessage: e.toString(),
      );
      Toast.show('邮箱密码登录失败: $e');
    } finally {
      cancel();
    }
  }

  /// 发送邮箱验证码
  Future<void> sendEmailCode({required String email}) async {
    final cancel = BotToast.showLoading();
    try {
      final response = await ApiService.instance.user.sendEmailCode(
        email: email,
      );
      if (response.code == 0) {
        Toast.show('验证码已发送到邮箱');
      } else {
        Toast.show(response.msg);
      }
    } catch (e) {
      Toast.show('验证码发送失败: $e');
    } finally {
      cancel();
    }
  }

  /// 邮箱验证码登录
  Future<void> handleEmailCodeLogin(
      {required String email, required String code, required context}) async {
    state = state.copyWith(status: LoginStatus.loading);
    final cancel = BotToast.showLoading();
    try {
      final deviceId = await Tool.instance.fetchDeviceId();
      final response = await ApiService.instance.user.codeLogin(LoginRequest(
        email: email,
        verificationCode: code,
        guestClientToken: deviceId,
      ));
      if (response.code == 0 && response.result != null) {
        // 拉取用户信息并缓存
        final userInfoResp = await ApiService.instance.user.getUserBaseInfo();
        if (userInfoResp.code == 0 && userInfoResp.result != null) {
          UserService.instance.userId = userInfoResp.result!.userId;
          StorageService.instance.setUser(userInfoResp.result!);
        }
        state = state.copyWith(
          status: LoginStatus.success,
          email: email,
        );
        Navigate.instance.back();
        Toast.show('邮箱验证码登录成功');
      } else {
        state = state.copyWith(
          status: LoginStatus.failed,
          errorMessage: response.msg,
        );
        Toast.show(response.msg);
      }
    } catch (e) {
      state = state.copyWith(
        status: LoginStatus.failed,
        errorMessage: e.toString(),
      );
      Toast.show('邮箱验证码登录失败: $e');
    } finally {
      cancel();
    }
  }

  /// 处理Apple登录错误
  String _handleAppleLoginError(dynamic error) {
    if (error is SignInWithAppleAuthorizationException) {
      switch (error.code) {
        case AuthorizationErrorCode.canceled:
          Toast.show('Apple login canceled');
          return 'Login canceled';
        case AuthorizationErrorCode.invalidResponse:
          Toast.show('Invalid response from Apple');
          return 'Invalid response';
        case AuthorizationErrorCode.failed:
          Toast.show('Apple login failed');
          return 'Login failed';
        case AuthorizationErrorCode.notHandled:
          Toast.show('Apple login request not handled');
          return 'Request not handled';
        case AuthorizationErrorCode.notInteractive:
          Toast.show('Apple login not interactive');
          return 'Not interactive';
        case AuthorizationErrorCode.credentialExport:
          Toast.show('Failed to export credentials');
          return 'Failed to export credentials';
        case AuthorizationErrorCode.credentialImport:
          Toast.show('Failed to import credentials');
          return 'Failed to import credentials';
        case AuthorizationErrorCode.matchedExcludedCredential:
          Toast.show('Credential was excluded');
          return 'Credential was excluded';
        case AuthorizationErrorCode.unknown:
          if (error.message.contains('error 1000')) {
            Toast.show(
                'Apple login failed: Authentication service temporarily unavailable');
            return 'Authentication service temporarily unavailable';
          } else {
            Toast.show('Apple login error: ${error.message}');
            return error.message;
          }
      }
    } else if (error is SignInWithAppleNotSupportedException) {
      Toast.show('Apple login not supported on this device');
      return 'Not supported on this device';
    } else if (error is SignInWithAppleCredentialsException) {
      Toast.show('Apple credentials error: ${error.message}');
      return 'Credentials error: ${error.message}';
    } else {
      Toast.show('Apple login failed: $error');
      return error.toString();
    }
  }

  /// 重置状态
  void resetState() {
    state = const LoginState();
  }
}

/// 登录状态Provider
final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier();
});
