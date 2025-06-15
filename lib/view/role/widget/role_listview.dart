import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../util/navigate.dart';
import '../role_provider.dart';
import 'role_item.dart';

class RoleListview extends ConsumerStatefulWidget {
  const RoleListview({super.key});

  @override
  ConsumerState<RoleListview> createState() => _RoleListviewState();
}

class _RoleListviewState extends ConsumerState<RoleListview> {
  final _refreshController = RefreshController(initialRefresh: false);

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  void _onRefresh() async {
    await ref.read(roleProvider.notifier).refreshRoles();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    final notifier = ref.read(roleProvider.notifier);
    notifier.loadMoreRoles();
    final state = ref.read(roleProvider);

    if (state.hasMoreData) {
      _refreshController.loadComplete();
    } else {
      _refreshController.loadNoData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final roleState = ref.watch(roleProvider);

    // 显示加载指示器当数据为空且正在加载时
    if (roleState.rolesList.isEmpty && roleState.isLoading) {
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
        child: ListView.builder(
          padding: EdgeInsets.only(
            top: 32.h,
            bottom: 210.h + MediaQuery.of(context).padding.bottom,
            left: 20.w,
            right: 20.w,
          ),
          itemCount: roleState.rolesList.length,
          itemBuilder: (context, index) {
            return RoleItem(
              character: roleState.rolesList[index],
              onTap: () {
                // 使用 go_router 导航到角色聊天
                Navigate.instance.push(
                  Navigate.chat,
                  extra: roleState.rolesList[index],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
