import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/api.dart';
import '../../model/group_list_item.dart';
import '../../model/recent_chat_character.dart';
import '../../util/log.dart';

class RecentState {
  final bool isLoading;
  final bool isLoadingMoreChatRoom;
  final bool isLoadingMoreRole;
  final bool isRefreshingChatRoom;
  final bool isRefreshingRole;
  final List<GroupListItem> recentChatRoomList;
  final List<RecentChatCharacter> recentRoleChatList;
  final String? error;
  final int currentChatRoomPage;
  final int currentRolePage;
  final bool hasMoreChatRoomData;
  final bool hasMoreRoleData;

  const RecentState({
    this.isLoading = false,
    this.isLoadingMoreChatRoom = false,
    this.isLoadingMoreRole = false,
    this.isRefreshingChatRoom = false,
    this.isRefreshingRole = false,
    this.recentChatRoomList = const [],
    this.recentRoleChatList = const [],
    this.error,
    this.currentChatRoomPage = 1,
    this.currentRolePage = 1,
    this.hasMoreChatRoomData = true,
    this.hasMoreRoleData = true,
  });

  RecentState copyWith({
    bool? isLoading,
    bool? isLoadingMoreChatRoom,
    bool? isLoadingMoreRole,
    bool? isRefreshingChatRoom,
    bool? isRefreshingRole,
    List<GroupListItem>? recentChatRoomList,
    List<RecentChatCharacter>? recentRoleChatList,
    String? error,
    int? currentChatRoomPage,
    int? currentRolePage,
    bool? hasMoreChatRoomData,
    bool? hasMoreRoleData,
  }) {
    return RecentState(
      isLoading: isLoading ?? this.isLoading,
      isLoadingMoreChatRoom:
          isLoadingMoreChatRoom ?? this.isLoadingMoreChatRoom,
      isLoadingMoreRole: isLoadingMoreRole ?? this.isLoadingMoreRole,
      isRefreshingChatRoom: isRefreshingChatRoom ?? this.isRefreshingChatRoom,
      isRefreshingRole: isRefreshingRole ?? this.isRefreshingRole,
      recentChatRoomList: recentChatRoomList ?? this.recentChatRoomList,
      recentRoleChatList: recentRoleChatList ?? this.recentRoleChatList,
      error: error ?? this.error,
      currentChatRoomPage: currentChatRoomPage ?? this.currentChatRoomPage,
      currentRolePage: currentRolePage ?? this.currentRolePage,
      hasMoreChatRoomData: hasMoreChatRoomData ?? this.hasMoreChatRoomData,
      hasMoreRoleData: hasMoreRoleData ?? this.hasMoreRoleData,
    );
  }
}

class RecentNotifier extends StateNotifier<RecentState> {
  RecentNotifier() : super(const RecentState(isLoading: true)) {
    loadRecentList();
  }

  Future<void> loadRecentList() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response1 = await ApiService.instance.group.listUserGroups(
        limit: 10,
        pageNo: 1,
        type: 'chatted',
      );
      final response2 =
          await ApiService.instance.character.getCharactersChatRecently(
        limit: 10,
        pageNo: 1,
      );
      Log.instance.logger.d(response2.result);
      state = state.copyWith(
        isLoading: false,
        recentChatRoomList: response1.result,
        recentRoleChatList: response2.result,
        currentChatRoomPage: 2,
        currentRolePage: 2,
        hasMoreChatRoomData: (response1.result as List).length >= 10,
        hasMoreRoleData: (response2.result as List).length >= 10,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // 聊天室相关方法
  Future<void> loadChatRooms({bool isLoadMore = false}) async {
    if (isLoadMore) {
      if (state.isLoadingMoreChatRoom || !state.hasMoreChatRoomData) return;
      state = state.copyWith(isLoadingMoreChatRoom: true, error: null);
    } else {
      state = state.copyWith(
          isRefreshingChatRoom: true, error: null, currentChatRoomPage: 1);
    }

    try {
      final currentPage = isLoadMore ? state.currentChatRoomPage : 1;
      final response = await ApiService.instance.group.listUserGroups(
        limit: 10,
        pageNo: currentPage,
        type: 'chatted',
      );

      Log.instance.logger.d(response.result);
      final newChatRooms = response.result as List<GroupListItem>;
      final hasMoreData = newChatRooms.length >= 10;

      List<GroupListItem> updatedList;
      if (isLoadMore) {
        updatedList = [...state.recentChatRoomList, ...newChatRooms];
      } else {
        updatedList = newChatRooms;
      }

      state = state.copyWith(
        isLoadingMoreChatRoom: false,
        isRefreshingChatRoom: false,
        recentChatRoomList: updatedList,
        currentChatRoomPage: currentPage + 1,
        hasMoreChatRoomData: hasMoreData,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingMoreChatRoom: false,
        isRefreshingChatRoom: false,
        error: e.toString(),
      );
    }
  }

  // 角色聊天相关方法
  Future<void> loadRoleChats({bool isLoadMore = false}) async {
    if (isLoadMore) {
      if (state.isLoadingMoreRole || !state.hasMoreRoleData) return;
      state = state.copyWith(isLoadingMoreRole: true, error: null);
    } else {
      state = state.copyWith(
          isRefreshingRole: true, error: null, currentRolePage: 1);
    }

    try {
      final currentPage = isLoadMore ? state.currentRolePage : 1;
      final response =
          await ApiService.instance.character.getCharactersChatRecently(
        limit: 10,
        pageNo: currentPage,
      );

      final newRoleChats = response.result as List<RecentChatCharacter>;
      final hasMoreData = newRoleChats.length >= 10;

      List<RecentChatCharacter> updatedList;
      if (isLoadMore) {
        updatedList = [...state.recentRoleChatList, ...newRoleChats];
      } else {
        updatedList = newRoleChats;
      }

      state = state.copyWith(
        isLoadingMoreRole: false,
        isRefreshingRole: false,
        recentRoleChatList: updatedList,
        currentRolePage: currentPage + 1,
        hasMoreRoleData: hasMoreData,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingMoreRole: false,
        isRefreshingRole: false,
        error: e.toString(),
      );
    }
  }

  Future<void> refreshChatRooms() async {
    await loadChatRooms(isLoadMore: false);
  }

  Future<void> loadMoreChatRooms() async {
    await loadChatRooms(isLoadMore: true);
  }

  Future<void> refreshRoleChats() async {
    await loadRoleChats(isLoadMore: false);
  }

  Future<void> loadMoreRoleChats() async {
    await loadRoleChats(isLoadMore: true);
  }
}

final recentProvider =
    StateNotifierProvider<RecentNotifier, RecentState>((ref) {
  return RecentNotifier();
});
