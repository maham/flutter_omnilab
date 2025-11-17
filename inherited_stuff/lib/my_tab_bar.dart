import 'package:flutter/material.dart';
import 'package:omni_common/tab_controller/tab_controller_provider.dart';

class MyTabBar extends StatelessWidget implements PreferredSizeWidget {
  final Size size;

  MyTabBar({required double height, super.key})
    : size = Size.fromHeight(height);

  @override
  PreferredSize build(BuildContext context) {
    final tabController = TabControllerProvider.of(context);

    return PreferredSize(
      preferredSize: size,
      child: TabBar(
        controller: tabController,
        tabs: [
          Tab(icon: Icon(Icons.calculate)),
          Tab(icon: Icon(Icons.cake)),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => size;
}
