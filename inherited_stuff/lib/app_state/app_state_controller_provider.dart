import 'package:flutter/material.dart';

import 'app_state_controller.dart';

/// A provider for sharing the [AppStateController] to the widget tree. This
/// way we can easily replace the controller when testing. And we don't have to
/// use singletons or static calls to provide access to the controller.
///
class AppStateControllerProvider extends InheritedWidget {
  final AppStateController controller;

  const AppStateControllerProvider({
    super.key,
    required super.child,
    required this.controller,
  });

  /// Returns the [AppStateController] of the closest
  /// [AppStateControllerProvider] in the widget tree.
  ///
  static AppStateController? read(BuildContext context) {
    final element = context
        .getElementForInheritedWidgetOfExactType<AppStateControllerProvider>();

    return (element?.widget as AppStateControllerProvider?)?.controller;
  }

  /// Convenience wrapper for when we know there should be an
  /// [AppStateControllerProvider] in the widget tree and we want to make sure
  /// the app throws otherwise.
  ///
  static AppStateController readOrThrow(BuildContext context) {
    final controller = read(context);

    if (controller == null) {
      throw FlutterError(
        'AppStateControllerProvider.of() called with a context that does not contain a AppStateControllerProvider.',
      );
    }

    return controller;
  }

  /// Never notify dependents as the shared [AppStateController] should never
  /// change runtime.
  ///
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
