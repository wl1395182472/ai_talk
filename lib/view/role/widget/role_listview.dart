import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

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
            left: 35.w,
            right: 35.w,
            bottom: 210.h + MediaQuery.of(context).padding.bottom,
          ),
          itemCount: roleState.rolesList.length,
          itemBuilder: (context, index) {
            return RoleItem(
              character: roleState.rolesList[index],
            );
          },
        ),
      ),
    );
  }
}
