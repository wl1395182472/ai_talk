import 'package:flutter/material.dart';

import 'widget/recent_listview.dart';
import 'widget/recent_tabbar.dart';

class RecentPage extends StatefulWidget {
  final Widget homeAppBar;

  const RecentPage({
    super.key,
    required this.homeAppBar,
  });

  @override
  State<RecentPage> createState() => _RecentPageState();
}

class _RecentPageState extends State<RecentPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.homeAppBar,
        RecentTabbar(controller: _tabController),
        RecentListview(controller: _tabController),
      ],
    );
  }
}
