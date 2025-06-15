import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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

  void _onTap(BuildContext context) {
    context.push(
      '/chat_room/${chatRoom.groupId}',
      extra: chatRoom,
    );
  }

  @override
  Widget build(BuildContext context) {
    final value = min(1.w, 1.h);

    return GestureDetector(
      onTap: () => _onTap(context),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              const Color(0xfff8f9fa),
            ],
          ),
          borderRadius: BorderRadius.circular(35.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 30,
              offset: const Offset(0, 15),
              spreadRadius: -5,
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 15,
              offset: const Offset(0, 8),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 6,
              offset: const Offset(0, 3),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          children: [
            ChatRoomAvatar(
              chatRoom: chatRoom,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: value * 23,
                vertical: value * 12,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: GlobalText(
                          chatRoom.title,
                          fontSize: 43.sp,
                          fontWeight: FontWeight.w700,
                          height: 60 / 43,
                          letterSpacing: value,
                          color: const Color(0xff1a1a1a),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: value * 8),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: value * 8,
                          vertical: value * 4,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              const Color(0xfff8f9fa),
                              const Color(0xfff0f1f2),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.06),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
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
                              fontWeight: FontWeight.w600,
                              height: 44 / 32,
                              letterSpacing: value,
                              color: const Color(0xff666666),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: value * 12),
                  Row(
                    children: [
                      Expanded(
                        child: GlobalText(
                          chatRoom.scenario,
                          fontSize: 35.sp,
                          fontWeight: FontWeight.w400,
                          height: 45 / 35,
                          letterSpacing: value,
                          color: const Color(0xff555555),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: value * 20),
                  Row(
                    children: [
                      Expanded(
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          spacing: value * 10,
                          runSpacing: value * 10,
                          children: chatRoom.characters
                              .map(
                                (item) => Container(
                                  clipBehavior: Clip.hardEdge,
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
                      ),
                    ],
                  ),
                  SizedBox(height: value * 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GlobalText(
                        '@${chatRoom.creater}',
                        fontSize: 35.sp,
                        fontWeight: FontWeight.w500,
                        height: 45 / 35,
                        letterSpacing: value,
                        color: const Color(0xff888888),
                      ),
                      Container(
                        padding: EdgeInsets.all(value * 8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              const Color(0xfffafafa),
                              const Color(0xfff0f0f0),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(15.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: PopupMenuButton(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Image.asset(
                            '${ImagePath.instance.global}more.png',
                            width: value * 58,
                            height: value * 58,
                            color: const Color(0xff999999),
                          ),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              onTap: controller.onClickReport,
                              child: const GlobalText(
                                'Report',
                                color: Color(0xff666666),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
