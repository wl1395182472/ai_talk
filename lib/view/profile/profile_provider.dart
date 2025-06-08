import 'package:ai_talk/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../api/api.dart';
import '../../service/user_service.dart';
import '../../util/log.dart';
import '../../util/toast.dart';

class ProfileState {
  final bool isLoading;
  final User? userInfo;
  final int gems;
  final int credits;
  final String? error;
  final TabController? tabController;
  final List<dynamic> createdCharacters;
  final List<dynamic> favoriteCharacters;
  final RefreshController createdRefreshController;
  final RefreshController favoriteRefreshController;

  ProfileState({
    this.isLoading = false,
    this.userInfo,
    this.gems = 0,
    this.credits = 0,
    this.error,
    this.tabController,
    this.createdCharacters = const [],
    this.favoriteCharacters = const [],
    RefreshController? createdRefreshController,
    RefreshController? favoriteRefreshController,
  })  : createdRefreshController =
            createdRefreshController ?? RefreshController(),
        favoriteRefreshController =
            favoriteRefreshController ?? RefreshController();

  ProfileState copyWith({
    bool? isLoading,
    User? userInfo,
    int? gems,
    int? credits,
    String? error,
    TabController? tabController,
    List<dynamic>? createdCharacters,
    List<dynamic>? favoriteCharacters,
    RefreshController? createdRefreshController,
    RefreshController? favoriteRefreshController,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      userInfo: userInfo ?? this.userInfo,
      gems: gems ?? this.gems,
      credits: credits ?? this.credits,
      error: error ?? this.error,
      tabController: tabController ?? this.tabController,
      createdCharacters: createdCharacters ?? this.createdCharacters,
      favoriteCharacters: favoriteCharacters ?? this.favoriteCharacters,
      createdRefreshController:
          createdRefreshController ?? this.createdRefreshController,
      favoriteRefreshController:
          favoriteRefreshController ?? this.favoriteRefreshController,
    );
  }
}

class ProfileNotifier extends StateNotifier<ProfileState> {
  TabController? _tabController;

  ProfileNotifier() : super(ProfileState()) {
    _initializeUserData();
  }

  TabController? get tabController => _tabController;

  void initTabController(TickerProvider vsync) {
    _tabController = TabController(length: 2, vsync: vsync);
    state = state.copyWith(tabController: _tabController);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  /// 初始化用户数据
  Future<void> _initializeUserData() async {
    if (UserService.instance.userId > 0) {
      await loadUserInfo();
      await loadUserBalance();
    }
  }

  /// 加载用户基本信息
  Future<void> loadUserInfo() async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true);

    try {
      final response = await ApiService.instance.user.getUserBaseInfo();

      if (response.code == 0 && response.result != null) {
        state = state.copyWith(
          isLoading: false,
          userInfo: response.result,
          error: null,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response.msg,
        );
      }
    } catch (e, stackTrace) {
      Log.instance.logger.e(
        'Failed to load user info',
        error: e,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// 加载用户余额信息
  Future<void> loadUserBalance() async {
    try {
      // 假设有获取用户余额的API
      // final response = await ApiService.instance.user.getUserBalance(
      //   userId: UserService.instance.userId,
      // );
      //
      // if (response.code == 0 && response.result != null) {
      //   state = state.copyWith(
      //     gems: response.result.gems ?? 0,
      //     credits: response.result.credits ?? 0,
      //   );
      // }

      // 临时使用默认值，等API完善后再修改
      state = state.copyWith(
        gems: 0,
        credits: 0,
      );
    } catch (e, stackTrace) {
      Log.instance.logger.e(
        'Failed to load user balance',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  /// 刷新所有数据
  Future<void> refresh() async {
    await loadUserInfo();
    await loadUserBalance();
  }

  void onClickEmail() {
    // TODO: 实现邮箱点击逻辑
    Toast.show('Email functionality not implemented yet');
  }

  void onClickSettings() {
    // TODO: 实现设置点击逻辑
    Toast.show('Settings functionality not implemented yet');
  }

  void onClickReCharge() {
    // TODO: 实现充值点击逻辑
    Toast.show('ReCharge functionality not implemented yet');
  }

  void onClickEdit() {
    // TODO: 实现编辑点击逻辑
    Toast.show('Edit functionality not implemented yet');
  }

  /// 刷新创建的角色列表
  Future<void> onRefreshCreatedCharacters() async {
    try {
      // TODO: 调用API获取创建的角色列表
      // final response = await ApiService.instance.character.getCreatedCharacters();
      // if (response.code == 0) {
      //   state = state.copyWith(createdCharacters: response.result ?? []);
      // }

      // 临时使用空列表
      state = state.copyWith(createdCharacters: []);
      state.createdRefreshController.refreshCompleted();
    } catch (e) {
      Log.instance.logger.e('Failed to refresh created characters', error: e);
      state.createdRefreshController.refreshFailed();
    }
  }

  /// 加载更多创建的角色
  Future<void> onLoadMoreCreatedCharacters() async {
    try {
      // TODO: 调用API获取更多创建的角色
      // final response = await ApiService.instance.character.getCreatedCharacters(
      //   page: (state.createdCharacters.length / 10).ceil() + 1,
      // );
      // if (response.code == 0) {
      //   final newCharacters = [...state.createdCharacters, ...response.result ?? []];
      //   state = state.copyWith(createdCharacters: newCharacters);
      // }

      state.createdRefreshController.loadComplete();
    } catch (e) {
      Log.instance.logger.e('Failed to load more created characters', error: e);
      state.createdRefreshController.loadFailed();
    }
  }

  /// 刷新收藏的角色列表
  Future<void> onRefreshFavoriteCharacters() async {
    try {
      // TODO: 调用API获取收藏的角色列表
      // final response = await ApiService.instance.character.getFavoriteCharacters();
      // if (response.code == 0) {
      //   state = state.copyWith(favoriteCharacters: response.result ?? []);
      // }

      // 临时使用空列表
      state = state.copyWith(favoriteCharacters: []);
      state.favoriteRefreshController.refreshCompleted();
    } catch (e) {
      Log.instance.logger.e('Failed to refresh favorite characters', error: e);
      state.favoriteRefreshController.refreshFailed();
    }
  }

  /// 加载更多收藏的角色
  Future<void> onLoadMoreFavoriteCharacters() async {
    try {
      // TODO: 调用API获取更多收藏的角色
      // final response = await ApiService.instance.character.getFavoriteCharacters(
      //   page: (state.favoriteCharacters.length / 10).ceil() + 1,
      // );
      // if (response.code == 0) {
      //   final newCharacters = [...state.favoriteCharacters, ...response.result ?? []];
      //   state = state.copyWith(favoriteCharacters: newCharacters);
      // }

      state.favoriteRefreshController.loadComplete();
    } catch (e) {
      Log.instance.logger
          .e('Failed to load more favorite characters', error: e);
      state.favoriteRefreshController.loadFailed();
    }
  }
}

final profileProvider =
    StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  return ProfileNotifier();
});
