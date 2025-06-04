import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/api.dart';
import '../../model/character.dart';
import '../../util/log.dart' show Log;

class RoleState {
  final bool isLoading;
  final bool isLoadingMore;
  final bool isRefreshing;
  final List<Character> rolesList;
  final String? error;
  final int currentPage;
  final bool hasMoreData;

  const RoleState({
    this.isLoading = false,
    this.isLoadingMore = false,
    this.isRefreshing = false,
    this.rolesList = const [],
    this.error,
    this.currentPage = 1,
    this.hasMoreData = true,
  });

  RoleState copyWith({
    bool? isLoading,
    bool? isLoadingMore,
    bool? isRefreshing,
    List<Character>? rolesList,
    String? error,
    int? currentPage,
    bool? hasMoreData,
  }) {
    return RoleState(
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      rolesList: rolesList ?? this.rolesList,
      error: error ?? this.error,
      currentPage: currentPage ?? this.currentPage,
      hasMoreData: hasMoreData ?? this.hasMoreData,
    );
  }
}

class RoleNotifier extends StateNotifier<RoleState> {
  RoleNotifier() : super(const RoleState()) {
    loadRoles();
  }

  Future<void> loadRoles({bool isLoadMore = false}) async {
    if (isLoadMore) {
      if (state.isLoadingMore || !state.hasMoreData) return;
      state = state.copyWith(isLoadingMore: true, error: null);
    } else {
      state = state.copyWith(isLoading: true, error: null, currentPage: 1);
    }

    try {
      final currentPage = isLoadMore ? state.currentPage : 1;
      final response = await ApiService.instance.character.getCharactersByTag(
        limit: 10,
        pageNo: currentPage,
        tag: '',
      );

      if (response.code == 0) {
        final newRoles = response.result as List<Character>;
        final hasMoreData = newRoles.length >= 10;

        List<Character> updatedRolesList;
        if (isLoadMore) {
          updatedRolesList = [...state.rolesList, ...newRoles];
        } else {
          updatedRolesList = newRoles;
        }

        state = state.copyWith(
          isLoading: false,
          isLoadingMore: false,
          rolesList: updatedRolesList,
          currentPage: currentPage + 1,
          hasMoreData: hasMoreData,
        );
      } else {
        Log.instance.logger.e(response.msg);
        state = state.copyWith(
          isLoading: false,
          isLoadingMore: false,
          error: response.msg,
        );
      }
    } catch (error, stackTrace) {
      Log.instance.logger.e(
        'Error loading roles',
        error: error,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        isLoading: false,
        isLoadingMore: false,
        error: error.toString(),
      );
    }
  }

  Future<void> refreshRoles() async {
    state = state.copyWith(isRefreshing: true, error: null);
    try {
      final response = await ApiService.instance.character.getCharactersByTag(
        limit: 10,
        pageNo: 1,
        tag: '',
      );

      if (response.code == 0) {
        final newRoles = response.result as List<Character>;
        state = state.copyWith(
          isRefreshing: false,
          rolesList: newRoles,
          currentPage: 2,
          hasMoreData: newRoles.length >= 10,
        );
      } else {
        Log.instance.logger.e(response.msg);
        state = state.copyWith(isRefreshing: false, error: response.msg);
      }
    } catch (error, stackTrace) {
      Log.instance.logger.e(
        'Error refreshing roles',
        error: error,
        stackTrace: stackTrace,
      );
      state = state.copyWith(isRefreshing: false, error: error.toString());
    }
  }

  Future<void> loadMoreRoles() async {
    await loadRoles(isLoadMore: true);
  }
}

final roleProvider = StateNotifierProvider<RoleNotifier, RoleState>((ref) {
  return RoleNotifier();
});
