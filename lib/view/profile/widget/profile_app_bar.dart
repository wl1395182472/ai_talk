import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/image_path.dart';
import '../profile_provider.dart';

class ProfileAppBar extends ConsumerWidget {
  const ProfileAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(profileProvider.notifier);

    final value = min(1.w, 1.h);
    return SizedBox(
      height: 144.h,
      child: Row(
        children: [
          Spacer(),
          InkWell(
            onTap: controller.onClickEmail,
            child: Padding(
              padding: EdgeInsets.all(value * 30),
              child: Image.asset(
                '${ImagePath.instance.global}email.png',
                width: value * 58,
                height: value * 58,
              ),
            ),
          ),
          SizedBox(width: value * 9),
          InkWell(
            onTap: controller.onClickSettings,
            child: Padding(
              padding: EdgeInsets.all(value * 30),
              child: Image.asset(
                '${ImagePath.instance.global}settings.png',
                width: value * 58,
                height: value * 58,
              ),
            ),
          ),
          SizedBox(width: value * 16),
        ],
      ),
    );
  }
}
