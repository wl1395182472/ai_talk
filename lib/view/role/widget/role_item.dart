import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../component/global_text.dart';
import '../../../component/url_image.dart';
import '../../../constant/image_path.dart';
import '../../../model/character.dart';

class RoleItem extends StatelessWidget {
  final Character character;
  final VoidCallback? onTap;

  const RoleItem({
    super.key,
    required this.character,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scale = min(1.w, 1.h);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: scale * 9,
          ),
          padding: EdgeInsets.symmetric(
            vertical: scale * 20,
            horizontal: scale * 25,
          ),
          child: Row(
            children: [
              Container(
                width: scale * 150,
                height: scale * 150,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipPath(
                  clipper: ShapeBorderClipper(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                  ),
                  child: UrlImage(
                    url: character.avatar,
                    width: scale * 150,
                    height: scale * 150,
                    errorWidget: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xfff5f5f5),
                      ),
                      child: Icon(
                        Icons.person,
                        size: scale * 80,
                        color: Color(0xffcccccc),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: scale * 23),
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
                padding: EdgeInsets.all(scale * 10),
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: Image.asset(
                  '${ImagePath.instance.global}collect.png',
                  width: scale * 50,
                  height: scale * 50,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
