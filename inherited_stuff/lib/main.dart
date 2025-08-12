import 'package:flutter/material.dart';

import 'app_state/app_state_scope.dart';
import 'my_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Here we wrap the whole app in an [AppStateScope] which in turn will
    // give all of the widget tree access to the state. Any widget that later
    // use the [AppStateProvider] to read the app state during the build phase
    // will now automatically rebuild whenever the [AppStateProvider] is
    // updated.
    //
    return AppStateScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
