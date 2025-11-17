import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'preferences/preferences_model.dart';

class StringRow extends StatefulWidget {
  final double spacing;

  const StringRow({super.key, this.spacing = 100.0});

  @override
  State<StringRow> createState() => _StringRowState();
}

class _StringRowState extends State<StringRow> {
  static const Duration debounceTimeout = Duration(seconds: 1);

  late final TextEditingController _controller;
  Timer? _debounce;

  @override
  void initState() {
    _controller = TextEditingController();
    _controller.addListener(_stringChanged);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final aString = PreferencesModel.of(
      context,
      PreferencesModelAspect.aString,
    ).aString;

    final currentText = _controller.text;
    final newText = aString;
    if (currentText != newText) {
      _controller.text = newText;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: widget.spacing, child: Text('aString')),
        Expanded(
          child: TextField(
            controller: _controller,
            inputFormatters: [LengthLimitingTextInputFormatter(20)],
          ),
        ),
      ],
    );
  }

  void _stringChanged() {
    if (_controller.text.isNotEmpty) {
      _debounce?.cancel();
      _debounce = Timer(debounceTimeout, () {
        final preferencesWriter = PreferencesModel.read(context).writer;

        preferencesWriter.aString = _controller.text.trim();
      });
    }
  }
}
