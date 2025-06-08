import 'dart:math';

import 'package:ai_talk/component/global_button.dart';
import 'package:ai_talk/component/global_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/image_path.dart';

class ProfileMember extends StatelessWidget {
  final VoidCallback onClickReCharge;

  const ProfileMember({
    super.key,
    required this.onClickReCharge,
  });

  @override
  Widget build(BuildContext context) {
    final value = min(1.w, 1.h);

    return Container(
      width: double.infinity,
      height: value * 294,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            '${ImagePath.instance.profile}member.png',
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: value * 207,
            padding: EdgeInsets.symmetric(horizontal: value * 58),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GlobalText(
                        'Get Pro+',
                        fontSize: 52.sp,
                        height: 73 / 52,
                        letterSpacing: value * 0.58,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                      GlobalText(
                        'Get more privilege',
                        fontSize: 35.sp,
                        height: 48 / 35,
                        letterSpacing: value * 0.58,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                GlobalButton(
                  onPressed: onClickReCharge,
                  text: 'Recharge',
                )
              ],
            ),
          ),
          Container(
            height: value * 87,
            padding: EdgeInsets.only(
              left: value * 35,
              right: value * 55,
            ),
            child: Row(
              children: [
                Expanded(
                  child: GlobalText(
                    'Share to get more free token',
                    color: Theme.of(context).primaryColor,
                    fontSize: value * 35,
                    fontWeight: FontWeight.w500,
                    height: 48 / 35,
                    letterSpacing: value * 0.58,
                  ),
                ),
                Image.asset(
                  '${ImagePath.instance.global}gem.png',
                  width: value * 46,
                  height: value * 46,
                ),
                SizedBox(width: value * 12),
                GlobalText(
                  'Share',
                  color: Theme.of(context).primaryColor,
                  fontSize: value * 35,
                  fontWeight: FontWeight.w500,
                  height: 48 / 35,
                  letterSpacing: value * 0.58,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
