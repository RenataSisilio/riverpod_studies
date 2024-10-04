import 'package:flutter/material.dart';

class TextHeader extends StatelessWidget {
  const TextHeader(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.headlineLarge);
  }
}
