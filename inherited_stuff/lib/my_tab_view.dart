import 'package:flutter/material.dart';
import 'package:omni_common/tab_controller/tab_controller_provider.dart';

import 'app_state/app_state_controller.dart';
import 'app_state/app_state_provider.dart';

class MyTabView extends StatelessWidget {
  const MyTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final tabController = TabControllerProvider.of(context);

    return TabBarView(
      controller: tabController,
      children: [
        for (int index = 0; index < tabController.length; index++)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'You have pushed button ${_getAspectForIndex(index)} this many times:',
                ),
                Builder(
                  builder: (context) {
                    final appState = AppStateProvider.of(
                      context,
                      _getAspectForIndex(index),
                    );

                    final counter =
                        _getAspectForIndex(index) == StateAspect.firstCounter
                        ? appState.firstCounter
                        : appState.secondCounter;
                    return Text(
                      '$counter',
                      style: Theme.of(context).textTheme.headlineMedium,
                    );
                  },
                ),
              ],
            ),
          ),
      ],
    );
  }

  StateAspect _getAspectForIndex(int index) {
    return index == 0 ? StateAspect.firstCounter : StateAspect.secondCounter;
  }
}
