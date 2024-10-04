import 'package:flutter/material.dart';

class MissingImplementationPage extends StatelessWidget {
  const MissingImplementationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Center(
        child: Text(
          'Oh no!\nThis page have not been implemented yet.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
