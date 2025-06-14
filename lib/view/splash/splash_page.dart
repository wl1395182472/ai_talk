import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../constant/image_path.dart' show ImagePath;
import '../../util/navigate.dart' show Navigate;
import 'splash_provider.dart';

/// 应用启动页面组件
///
/// 主要功能：
/// - 显示应用图标启动画面
/// - 初始化应用服务
/// - 导航到主页
class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 当初始化完成时导航到主页
    ref.listen<AsyncValue<void>>(
      splashProvider,
      (previous, next) {
        if (next.hasValue) {
          context.go(Navigate.home);
        }
      },
    );

    return Image.asset(
      '${ImagePath.instance.splash}splash.jpg',
      fit: BoxFit.cover,
    );
  }
}
