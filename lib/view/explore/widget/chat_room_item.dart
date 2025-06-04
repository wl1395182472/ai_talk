import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../component/chat_room_avatar.dart';
import '../../../component/global_text.dart';
import '../../../component/url_image.dart';
import '../../../constant/image_path.dart';
import '../../../model/chat_room.dart';
import '../explore_provider.dart';

class ChatRoomItem extends StatelessWidget {
  final ChatRoom chatRoom;
  final ExploreNotifier controller;

  const ChatRoomItem({
    super.key,
    required this.chatRoom,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final value = min(1.w, 1.h);

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(35.r),
      ),
      child: Column(
        children: [
          ChatRoomAvatar(
            chatRoom: chatRoom,
          ),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: value * 23,
              vertical: value * 12,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    GlobalText(
                      chatRoom.title,
                      fontSize: 43.sp,
                      fontWeight: FontWeight.w700,
                      height: 60 / 43,
                      letterSpacing: value,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      '${ImagePath.instance.global}gen_count.png',
                      width: value * 46,
                      height: value * 46,
                    ),
                    SizedBox(width: value * 6),
                    GlobalText(
                      chatRoom.genCount.toString(),
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w500,
                      height: 44 / 32,
                      letterSpacing: value,
                    ),
                  ],
                ),
                SizedBox(height: value * 6),
                Row(
                  children: [
                    Expanded(
                      child: GlobalText(
                        chatRoom.scenario,
                        fontSize: 35.sp,
                        fontWeight: FontWeight.w400,
                        height: 45 / 35,
                        letterSpacing: value,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: value * 23),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: chatRoom.characters
                      .map(
                        (item) => Container(
                          clipBehavior: Clip.hardEdge,
                          margin: EdgeInsets.only(right: value * 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          child: UrlImage(
                            url: item.avatar,
                            width: value * 70,
                            height: value * 70,
                            needLoading: false,
                          ),
                        ),
                      )
                      .toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GlobalText(
                      '@${chatRoom.creater}',
                      fontSize: 35.sp,
                      fontWeight: FontWeight.w400,
                      height: 45 / 35,
                      letterSpacing: value,
                      color: Color(0xff999999),
                    ),
                    PopupMenuButton(
                      child: Image.asset(
                        '${ImagePath.instance.global}more.png',
                        width: value * 58,
                        height: value * 58,
                        color: Color(0xff999999),
                      ),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          onTap: controller.onClickReport,
                          child: GlobalText(
                            'Report',
                            color: Color(0xff999999),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: value * 23),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
