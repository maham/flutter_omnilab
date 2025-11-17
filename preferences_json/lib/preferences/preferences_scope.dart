import 'package:flutter/widgets.dart';

import 'preferences.dart';
import 'preferences_model.dart';
import 'preferences_storage.dart';

class PreferencesScope extends StatefulWidget {
  final Preferences preferences;
  final Widget child;

  const PreferencesScope({
    super.key,
    required this.preferences,
    required this.child,
  });

  @override
  State<PreferencesScope> createState() => _PreferencesScopeState();
}

class _PreferencesScopeState extends State<PreferencesScope> {
  late final PreferencesStorage _storage;

  @override
  void initState() {
    PreferencesStorage.load().then((json) {
      widget.preferences.updateWith(json);
      _storage = PreferencesStorage(widget.preferences);
    });

    super.initState();
  }

  @override
  void dispose() {
    _storage.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.preferences,
      builder: (context, _) {
        return PreferencesModel(
          aBool: widget.preferences.aBool,
          aNumber: widget.preferences.aNumber,
          aString: widget.preferences.aString,
          writer: widget.preferences,
          lastUpdatedAspects: widget.preferences.updatedAspects,
          child: widget.child,
        );
      },
    );
  }
}
