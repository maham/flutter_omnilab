import 'package:flutter/material.dart';

import 'tab_controller_provider.dart';

/// This is a convenience Widget that will create a [TabController] and a
/// [TabControllerProvider].
///
/// note: [SingleTickerProviderStateMixin] is mixed into the state object so we
///       now don't have to think about that for the widgets within this
///       subtree.
///
class TabControllerScope extends StatefulWidget {
  final int length;
  final Widget child;

  const TabControllerScope({
    super.key,
    required this.length,
    required this.child,
  });

  @override
  State<TabControllerScope> createState() => _TabControllerScopeState();
}

class _TabControllerScopeState extends State<TabControllerScope>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: widget.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TabControllerProvider(
      tabController: _tabController,
      child: widget.child,
    );
  }
}
