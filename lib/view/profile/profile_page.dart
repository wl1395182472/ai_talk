import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'profile_provider.dart';
import 'widget/profile_app_bar.dart';
import 'widget/profile_user_info.dart';
import 'widget/profile_balance.dart';
import 'widget/profile_member.dart';
import 'widget/profile_character_tabs.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(profileProvider.notifier).initTabController(this);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileProvider);
    final provider = ref.read(profileProvider.notifier);
    final value = min(1.w, 1.h);

    return Container(
      margin: EdgeInsets.only(
        bottom: 167.h + MediaQuery.of(context).padding.bottom,
      ),
      child: Column(
        children: [
          ProfileAppBar(
            onClickEmail: provider.onClickEmail,
            onClickSettings: provider.onClickSettings,
            onClickEdit: provider.onClickEdit,
          ),
          SizedBox(height: value * 63),
          Expanded(
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  top: 0,
                  child: Container(
                    width: value * 1080,
                    height: value * 1080,
                    transformAlignment: Alignment.topCenter,
                    transform: Matrix4.identity()
                      ..scale(4000 / 1080, 4000 / 1080),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: value * 43),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white,
                        Colors.white,
                        Colors.white,
                        Colors.white,
                        Colors.white,
                        Colors.white,
                        Colors.white,
                        Colors.white,
                        Colors.white,
                        Colors.white,
                        Colors.white,
                        Color(0xffF7F5F7),
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(value * 1000),
                      topRight: Radius.circular(value * 1000),
                    ),
                  ),
                  child: Column(
                    children: [
                      ProfileUserInfo(userInfo: state.userInfo),
                      SizedBox(height: value * 43),
                      ProfileBalance(credits: state.credits),
                      SizedBox(height: value * 29),
                      ProfileMember(onClickReCharge: provider.onClickReCharge),
                      if (state.tabController != null) ...[
                        ProfileCharacterTabs(
                          tabController: state.tabController!,
                          createdRefreshController:
                              state.createdRefreshController,
                          favoriteRefreshController:
                              state.favoriteRefreshController,
                          createdCharacters: state.createdCharacters,
                          favoriteCharacters: state.favoriteCharacters,
                          onRefreshCreatedCharacters:
                              provider.onRefreshCreatedCharacters,
                          onLoadMoreCreatedCharacters:
                              provider.onLoadMoreCreatedCharacters,
                          onRefreshFavoriteCharacters:
                              provider.onRefreshFavoriteCharacters,
                          onLoadMoreFavoriteCharacters:
                              provider.onLoadMoreFavoriteCharacters,
                        ),
                      ] else
                        Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
