import 'dart:math';

import 'package:ai_talk/component/global_text.dart';
import 'package:ai_talk/component/url_image.dart';
import 'package:ai_talk/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/image_path.dart';

class ProfileUserInfo extends StatelessWidget {
  final User? userInfo;

  const ProfileUserInfo({
    super.key,
    this.userInfo,
  });

  @override
  Widget build(BuildContext context) {
    final value = min(1.w, 1.h);

    return Column(
      children: [
        Container(
          clipBehavior: Clip.none,
          width: value * 118,
          height: value * 118,
          transformAlignment: Alignment.center,
          transform: Matrix4.identity()
            ..scale(230 / 118, 230 / 118)
            ..setTranslationRaw(0, -value * 112 * (118 / 230), 0),
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(value * 100),
            ),
            child: UrlImage(
              url: userInfo?.avatar ?? '',
              width: value * 230,
              height: value * 230,
              fit: BoxFit.fill,
              errorWidget: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xfff2f2f2),
                ),
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: value * 17),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: value * 40),
                child: Center(
                  child: GlobalText(
                    userInfo?.username ?? 'Unknown User',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    color: Colors.black,
                    fontSize: value * 52,
                    fontWeight: FontWeight.w700,
                    height: 73 / 52,
                    letterSpacing: value,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: value * 6),
        Row(
          children: [
            Expanded(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    color: Color(0xff8a8a8a),
                    fontSize: value * 35,
                    fontWeight: FontWeight.w400,
                    height: 48 / 35,
                    letterSpacing: value,
                  ),
                  children: [
                    WidgetSpan(
                      child: Image.asset(
                        '${ImagePath.instance.global}email.png',
                        width: value * 40,
                        height: value * 40,
                        color: Color(0xff8a8a8a),
                      ),
                    ),
                    WidgetSpan(
                      child: SizedBox(width: value * 12),
                    ),
                    TextSpan(
                      text: userInfo?.email ?? 'No email',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
