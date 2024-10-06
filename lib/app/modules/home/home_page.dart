import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/routes.dart';
import '../../models/todo.dart';
import 'components/todo_tile.dart';
import 'home_controller.dart';
import 'home_states.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(HomeController.provider);
    final notifier = ref.read(HomeController.provider.notifier);

    if (homeState is InitialHomeState) {
      Future(() => notifier.getMyTodos());
    }

    return Scaffold(
      appBar: AppBar(title: const Text('My Homes')),
      body: switch (homeState) {
        InitialHomeState() ||
        LoadingHomeState() =>
          const Center(child: CircularProgressIndicator()),
        ErrorHomeState() => Center(
            child: Text(
              homeState.error.message,
              textAlign: TextAlign.center,
            ),
          ),
        SuccessHomeState() => homeState.todos.isEmpty
            ? const Center(
                child: Text('You did\nt add any todos yet.'),
              )
            : ListView.builder(
                itemCount: homeState.todos.length,
                itemBuilder: (context, index) =>
                    TodoTile(homeState.todos[index]),
              ),
      },
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .pushNamed(Routes.todo)
            .then((newTodo) => notifier.add(newTodo as Todo)),
        tooltip: 'Add todo',
        child: const Icon(Icons.add),
      ),
    );
  }
}
