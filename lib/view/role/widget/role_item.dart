import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../component/global_text.dart';
import '../../../component/url_image.dart';
import '../../../constant/image_path.dart';
import '../../../model/character.dart';

class RoleItem extends StatelessWidget {
  final Character character;

  const RoleItem({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    final value = min(1.w, 1.h);

    return Card(
      margin: EdgeInsets.symmetric(vertical: value * 9),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: value * 20,
          horizontal: value * 30,
        ),
        child: Row(
          children: [
            ClipPath(
              clipper: ShapeBorderClipper(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
              ),
              child: UrlImage(
                url: character.avatar,
                width: value * 150,
                height: value * 150,
              ),
            ),
            SizedBox(width: value * 23),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlobalText(
                    character.name,
                    fontSize: 46.sp,
                    height: 65 / 46,
                    fontWeight: FontWeight.w600,
                  ),
                  GlobalText(
                    character.shortDescription,
                    maxLines: 1,
                    color: Color(0xff333333).withValues(alpha: 0.8),
                    fontSize: 40.sp,
                    height: 56 / 40,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(value * 10),
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(100.0),
              ),
              child: Image.asset(
                '${ImagePath.instance.global}collect.png',
                width: value * 50,
                height: value * 50,
              ),
            )
          ],
        ),
      ),
    );
  }
}
