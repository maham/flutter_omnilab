import 'package:flutter/material.dart';

class TabControllerProvider extends InheritedNotifier<TabController> {
  const TabControllerProvider({
    required TabController tabController,
    required super.child,
    super.key,
  }) : super(notifier: tabController);

  static TabController? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TabControllerProvider>()
        ?.notifier;
  }

  static TabController of(BuildContext context) {
    final tabController = maybeOf(context);

    if (tabController == null) {
      throw FlutterError(
        'TabControllerProvider.of() called with a context that does not contain a TabControllerProvider.',
      );
    }

    return tabController;
  }

  static TabController? read(BuildContext context) {
    final inherited =
        context
                .getElementForInheritedWidgetOfExactType<
                  TabControllerProvider
                >()
                ?.widget
            as TabControllerProvider?;

    return inherited?.notifier;
  }
}
