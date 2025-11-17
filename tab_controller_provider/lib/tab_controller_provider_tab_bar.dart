import 'package:flutter/material.dart';
import 'package:omni_common/tab_controller/tab_controller_provider.dart';

// Here we use the provided [TabController] to show a tab bar without having tab
// pass around a the controller from the parent widget.
// -- MHM
class TabControllerProviderTabBar extends StatelessWidget {
  const TabControllerProviderTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    final tabController = TabControllerProvider.of(context);

    return TabBar(
      controller: tabController,
      tabs: [
        for (int i = 0; i < tabController.length; i++)
          Tab(icon: Icon(Icons.cake)),
      ],
    );
  }
}
