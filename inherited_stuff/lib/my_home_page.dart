import 'package:flutter/material.dart';
import 'package:omni_common/tab_controller/tab_controller_provider.dart';
import 'package:omni_common/tab_controller/tab_controller_scope.dart';

import 'app_state/app_state_controller_provider.dart';
import 'my_tab_bar.dart';
import 'my_tab_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return TabControllerScope(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          bottom: MyTabBar(height: 30),
        ),
        body: MyTabView(),
        floatingActionButton: Builder(
          builder: (context) {
            // We fetch the closest [TabControllerProvider] in the widget tree
            // and at the same time create a dependency on it. Whenever the
            // shared [TabController] updates this [Builder] will be rebuilt.
            //
            final tabController = TabControllerProvider.of(context);

            final backgroundColor = tabController.index == 0
                ? Colors.lightBlue
                : Colors.lightGreen;

            return FloatingActionButton(
              backgroundColor: backgroundColor,
              onPressed: () => _incrementCounter(tabController.index),
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            );
          },
        ),
      ),
    );
  }

  void _incrementCounter(int index) {
    // Here we request the [AppStateController] from the
    // [AppStateControllerProvider]. We use the readOrThrow call to fetch it as
    // if it's not available this is a programming issue and should't happen in
    // production.
    // Now we can use the controller ot update the app state.
    //
    final appStateController = AppStateControllerProvider.readOrThrow(context);

    if (index == 0) {
      appStateController.incrementFirst();
    } else {
      appStateController.incrementSecond();
    }
  }
}
