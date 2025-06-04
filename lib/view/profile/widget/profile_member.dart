import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../component/global_button.dart';
import '../../../component/global_text.dart';
import '../../../constant/image_path.dart';
import '../profile_provider.dart';

class ProfileMember extends ConsumerWidget {
  const ProfileMember({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(profileProvider.notifier);
    final value = min(1.w, 1.h);

    return Container(
      width: double.infinity,
      height: 247.h,
      margin: EdgeInsets.symmetric(
        vertical: 23.h,
        horizontal: value * 23,
      ),
      padding: EdgeInsets.only(
        left: value * 80,
        right: value * 80,
        bottom: value * 40,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('${ImagePath.instance.global}member.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: GlobalText(
                        'Get Pro+',
                        color: Colors.white,
                        fontSize: value * 52,
                        fontWeight: FontWeight.w800,
                        height: 73 / 52,
                        letterSpacing: value * 1.0,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: GlobalText(
                        'Get more privilege',
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: value * 35,
                        fontWeight: FontWeight.w400,
                        height: 48 / 35,
                        letterSpacing: value * 1.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          GlobalButton(
            onPressed: controller.onClickReCharge,
            height: 92.h,
            text: 'ReCharge',
          )
        ],
      ),
    );
  }
}
