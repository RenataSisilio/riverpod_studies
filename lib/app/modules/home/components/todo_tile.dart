import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/routes.dart';
import '../../../models/todo.dart';
import '../home_controller.dart';

class TodoTile extends ConsumerWidget {
  const TodoTile(this.todo, {super.key});

  final Todo todo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: UniqueKey(),
      confirmDismiss: (direction) => direction == DismissDirection.startToEnd
          ? _markAsDone(context, ref.read(HomeController.provider.notifier))
          : _confirmDeleteTodo(context),
      background: Container(
        color: Colors.green,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(todo.done ? Icons.undo : Icons.done),
          ),
        ),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.delete),
          ),
        ),
      ),
      child: ListTile(
        onTap: () => _openTodoPageThenUpdate(
            context, ref.read(HomeController.provider.notifier)),
        title: Text(todo.title),
        subtitle: Text(
          todo.description,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Future<bool> _openTodoPageThenUpdate(
    BuildContext context,
    HomeController notifier,
  ) async {
    await Navigator.of(context).pushNamed(Routes.todo, arguments: todo).then(
      (newTodo) {
        if (newTodo != null) {
          notifier.replace(todo, newTodo as Todo);
        }
      },
    );

    return false;
  }

  Future<bool> _markAsDone(
    BuildContext context,
    HomeController notifier,
  ) async {
    await notifier.markAsDone(todo, done: !todo.done);

    return false;
  }

  Future<bool> _confirmDeleteTodo(BuildContext context) async {
    bool dismiss = false;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Warning'),
        content: Text('Are you sure you want to delete "${todo.title}"?'),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: const Text('Cancel'),
          ),
          Consumer(
            builder: (context, ref, child) => ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                ref.read(HomeController.provider.notifier).delete(todo);
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ),
        ],
      ),
    );

    return dismiss;
  }
}
