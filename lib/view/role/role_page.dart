import 'package:flutter/material.dart';

import 'widget/role_listview.dart';

class RolePage extends StatelessWidget {
  final Widget homeAppBar;

  const RolePage({
    super.key,
    required this.homeAppBar,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        homeAppBar,
        RoleListview(),
      ],
    );
  }
}
