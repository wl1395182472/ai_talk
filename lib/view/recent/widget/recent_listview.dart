import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import '../recent_provider.dart';
import 'chat_room_item.dart';
import 'role_chat_item.dart';

class RecentListview extends ConsumerStatefulWidget {
  final TabController controller;
  const RecentListview({super.key, required this.controller});

  @override
  ConsumerState<RecentListview> createState() => _RecentListviewState();
}

class _RecentListviewState extends ConsumerState<RecentListview> {
  final _chatRoomRefreshController = RefreshController(initialRefresh: false);
  final _roleChatRefreshController = RefreshController(initialRefresh: false);

  @override
  void dispose() {
    _chatRoomRefreshController.dispose();
    _roleChatRefreshController.dispose();
    super.dispose();
  }

  void _onChatRoomRefresh() async {
    await ref.read(recentProvider.notifier).refreshChatRooms();
    _chatRoomRefreshController.refreshCompleted();
  }

  void _onChatRoomLoading() async {
    final notifier = ref.read(recentProvider.notifier);
    notifier.loadMoreChatRooms();
    final state = ref.read(recentProvider);

    if (state.hasMoreChatRoomData) {
      _chatRoomRefreshController.loadComplete();
    } else {
      _chatRoomRefreshController.loadNoData();
    }
  }

  void _onRoleChatRefresh() async {
    await ref.read(recentProvider.notifier).refreshRoleChats();
    _roleChatRefreshController.refreshCompleted();
  }

  void _onRoleChatLoading() async {
    final notifier = ref.read(recentProvider.notifier);
    notifier.loadMoreRoleChats();
    final state = ref.read(recentProvider);

    if (state.hasMoreRoleData) {
      _roleChatRefreshController.loadComplete();
    } else {
      _roleChatRefreshController.loadNoData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final recentState = ref.watch(recentProvider);
    return Expanded(
      child: TabBarView(
        controller: widget.controller,
        children: [
          buildRecentChatRoomListView(context, ref, recentState),
          buildRecentRoleChatListView(context, ref, recentState),
        ],
      ),
    );
  }

  Widget buildRecentChatRoomListView(
      BuildContext context, WidgetRef ref, RecentState state) {
    // 显示加载指示器当数据为空且正在加载时
    if (state.recentChatRoomList.isEmpty && state.isLoading) {
      return Align(
        alignment: Alignment(0, -0.3),
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).primaryColor,
          ),
        ),
      );
    }

    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      controller: _chatRoomRefreshController,
      onRefresh: _onChatRoomRefresh,
      onLoading: _onChatRoomLoading,
      header: const WaterDropHeader(),
      child: ListView.builder(
        padding: EdgeInsets.only(
          top: 32.h,
          bottom: 210.h + MediaQuery.of(context).padding.bottom,
          left: 20.w,
          right: 20.w,
        ),
        itemCount: state.recentChatRoomList.length,
        itemBuilder: (context, index) {
          final chatRoom = state.recentChatRoomList[index];
          return ChatRoomItem(
            chatRoom: chatRoom,
            onTap: () {
              // TODO: 导航到聊天室
            },
          );
        },
      ),
    );
  }

  Widget buildRecentRoleChatListView(
      BuildContext context, WidgetRef ref, RecentState state) {
    // 显示加载指示器当数据为空且正在加载时
    if (state.recentRoleChatList.isEmpty && state.isLoading) {
      return Align(
        alignment: Alignment(0, -0.3),
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).primaryColor,
          ),
        ),
      );
    }

    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      controller: _roleChatRefreshController,
      onRefresh: _onRoleChatRefresh,
      onLoading: _onRoleChatLoading,
      header: const WaterDropHeader(),
      child: ListView.builder(
        padding: EdgeInsets.only(
          top: 32.h,
          bottom: 210.h + MediaQuery.of(context).padding.bottom,
          left: 20.w,
          right: 20.w,
        ),
        itemCount: state.recentRoleChatList.length,
        itemBuilder: (context, index) {
          final roleChat = state.recentRoleChatList[index];
          return RoleChatItem(
            roleChat: roleChat,
            onTap: () {
              // TODO: 导航到角色聊天
            },
          );
        },
      ),
    );
  }
}
