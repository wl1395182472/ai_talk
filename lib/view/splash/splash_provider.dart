import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../service/app_service.dart';

/// 启动页面状态管理的Provider
final splashProvider = FutureProvider<void>((ref) async {
  // 确保总时间至少2秒，AppService初始化在这2秒内完成
  await Future.wait([
    Future.delayed(const Duration(seconds: 2)), // 最少显示2秒启动画面
    AppService.instance.init(), // 初始化应用服务
  ]);
});
