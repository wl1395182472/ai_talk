import 'dart:math';

import 'package:ai_talk/component/global_button.dart';
import 'package:ai_talk/component/global_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/image_path.dart';

class ProfileAppBar extends StatelessWidget {
  final VoidCallback onClickEmail;
  final VoidCallback onClickSettings;
  final VoidCallback onClickEdit;

  const ProfileAppBar({
    super.key,
    required this.onClickEmail,
    required this.onClickSettings,
    required this.onClickEdit,
  });

  @override
  Widget build(BuildContext context) {
    final value = min(1.w, 1.h);

    return Container(
      height: 144.h,
      padding: EdgeInsets.symmetric(horizontal: value * 43),
      child: Row(
        children: [
          InkWell(
            onTap: onClickEmail,
            child: Image.asset(
              '${ImagePath.instance.profile}email.png',
              width: value * 69,
              height: value * 73,
            ),
          ),
          SizedBox(width: value * 35),
          InkWell(
            onTap: onClickSettings,
            child: Container(
              transform: Matrix4.translationValues(0, value * 10, 0),
              child: Image.asset(
                '${ImagePath.instance.profile}settings.png',
                width: value * 69,
                height: value * 73,
              ),
            ),
          ),
          Spacer(),
          GlobalButton(
            onPressed: onClickEdit,
            height: value * 69,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: value * 35),
            ),
            iconWidget: Row(
              children: [
                GlobalText(
                  'Edit',
                  fontSize: value * 29,
                  fontWeight: FontWeight.w500,
                  height: 40 / 29,
                  letterSpacing: value * 0.58,
                  color: Color(0xff999999),
                ),
                SizedBox(width: value * 9),
                Image.asset(
                  '${ImagePath.instance.profile}edit.png',
                  width: value * 40,
                  height: value * 40,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
