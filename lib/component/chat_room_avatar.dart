import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../model/chat_room.dart';
import 'url_image.dart';

class ChatRoomAvatar extends StatelessWidget {
  final ChatRoom chatRoom;

  const ChatRoomAvatar({
    super.key,
    required this.chatRoom,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 60),
      child: chatRoom.cover.isNotEmpty
          ? UrlImage(
              url: chatRoom.cover,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            )
          : AspectRatio(
              aspectRatio: 1,
              child: Row(
                children: chatRoom.characters
                    .where((value) => value.avatar.isNotEmpty)
                    .map(
                      (value) => Expanded(
                        child: UrlImage(
                          url: value.avatar,
                          height: double.infinity,
                          fit: BoxFit.fitHeight,
                          needLoading: false,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
    );
  }
}
