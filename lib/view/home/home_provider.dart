import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../service/user_service.dart';
import '../../util/navigate.dart';
import '../../util/toast.dart';

/// 主页控制器，统一管理PageController和当前索引
class HomePageController extends StateNotifier<int> {
  HomePageController() : super(0);

  final pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  /// 切换到指定索引的页面
  void switchTab(int index) {
    if ((index == 1 || index == 33) && UserService.instance.userId <= 0) {
      Navigate.instance.push('/login');
      return;
    }
    pageController.jumpToPage(index);
    state = index;
  }

  void onPageChanged(int index) {
    state = index;
  }

  void onClickCreate() {
    // TODO: 处理点击创建按钮的逻辑
    Toast.show('Create functionality not implemented yet');
  }

  void onClickPayment() {
    Navigate.instance.push('/purchase');
  }

  void onClickMore() {
    // TODO: 处理点击更多按钮的逻辑
    Toast.show('More functionality not implemented yet');
  }
}

/// HomePageController的provider
final homePageControllerProvider =
    StateNotifierProvider<HomePageController, int>((ref) {
  final controller = HomePageController();
  ref.onDispose(() => controller.dispose());
  return controller;
});
