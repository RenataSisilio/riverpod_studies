import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/routes.dart';
import 'components/todo_tile.dart';
import 'home_controller.dart';
import 'home_states.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final showDoneTodos = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final homeState = ref.watch(HomeController.provider);
        final notifier = ref.read(HomeController.provider.notifier);

        if (homeState is InitialHomeState) {
          Future(() => notifier.getMyTodos());
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('My Todos'),
            actions: [
              ValueListenableBuilder(
                valueListenable: showDoneTodos,
                builder: (context, value, child) => SegmentedButton(
                  segments: const [
                    ButtonSegment(value: false, label: Text('To do')),
                    ButtonSegment(value: true, label: Text('Done')),
                  ],
                  onSelectionChanged: (set) => showDoneTodos.value = set.last,
                  selected: {value},
                ),
              ),
            ],
          ),
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
                    child: Text('You didn\'t add any todos yet.'),
                  )
                : ValueListenableBuilder(
                    valueListenable: showDoneTodos,
                    builder: (context, value, child) {
                      final todosToShow =
                          homeState.todos.where((e) => e.done == value);
                      return todosToShow.isEmpty
                          ? Center(
                              child: Text(
                                  'You have no ${value ? 'done' : 'undone'} todos.'),
                            )
                          : ListView.builder(
                              itemCount: todosToShow.length,
                              itemBuilder: (context, index) =>
                                  TodoTile(todosToShow.elementAt(index)),
                            );
                    },
                  ),
          },
          floatingActionButton: FloatingActionButton(
            onPressed: () => _createNewTodo(context, notifier),
            tooltip: 'Add todo',
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  void _createNewTodo(BuildContext context, HomeController notifier) {
    Navigator.of(context).pushNamed(Routes.todo).then(
          (_) => notifier.getMyTodos(),
        );
  }
}
