import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../component/global_button.dart';
import '../../../component/global_text.dart';
import '../../../component/url_image.dart';
import '../../../constant/image_path.dart';
import '../profile_provider.dart';

class ProfileUserInfo extends ConsumerWidget {
  const ProfileUserInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(profileProvider.notifier);
    final state = ref.watch(profileProvider);
    final value = min(1.w, 1.h);

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 23.h,
        horizontal: value * 69,
      ),
      child: Row(
        children: [
          Container(
            width: value * 184,
            height: value * 184,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: value * 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: value * 10,
                  offset: Offset(0, value * 4),
                ),
              ],
            ),
            child: ClipOval(
              child: UrlImage(
                url: state.userInfo?.avatar ?? '',
                errorWidget: Container(
                  width: value * 184,
                  height: value * 184,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xfff5f5f5),
                  ),
                  child: Icon(
                    Icons.person,
                    size: value * 80,
                    color: Color(0xffcccccc),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: value * 46),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: GlobalText(
                          state.userInfo?.username ?? 'Unknown User',
                          color: Colors.black,
                          fontSize: value * 52,
                          fontWeight: FontWeight.w700,
                          height: 73 / 52,
                          letterSpacing: value,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: value * 17),
                  Row(
                    children: [
                      Image.asset(
                        '${ImagePath.instance.global}email.png',
                        width: value * 40,
                        height: value * 40,
                        color: Color(0xff8a8a8a),
                      ),
                      SizedBox(width: value * 12),
                      Expanded(
                        child: GlobalText(
                          state.userInfo?.email ?? 'No email',
                          color: Color(0xff8a8a8a),
                          fontSize: value * 35,
                          fontWeight: FontWeight.w400,
                          height: 48 / 35,
                          letterSpacing: value,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          GlobalButton(
            onPressed: controller.onClickEdit,
            height: value * 69,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Color(0xff333333),
              shadowColor: Colors.black.withValues(alpha: 0.08),
              elevation: 2,
              padding: EdgeInsets.symmetric(
                horizontal: value * 35,
                vertical: value * 6,
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Color(0xffE8E8E8),
                  width: value * 1,
                ),
                borderRadius: BorderRadius.circular(52.r),
              ),
            ),
            text: 'Edit',
          )
        ],
      ),
    );
  }
}
