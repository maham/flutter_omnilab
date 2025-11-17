import 'package:flutter/material.dart';

import 'app_state.dart';
import 'app_state_controller.dart';

class AppStateProvider extends InheritedModel<StateAspect> {
  final AppState appState;
  final Set<StateAspect> updatedAspects;

  const AppStateProvider({
    super.key,
    required super.child,
    required this.appState,
    required this.updatedAspects,
  });

  static AppState? maybeOf(BuildContext context, StateAspect aspect) {
    return InheritedModel.inheritFrom<AppStateProvider>(
      context,
      aspect: aspect,
    )?.appState;
  }

  static AppState of(BuildContext context, StateAspect aspect) {
    final appState = maybeOf(context, aspect);

    if (appState == null) {
      throw FlutterError(
        'AppStateProvider.of() called with a context that does not contain a AppStateProvider.',
      );
    }

    return appState;
  }

  @override
  bool updateShouldNotify(AppStateProvider oldWidget) => true;

  @override
  bool updateShouldNotifyDependent(
    AppStateProvider oldWidget,
    Set<StateAspect> dependencies,
  ) {
    return dependencies.intersection(updatedAspects).isNotEmpty;
  }
}
