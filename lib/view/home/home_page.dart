import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show BuildContext, Scaffold, Widget;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constant/image_path.dart';
import '../explore/explore_page.dart';
import '../profile/profile_page.dart';
import '../recent/recent_page.dart';
import '../role/role_page.dart';
import 'widget/home_app_bar.dart';
import 'widget/home_bottom_navigation_bar.dart';
import 'home_provider.dart';

/// 应用主页组件
///
/// 提供以下主要功能：
/// - Apple 登录
/// - Google 登录
/// - 跳转到购买页面
/// - 应用图标展示
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(homePageControllerProvider.notifier);

    final homeAppBar = HomeAppBar();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('${ImagePath.instance.home}home_background.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  SafeArea(
                    bottom: false,
                    child: PageView(
                      controller: controller.pageController,
                      onPageChanged: controller.onPageChanged,
                      children: [
                        ExplorePage(
                          homeAppBar: homeAppBar,
                        ),
                        RecentPage(
                          homeAppBar: homeAppBar,
                        ),
                        RolePage(
                          homeAppBar: homeAppBar,
                        ),
                        ProfilePage(),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: HomeBottomNavigationBar(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
