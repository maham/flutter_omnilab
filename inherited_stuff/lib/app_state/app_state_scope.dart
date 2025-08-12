import 'package:flutter/material.dart';

import 'app_state.dart';
import 'app_state_controller.dart';
import 'app_state_controller_provider.dart';
import 'app_state_provider.dart';

class AppStateScope extends StatefulWidget {
  final Widget child;

  const AppStateScope({super.key, required this.child});

  @override
  State<AppStateScope> createState() => _AppStateScopeState();
}

class _AppStateScopeState extends State<AppStateScope> {
  late final AppStateController _controller;

  @override
  void initState() {
    _controller = AppStateController(
      appState: AppState(firstCounter: 0, secondCounter: 0),
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppStateControllerProvider(
      controller: _controller,
      child: ListenableBuilder(
        listenable: _controller,
        builder: (context, _) {
          return AppStateProvider(
            appState: _controller.appState,
            updatedAspects: _controller.updatedAspects,
            child: widget.child,
          );
        },
      ),
    );
  }
}
