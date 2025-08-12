import 'package:flutter/material.dart';
import 'package:omni_common/tab_controller/tab_controller_provider.dart';

import 'tab_controller_provider_tab_bar.dart';
import 'tab_controller_provider_tab_view.dart';

class TabControllerProviderHomePage extends StatefulWidget {
  const TabControllerProviderHomePage({
    super.key,
    required this.title,
    required this.length,
  });
  final String title;
  final int length;

  @override
  State<TabControllerProviderHomePage> createState() =>
      _TabControllerProviderHomePageState();
}

class _TabControllerProviderHomePageState
    extends State<TabControllerProviderHomePage> {
  late final List<int> _counters;

  @override
  void initState() {
    // Here .read is used instead of .maybeOf or .of as we don't need a
    // dependency on the TabControllerProvider here.
    // note: A dependency wouldn't be set up anyway as it's only during the
    //       build phase that Flutter set this up. But it's better to be
    //       explicit about it.
    // -- MHM
    final tabController = TabControllerProvider.read(context);

    // Null assertion is used here as if there is no
    // TabControllerProvider in the widget tree we have a programming
    // error and we don't want to hide this.
    // -- MHM
    _counters = [for (int i = 0; i < tabController!.length; i++) 0];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // We increment the counter with the same index as the currently selected
    // tab.
    // The onPressed callback is made inline so that we have access to the
    // context without passing it around.
    // -- MHM
    void incrementCounter() {
      final tabController = TabControllerProvider.read(context);

      // We'd better make sure this call isn't made after the widget is
      // disposed.
      // -- MHM
      if (mounted) {
        setState(() {
          _counters[tabController!.index]++;
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TabControllerProviderTabBar(),
            Expanded(child: TabControllerProviderTabView(counters: _counters)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
