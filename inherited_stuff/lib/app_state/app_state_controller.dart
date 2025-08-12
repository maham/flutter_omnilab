import 'package:flutter/material.dart';

import 'app_state.dart';

enum StateAspect { firstCounter, secondCounter }

/// The owner of the [AppState] and the place to mutate it.
///
class AppStateController extends ChangeNotifier {
  AppState appState;
  final Set<StateAspect> updatedAspects = {};

  AppStateController({required this.appState});

  /// Interface for incrementing firstCounter
  ///
  /// As we want to make sure updates are pushed by the InheritedModel we don't
  /// want anyone to touch the appState directly.
  ///
  void incrementFirst() {
    _update(firstCounter: appState.firstCounter + 1);
  }

  /// Interface for incrementing secondCounter
  ///
  /// As we want to make sure updates are pushed by the InheritedModel we don't
  /// want anyone to touch the appState directly.
  ///
  void incrementSecond() {
    _update(secondCounter: appState.secondCounter + 1);
  }

  /// Takes care of updating the [appState]; uppdating [updatedAspects] and
  /// notifying listeners.
  ///
  /// This makes sure we can provide a summary of which aspects was changed
  ///
  void _update({int? firstCounter, int? secondCounter}) {
    updatedAspects.clear();

    // This inline function makes it easy to track which aspect was updated.
    // We store the [Set] of updated aspects so that [AppStateProvider] can
    // use this to tell if a dependent needs to be notified.
    //
    T? trackChange<T>(StateAspect aspect, T? value) {
      if (value != null) {
        updatedAspects.add(aspect);
      }

      return value;
    }

    appState = appState.copyWith(
      firstCounter: trackChange(StateAspect.firstCounter, firstCounter),
      secondCounter: trackChange(StateAspect.secondCounter, secondCounter),
    );

    notifyListeners();
  }
}
