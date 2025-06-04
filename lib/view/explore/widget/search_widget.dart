import 'dart:math';

import 'package:ai_talk/util/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/image_path.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  void onClickFilter() {
    // TODO: Implement filter functionality
    Toast.show('Filter functionality not implemented yet');
  }

  @override
  Widget build(BuildContext context) {
    final value = min(1.w, 1.h);

    return Container(
      height: value * 104,
      margin: EdgeInsets.symmetric(
        vertical: 3.h,
        horizontal: 46.w,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 40.sp,
                height: 56 / 40,
                fontWeight: FontWeight.w500,
                letterSpacing: min(1.w, 1.h),
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 23.w,
                  vertical: 29.h,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
                prefixIconConstraints: BoxConstraints(
                  maxWidth: value * 46 + 46.w,
                  maxHeight: value * 46,
                ),
                prefixIcon: Padding(
                  padding: EdgeInsetsGeometry.only(left: 46.w),
                  child: Image.asset(
                    '${ImagePath.instance.home}search.png',
                    width: value * 46,
                    height: value * 46,
                    fit: BoxFit.fill,
                  ),
                ),
                hintText: 'Search',
                hintStyle: TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 40.sp,
                  height: 56 / 40,
                  fontWeight: FontWeight.w500,
                  letterSpacing: min(1.w, 1.h),
                  color: const Color(0xff999999),
                ),
              ),
            ),
          ),
          SizedBox(width: 35.w),
          InkWell(
            onTap: onClickFilter,
            borderRadius: BorderRadius.circular(100.0),
            child: Image.asset(
              '${ImagePath.instance.home}filter.png',
              width: value * 104,
              height: value * 104,
            ),
          ),
        ],
      ),
    );
  }
}
