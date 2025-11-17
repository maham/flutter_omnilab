import 'package:flutter/material.dart';

/// Provides a [TabController] to the widget subtree and exposes convenient
/// accessors to either *listen* to it or *read* it without subscribing.
///
/// This is a thin wrapper around [InheritedNotifier] wired to a
/// [TabController]. Widgets that obtain the controller via [of] or [maybeOf]
/// establish a dependency and will rebuild when the controller notifies
/// (e.g. index/animation changes). Widgets that call [read] get the same
/// controller without creating a dependency.
///
/// Use this when:
/// - You want a single [TabController] shared across a subtree (e.g. for a
///   `TabBar` and a `TabBarView` living in different widgets).
/// - Some consumers should rebuild with tab changes (use [of]/[maybeOf]),
///   while others only need imperative access (use [read]).
///
/// Example:
/// ```dart
/// class TabsScaffold extends StatefulWidget {
///   const TabsScaffold({super.key});
///   @override
///   State<TabsScaffold> createState() => _TabsScaffoldState();
/// }
///
/// class _TabsScaffoldState extends State<TabsScaffold>
///     with SingleTickerProviderStateMixin {
///   late final TabController _controller;
///
///   @override
///   void initState() {
///     super.initState();
///     _controller = TabController(length: 3, vsync: this);
///   }
///
///   @override
///   void dispose() {
///     _controller.dispose();
///     super.dispose();
///   }
///
///   @override
///   Widget build(BuildContext context) {
///     return TabControllerProvider(
///       tabController: _controller,
///       child: Scaffold(
///         appBar: AppBar(
///           bottom: TabBar(controller: TabControllerProvider.of(context), tabs: const [
///             Tab(text: 'A'), Tab(text: 'B'), Tab(text: 'C')
///           ]),
///         ),
///         body: const _Body(),
///       ),
///     );
///   }
/// }
///
/// class _Body extends StatelessWidget {
///   const _Body();
///   @override
///   Widget build(BuildContext context) {
///     final controller = TabControllerProvider.read(context); // no rebuilds
///     return TabBarView(controller: controller, children: const [ ... ]);
///   }
/// }
/// ```
///
/// Notes:
/// - Because this extends [InheritedNotifier], any widget that depends on it
///   via [of]/[maybeOf] will rebuild when the [TabController] notifies.
/// - [read] is safe for imperative calls (e.g. `controller.animateTo(2)`)
///   without tying the caller to rebuilds.
///
/// -- Dartdoc comment by ChatGPT
///
class TabControllerProvider extends InheritedNotifier<TabController> {
  const TabControllerProvider({
    required TabController tabController,
    required super.child,
    super.key,
  }) : super(notifier: tabController);

  /// Returns the nearest [TabController] and establishes a dependency on the
  /// surrounding [TabControllerProvider].
  ///
  /// Returns `null` if no [TabControllerProvider] ancestor is found in the
  /// widget tree.
  ///
  static TabController? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TabControllerProvider>()
        ?.notifier;
  }

  /// Returns the nearest [TabController] and establishes a dependency on the
  /// surrounding [TabControllerProvider].
  ///
  /// Throws a [FlutterError] if no [TabControllerProvider] ancestor is found in the
  /// widget tree.
  ///
  static TabController of(BuildContext context) {
    final tabController = maybeOf(context);

    if (tabController == null) {
      throw FlutterError(
        'TabControllerProvider.of() called with a context that does not contain a TabControllerProvider.',
      );
    }

    return tabController;
  }

  /// Returns the nearest [TabController] without listening to the
  /// [TabControllerProvider].
  ///
  /// Returns `null` if no [TabControllerProvider] ancestor is found in the
  /// widget tree.
  ///
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
