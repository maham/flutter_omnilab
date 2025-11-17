import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'preferences/preferences_model.dart';

class NumberRow extends StatefulWidget {
  final double spacing;

  const NumberRow({super.key, this.spacing = 100.0});

  @override
  State<NumberRow> createState() => _NumberRowState();
}

class _NumberRowState extends State<NumberRow> {
  static const Duration debounceTimeout = Duration(seconds: 1);

  late final TextEditingController _controller;
  Timer? _debounce;

  @override
  void initState() {
    _controller = TextEditingController();
    _controller.addListener(_numberChanged);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final aNumber = PreferencesModel.of(
      context,
      PreferencesModelAspect.aNumber,
    ).aNumber;

    final currentText = _controller.text;
    final newText = aNumber.toString();
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
        SizedBox(width: widget.spacing, child: Text('aNumber')),
        Expanded(
          child: TextField(
            controller: _controller,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'-?[0-9]*')),
            ],
          ),
        ),
      ],
    );
  }

  void _numberChanged() {
    if (_controller.text.isNotEmpty) {
      _debounce?.cancel();
      _debounce = Timer(debounceTimeout, () {
        final preferencesWriter = PreferencesModel.read(context).writer;
        final number = int.parse(_controller.text.trim());

        preferencesWriter.aNumber = number;
      });
    }
  }
}
