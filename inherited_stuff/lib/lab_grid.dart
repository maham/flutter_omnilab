import 'package:flutter/material.dart';

class LabGrid extends StatelessWidget {
  const LabGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(crossAxisCount: 2, children: []);
  }
}
