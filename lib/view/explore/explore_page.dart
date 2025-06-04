import 'package:flutter/material.dart';

import 'widget/chat_room_listview.dart';
import 'widget/search_widget.dart';

class ExplorePage extends StatelessWidget {
  final Widget homeAppBar;

  const ExplorePage({
    super.key,
    required this.homeAppBar,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        homeAppBar,
        SearchWidget(),
        ChatRoomListview(),
      ],
    );
  }
}
