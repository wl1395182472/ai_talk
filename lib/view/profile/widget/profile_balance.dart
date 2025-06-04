import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../component/global_text.dart';
import '../../../constant/image_path.dart';
import '../profile_provider.dart';

class ProfileBalance extends ConsumerWidget {
  const ProfileBalance({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileProvider);
    final value = min(1.w, 1.h);

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 23.h,
        horizontal: value * 43,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      '${ImagePath.instance.global}credit.png',
                      width: value * 46,
                      height: value * 46,
                    ),
                    SizedBox(width: value * 12),
                    GlobalText(
                      '${state.credits}',
                      color: Colors.black,
                      fontSize: value * 52,
                      fontWeight: FontWeight.w700,
                      height: 73 / 52,
                      letterSpacing: value * 0.1,
                    ),
                  ],
                ),
                GlobalText(
                  'Credit',
                  color: Color(0xff666666),
                  fontSize: value * 40,
                  fontWeight: FontWeight.w400,
                  height: 56 / 40,
                  letterSpacing: value * 0.1,
                ),
              ],
            ),
          ),
          Container(
            height: value * 66,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xffe0e0e0),
                width: value * 3,
              ),
              borderRadius: BorderRadius.circular(100.0),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      '${ImagePath.instance.global}gem.png',
                      width: value * 46,
                      height: value * 46,
                    ),
                    SizedBox(width: value * 12),
                    GlobalText(
                      '${state.gems}',
                      color: Colors.black,
                      fontSize: value * 52,
                      fontWeight: FontWeight.w700,
                      height: 73 / 52,
                      letterSpacing: value * 0.1,
                    ),
                  ],
                ),
                GlobalText(
                  'Gem',
                  color: Color(0xff666666),
                  fontSize: value * 40,
                  fontWeight: FontWeight.w400,
                  height: 56 / 40,
                  letterSpacing: value * 0.1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
