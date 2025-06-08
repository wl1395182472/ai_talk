import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../component/global_text.dart';
import '../../../component/url_image.dart';
import '../../../model/group_list_item.dart';

class ChatRoomItem extends StatelessWidget {
  final GroupListItem chatRoom;
  final VoidCallback? onTap;

  const ChatRoomItem({
    super.key,
    required this.chatRoom,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scale = min(1.w, 1.h);
    final avatarSize = scale * 150;

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
                width: avatarSize,
                height: avatarSize,
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
                    url: chatRoom.cover,
                    width: avatarSize,
                    height: avatarSize,
                    errorWidget: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xfff5f5f5),
                      ),
                      child: Icon(
                        Icons.chat_bubble_outline,
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
                      chatRoom.title,
                      fontSize: 46.sp,
                      height: 65 / 46,
                      fontWeight: FontWeight.w600,
                    ),
                    GlobalText(
                      '点击进入聊天室',
                      maxLines: 1,
                      color: const Color(0xff333333).withValues(alpha: 0.8),
                      fontSize: 40.sp,
                      height: 56 / 40,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
