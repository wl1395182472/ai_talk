import 'package:ai_talk/model/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  const ProfileState({
    this.isLoading = false,
    this.userInfo,
    this.gems = 0,
    this.credits = 0,
    this.error,
  });

  ProfileState copyWith({
    bool? isLoading,
    User? userInfo,
    int? gems,
    int? credits,
    String? error,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      userInfo: userInfo ?? this.userInfo,
      gems: gems ?? this.gems,
      credits: credits ?? this.credits,
      error: error ?? this.error,
    );
  }
}

class ProfileNotifier extends StateNotifier<ProfileState> {
  ProfileNotifier() : super(const ProfileState()) {
    _initializeUserData();
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
}

final profileProvider =
    StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  return ProfileNotifier();
});
