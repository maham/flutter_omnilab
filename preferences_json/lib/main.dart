import 'package:flutter/material.dart';

import 'bool_row.dart';
import 'number_row.dart';
import 'preferences/preferences.dart';
import 'preferences/preferences_scope.dart';
import 'preferences/preferences_storage.dart';
import 'string_row.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Preferences _preferences = Preferences();

  void _loadData() {
    PreferencesStorage.load().then((jsonData) {
      debugPrint('jsonData:\n$jsonData');
      _preferences = Preferences.fromJson(jsonData);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: PreferencesScope(
          preferences: _preferences,
          child: SizedBox(
            width: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                BoolRow(),
                NumberRow(),
                StringRow(),
                Row(children: [Text('aNull')]),
                Row(children: [Text('aStringList')]),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadData,
        tooltip: 'Load preferences',
        child: const Icon(Icons.add),
      ),
    );
  }
}
