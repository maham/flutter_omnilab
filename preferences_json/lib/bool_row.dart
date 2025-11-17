import 'package:flutter/material.dart';

import 'preferences/preferences_model.dart';
import 'preferences/preferences_writer.dart';

class BoolRow extends StatelessWidget {
  final double spacing;

  const BoolRow({super.key, this.spacing = 100});

  @override
  Widget build(BuildContext context) {
    final aBool = PreferencesModel.of(
      context,
      PreferencesModelAspect.aBool,
    ).aBool;
    final preferencesWriter = PreferencesModel.of(context).writer;

    return Row(
      children: [
        SizedBox(width: spacing, child: Text('aBool')),
        Checkbox(
          value: aBool,
          onChanged: (value) => _boolChanged(preferencesWriter, value),
        ),
      ],
    );
  }

  void _boolChanged(PreferencesWriter writer, bool? value) {
    if (value != null) {
      writer.aBool = value;
    }
  }
}
