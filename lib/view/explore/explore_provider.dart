import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/api.dart';
import '../../model/chat_room.dart';
import '../../util/log.dart';

class ExploreState {
  final bool isLoading;
  final bool isLoadingMore;
  final bool isRefreshing;
  final List<ChatRoom> chatRoomList;
  final String? error;
  final int currentPage;
  final bool hasMoreData;

  const ExploreState({
    this.isLoading = false,
    this.isLoadingMore = false,
    this.isRefreshing = false,
    this.chatRoomList = const [],
    this.error,
    this.currentPage = 1,
    this.hasMoreData = true,
  });

  ExploreState copyWith({
    bool? isLoading,
    bool? isLoadingMore,
    bool? isRefreshing,
    List<ChatRoom>? chatRoomList,
    String? error,
    int? currentPage,
    bool? hasMoreData,
  }) {
    return ExploreState(
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      chatRoomList: chatRoomList ?? this.chatRoomList,
      error: error ?? this.error,
      currentPage: currentPage ?? this.currentPage,
      hasMoreData: hasMoreData ?? this.hasMoreData,
    );
  }
}

class ExploreNotifier extends StateNotifier<ExploreState> {
  ExploreNotifier() : super(const ExploreState(isLoading: true)) {
    refreshChatRooms();
  }

  Future<void> refreshChatRooms() async {
    state = state.copyWith(isRefreshing: true, isLoading: true, error: null);
    try {
      final response = await ApiService.instance.group.getHomePageGroups(
        limit: 10,
        pageNo: 1,
      );

      if (response.code == 0) {
        final newChatRooms = response.result as List<ChatRoom>;
        state = state.copyWith(
          isRefreshing: false,
          isLoading: false,
          chatRoomList: newChatRooms,
          currentPage: 1,
          hasMoreData: newChatRooms.length >= 10,
        );
      } else {
        Log.instance.logger.e(response.msg);
        state = state.copyWith(
          isRefreshing: false,
          isLoading: false,
          error: response.msg,
        );
      }
    } catch (error, stackTrace) {
      Log.instance.logger.e(
        'Error refreshing chat rooms',
        error: error,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        isRefreshing: false,
        isLoading: false,
        error: error.toString(),
      );
    }
  }

  // 加载更多数据
  Future<void> loadMoreChatRooms() async {
    if (state.isLoadingMore || !state.hasMoreData) return;

    state = state.copyWith(isLoadingMore: true, error: null);
    try {
      final nextPage = state.currentPage + 1;
      final response = await ApiService.instance.group.getHomePageGroups(
        limit: 10,
        pageNo: nextPage,
      );

      if (response.code == 0) {
        final newChatRooms = response.result as List<ChatRoom>;
        final updatedList = [...state.chatRoomList, ...newChatRooms];

        state = state.copyWith(
          isLoadingMore: false,
          chatRoomList: updatedList,
          currentPage: nextPage,
          hasMoreData: newChatRooms.length >= 10,
        );
      } else {
        Log.instance.logger.e(response.msg);
        state = state.copyWith(isLoadingMore: false, error: response.msg);
      }
    } catch (error, stackTrace) {
      Log.instance.logger.e(
        'Error loading more chat rooms',
        error: error,
        stackTrace: stackTrace,
      );
      state = state.copyWith(isLoadingMore: false, error: error.toString());
    }
  }

  void onClickReport() {
    // 示例：简单打印日志，后续可扩展为弹窗或API调用
    Log.instance.logger.i('举报按钮被点击');
    // 你可以在这里添加弹窗、API请求等逻辑
  }
}

final exploreProvider = StateNotifierProvider<ExploreNotifier, ExploreState>(
  (ref) {
    return ExploreNotifier();
  },
);
