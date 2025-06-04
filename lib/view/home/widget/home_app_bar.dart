import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../component/global_button.dart';
import '../../../component/global_text.dart';
import '../../../constant/app_config.dart';
import '../../../constant/image_path.dart';
import '../home_provider.dart';

class HomeAppBar extends ConsumerWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(homePageControllerProvider.notifier);
    final currentIndex = ref.watch(homePageControllerProvider);

    return Container(
      margin: EdgeInsets.only(top: 3.h),
      padding: EdgeInsets.symmetric(
        horizontal: 46.w,
        vertical: 20.h,
      ),
      child: Row(
        children: [
          GlobalText(
            currentIndex == 1
                ? 'Chat'
                : currentIndex == 2
                    ? 'Role'
                    : currentIndex == 3
                        ? 'Profile'
                        : AppConfig.instance.appName,
            fontFamily: 'WendyOne',
            fontSize: 75.sp,
            height: 105 / 75,
            letterSpacing: min(1.w, 1.h),
          ),
          Spacer(),
          GlobalButton(
            onPressed: controller.onClickPayment,
            height: 81.h,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: 35.w,
                vertical: 12.h,
              ),
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26.r),
              ),
            ),
            iconWidget: Image.asset(
              '${ImagePath.instance.global}crown.png',
              width: 60.w,
              height: 60.h,
            ),
            iconPadding: EdgeInsets.only(right: 12.w),
            text: 'Get Pro+',
            textColor: Colors.white,
            textFontSize: 40.sp,
            textFontWeight: FontWeight.w700,
            textHeight: 56 / 40,
            textLetterSpacing: min(1.w, 1.h),
          ),
          SizedBox(width: 23.w),
          InkWell(
            onTap: controller.onClickMore,
            child: Container(
              width: 69.w,
              height: 81.h,
              padding: EdgeInsets.symmetric(
                horizontal: 6.w,
                vertical: 12.h,
              ),
              child: Image.asset(
                '${ImagePath.instance.global}more.png',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
