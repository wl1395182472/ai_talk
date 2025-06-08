import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../explore_provider.dart';
import 'chat_room_item.dart';

class ChatRoomListview extends ConsumerStatefulWidget {
  const ChatRoomListview({super.key});

  @override
  ConsumerState<ChatRoomListview> createState() => _ChatRoomListviewState();
}

class _ChatRoomListviewState extends ConsumerState<ChatRoomListview> {
  final _refreshController = RefreshController(initialRefresh: false);

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  void _onRefresh() async {
    await ref.read(exploreProvider.notifier).refreshChatRooms();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    final notifier = ref.read(exploreProvider.notifier);
    await notifier.loadMoreChatRooms();
    final state = ref.read(exploreProvider);

    if (state.hasMoreData) {
      _refreshController.loadComplete();
    } else {
      _refreshController.loadNoData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatRoomState = ref.watch(exploreProvider);
    final chatRoomList = chatRoomState.chatRoomList;
    final value = min(1.w, 1.h);

    // 显示加载指示器当数据为空且正在加载时
    if (chatRoomList.isEmpty && chatRoomState.isLoading) {
      return Expanded(
        child: Align(
          alignment: Alignment(0, -0.3),
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).primaryColor,
            ),
          ),
        ),
      );
    }

    return Expanded(
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        header: const WaterDropHeader(),
        child: MasonryGridView.builder(
          gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          mainAxisSpacing: value * 29,
          crossAxisSpacing: value * 20,
          padding: EdgeInsets.only(
            top: 32.h,
            left: 35.w,
            right: 35.w,
            bottom: 210.h + MediaQuery.of(context).padding.bottom,
          ),
          itemCount: chatRoomList.length,
          itemBuilder: (context, index) {
            return ChatRoomItem(
              chatRoom: chatRoomList[index],
              controller: ref.read<ExploreNotifier>(exploreProvider.notifier),
            );
          },
        ),
      ),
    );
  }
}
