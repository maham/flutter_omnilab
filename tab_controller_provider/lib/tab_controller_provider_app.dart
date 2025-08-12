import 'package:flutter/material.dart';
import 'package:omni_common/tab_controller/tab_controller_scope.dart';

import 'tab_controller_provider_home_page.dart';

/// This app is a demo of how to use an [InheritedNotifier] for a [TabController].
///
class TabControllerProviderApp extends StatelessWidget {
  const TabControllerProviderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: TabControllerScope(
        length: 5,
        child: const TabControllerProviderHomePage(
          title: 'TabControllerProvider demo page',
          length: 5,
        ),
      ),
    );
  }
}
