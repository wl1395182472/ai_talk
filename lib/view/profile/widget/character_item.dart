import 'dart:math';

import 'package:ai_talk/component/global_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CharacterItem extends StatelessWidget {
  final dynamic character;
  final bool isCreated;

  const CharacterItem({
    super.key,
    required this.character,
    required this.isCreated,
  });

  @override
  Widget build(BuildContext context) {
    final value = min(1.w, 1.h);

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: value * 20,
        vertical: value * 10,
      ),
      padding: EdgeInsets.all(value * 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(value * 20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: value * 10,
            offset: Offset(0, value * 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: value * 120,
            height: value * 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(value * 15),
              color: Colors.grey[200],
            ),
            child: Icon(
              Icons.person,
              size: value * 60,
              color: Colors.grey[400],
            ),
          ),
          SizedBox(width: value * 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GlobalText(
                  'Character Name',
                  fontSize: value * 35,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                SizedBox(height: value * 8),
                GlobalText(
                  'Character description here...',
                  fontSize: value * 28,
                  color: Color(0xff666666),
                  maxLines: 2,
                ),
              ],
            ),
          ),
          if (isCreated)
            Icon(
              Icons.edit,
              size: value * 40,
              color: Colors.grey[400],
            )
          else
            Icon(
              Icons.favorite,
              size: value * 40,
              color: Colors.red[300],
            ),
        ],
      ),
    );
  }
}
