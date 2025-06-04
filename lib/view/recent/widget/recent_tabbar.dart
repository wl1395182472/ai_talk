import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecentTabbar extends ConsumerWidget {
  final TabController controller;
  const RecentTabbar({super.key, required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TabBar(
      controller: controller,
      labelColor: Color(0xff110C1A),
      indicatorColor: Color(0xff110C1A),
      unselectedLabelColor: Color(0xff333333).withValues(alpha: 0.5),
      dividerColor: Color(0xff333333).withValues(alpha: 0.5),
      tabs: [
        Tab(text: 'Recent Chat Rooms'),
        Tab(text: 'Recent Role Chats'),
      ],
    );
  }
}
