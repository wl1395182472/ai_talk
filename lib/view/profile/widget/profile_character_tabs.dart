import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import 'character_item.dart';

class ProfileCharacterTabs extends StatelessWidget {
  final TabController tabController;
  final RefreshController createdRefreshController;
  final RefreshController favoriteRefreshController;
  final List<dynamic> createdCharacters;
  final List<dynamic> favoriteCharacters;
  final VoidCallback onRefreshCreatedCharacters;
  final VoidCallback onLoadMoreCreatedCharacters;
  final VoidCallback onRefreshFavoriteCharacters;
  final VoidCallback onLoadMoreFavoriteCharacters;

  const ProfileCharacterTabs({
    super.key,
    required this.tabController,
    required this.createdRefreshController,
    required this.favoriteRefreshController,
    required this.createdCharacters,
    required this.favoriteCharacters,
    required this.onRefreshCreatedCharacters,
    required this.onLoadMoreCreatedCharacters,
    required this.onRefreshFavoriteCharacters,
    required this.onLoadMoreFavoriteCharacters,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          TabBar(
            controller: tabController,
            tabs: [
              Tab(text: 'Created Characters'),
              Tab(text: 'Favorite Characters'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                SmartRefresher(
                  controller: createdRefreshController,
                  onRefresh: onRefreshCreatedCharacters,
                  onLoading: onLoadMoreCreatedCharacters,
                  enablePullUp: true,
                  child: ListView.builder(
                    itemCount: createdCharacters.length,
                    itemBuilder: (context, index) => CharacterItem(
                      character: createdCharacters[index],
                      isCreated: true,
                    ),
                  ),
                ),
                SmartRefresher(
                  controller: favoriteRefreshController,
                  onRefresh: onRefreshFavoriteCharacters,
                  onLoading: onLoadMoreFavoriteCharacters,
                  enablePullUp: true,
                  child: ListView.builder(
                    itemCount: favoriteCharacters.length,
                    itemBuilder: (context, index) => CharacterItem(
                      character: favoriteCharacters[index],
                      isCreated: false,
                    ),
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
