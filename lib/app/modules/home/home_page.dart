import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_controller.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Center(
          child: Text(
            ref.watch(HomeController.provider).toString(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ref.read(HomeController.provider).increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}
