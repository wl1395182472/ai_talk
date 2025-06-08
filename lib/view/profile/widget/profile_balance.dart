import 'dart:math';

import 'package:ai_talk/component/global_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/image_path.dart';

class ProfileBalance extends StatelessWidget {
  final int credits;

  const ProfileBalance({
    super.key,
    required this.credits,
  });

  @override
  Widget build(BuildContext context) {
    final value = min(1.w, 1.h);

    return Row(
      children: [
        Expanded(
          child: Container(
            height: value * 176,
            decoration: BoxDecoration(
              color: Color(0xffFFEEF3),
              borderRadius: BorderRadius.circular(value * 35),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                      '$credits',
                      color: Colors.black,
                      fontSize: value * 52,
                      fontWeight: FontWeight.w700,
                      height: 73 / 52,
                      letterSpacing: value * 0.58,
                    ),
                  ],
                ),
                GlobalText(
                  'Token',
                  color: Color(0xff666666),
                  fontSize: value * 40,
                  fontWeight: FontWeight.w400,
                  height: 56 / 40,
                  letterSpacing: value * 0.58,
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: value * 37),
        Expanded(
          child: Container(
            height: value * 176,
            decoration: BoxDecoration(
              color: Color(0xffFFEEF3),
              borderRadius: BorderRadius.circular(value * 35),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                      '$credits',
                      color: Colors.black,
                      fontSize: value * 52,
                      fontWeight: FontWeight.w700,
                      height: 73 / 52,
                      letterSpacing: value * 0.58,
                    ),
                  ],
                ),
                GlobalText(
                  'Token you earned',
                  color: Color(0xff666666),
                  fontSize: value * 40,
                  fontWeight: FontWeight.w400,
                  height: 56 / 40,
                  letterSpacing: value * 0.58,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
