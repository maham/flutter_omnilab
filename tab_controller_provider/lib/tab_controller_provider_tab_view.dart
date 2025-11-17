import 'package:flutter/material.dart';
import 'package:omni_common/tab_controller/tab_controller_provider.dart';

// Here we create the views for the different tabs. We get the controller from
// the [InheritedWidget] instead of passing it into the widget.
// -- MHM
class TabControllerProviderTabView extends StatelessWidget {
  final List<int> counters;

  const TabControllerProviderTabView({super.key, required this.counters});

  @override
  Widget build(BuildContext context) {
    // We use .of as trying to build the widget without a
    // [TabControllerProvider] in the widget tree is a programming error and
    // should crash the app during development.
    // -- MHM
    final tabController = TabControllerProvider.of(context);

    return TabBarView(
      controller: tabController,
      children: [
        for (int i = 0; i < counters.length; i++)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              Text('You have pushed the button this many times for tab $i:'),
              Text(
                '${counters[i]}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
      ],
    );
  }
}
