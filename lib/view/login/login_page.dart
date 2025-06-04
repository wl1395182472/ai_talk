import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../component/global_button.dart' show GlobalButton;
import '../../constant/image_path.dart' show ImagePath;
import 'login_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  int loginType = 0; // 0: 邮箱密码登录, 1: 邮箱验证码登录
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);
    final loginNotifier = ref.read(loginProvider.notifier);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 32),
              // 登录方式切换按钮
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ChoiceChip(
                    label: const Text('邮箱密码登录'),
                    selected: loginType == 0,
                    onSelected: (selected) {
                      if (!selected) return;
                      setState(() => loginType = 0);
                    },
                  ),
                  const SizedBox(width: 12),
                  ChoiceChip(
                    label: const Text('邮箱验证码登录'),
                    selected: loginType == 1,
                    onSelected: (selected) {
                      if (!selected) return;
                      setState(() => loginType = 1);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // 邮箱输入框
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: '邮箱',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              if (loginType == 0) ...[
                // 密码输入框
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: '密码',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                ),
                // 邮箱密码登录按钮
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: GlobalButton(
                    onPressed: loginState.status == LoginStatus.loading
                        ? null
                        : () => loginNotifier.handleEmailPasswordLogin(
                              email: emailController.text,
                              password: passwordController.text,
                              context: context,
                            ),
                    text: '邮箱密码登录',
                  ),
                ),
              ] else ...[
                // 验证码输入框
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: codeController,
                          decoration: const InputDecoration(
                            labelText: '验证码',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: loginState.status == LoginStatus.loading
                            ? null
                            : () => loginNotifier.sendEmailCode(
                                email: emailController.text),
                        child: const Text('发送验证码'),
                      ),
                    ],
                  ),
                ),
                // 邮箱验证码登录按钮
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: GlobalButton(
                    onPressed: loginState.status == LoginStatus.loading
                        ? null
                        : () => loginNotifier.handleEmailCodeLogin(
                              email: emailController.text,
                              code: codeController.text,
                              context: context,
                            ),
                    text: '邮箱验证码登录',
                  ),
                ),
              ],
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 24),
              // Apple登录按钮
              GlobalButton(
                onPressed: loginState.status == LoginStatus.loading
                    ? null
                    : () => loginNotifier.handleAppleLogin(),
                mainAxisSize: MainAxisSize.max,
                iconWidget: Image.asset(
                  '${ImagePath.instance.global}apple.ico',
                  width: 20.0,
                  height: 20.0,
                ),
                text: 'Apple Login',
              ),
              // Google登录按钮
              GlobalButton(
                onPressed: loginState.status == LoginStatus.loading
                    ? null
                    : () => loginNotifier.handleGoogleLogin(),
                mainAxisSize: MainAxisSize.max,
                iconWidget: Image.asset(
                  '${ImagePath.instance.global}google.ico',
                  width: 20.0,
                  height: 20.0,
                ),
                text: 'Google Play Login',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
