import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../component/global_text.dart';
import '../../../constant/image_path.dart';
import '../home_provider.dart';

class HomeBottomNavigationBar extends ConsumerWidget {
  const HomeBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(homePageControllerProvider.notifier);
    final currentIndex = ref.watch(homePageControllerProvider);

    return Container(
      width: 1080.w,
      height: 210.h + MediaQuery.of(context).padding.bottom,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            '${ImagePath.instance.home}bottom_bar_background.png',
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 30.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildIcon(controller, currentIndex, 0, 'Explore'),
            _buildIcon(controller, currentIndex, 1, 'Chat'),
            _buildFloatingActionButton(controller),
            _buildIcon(controller, currentIndex, 2, 'Role'),
            _buildIcon(controller, currentIndex, 3, 'Profile'),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(
    HomePageController controller,
    int currentIndex,
    int index,
    String iconPath,
  ) {
    final isSelected = currentIndex == index;
    final value = min(1.w, 1.h);

    return Container(
      width: value * 200,
      height: value * 128,
      margin: EdgeInsetsGeometry.only(top: 49.h),
      child: InkWell(
        onTap: () => controller.switchTab(index),
        child: Column(
          children: [
            AnimatedSwitcher(
              duration: Duration(milliseconds: 400),
              child: Image.asset(
                '${ImagePath.instance.home}${iconPath}_${isSelected ? 'active' : 'deactive'}.png',
                width: value * 81,
                height: value * 81,
              ),
            ),
            GlobalText(
              iconPath,
              maxLines: 1,
              fontSize: 32.sp,
              fontWeight: FontWeight.w500,
              height: 44 / 32,
              letterSpacing: min(1.w, 1.h),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton(
    HomePageController controller,
  ) {
    final value = min(1.w, 1.h);

    return InkWell(
      onTap: controller.onClickCreate,
      child: Padding(
        padding: EdgeInsetsGeometry.all(9.h),
        child: Image.asset(
          '${ImagePath.instance.home}floating_button.png',
          width: value * 144,
          height: value * 144,
        ),
      ),
    );
  }
}
