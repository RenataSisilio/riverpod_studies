import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/todo.dart';
import 'components/description_field.dart';
import 'components/title_field.dart';
import 'todo_controller.dart';
import 'todo_states.dart';

class TodoPage extends StatefulWidget {
  const TodoPage(this.originalTodo, {super.key});

  final Todo? originalTodo;

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final title = TextEditingController();
  final description = TextEditingController();

  @override
  Widget build(context) {
    title.text = widget.originalTodo?.title ?? '';
    description.text = widget.originalTodo?.description ?? '';

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Consumer(
            builder: (context, ref, child) {
              ref.listen(
                TodoController.provider,
                (_, next) => switch (next) {
                  ErrorTodoState() => _exitDialogAndShowSnackbar(context, next),
                  SuccessTodoState() => _exitPageAndShowSnackbar(context, next),
                  LoadingTodoState() => _showLoadingAsDialog(context),
                  InitialTodoState() => null,
                },
              );

              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TitleField(
                    title: title,
                    onSubmitted: (value) => _saveTodo(value, ref),
                  ),
                  const SizedBox(height: 16),
                  DescriptionField(
                    description: description,
                    onSubmitted: (value) => _saveTodo(value, ref),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<dynamic> _showLoadingAsDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );
  }

  Future<void> _saveTodo(String value, WidgetRef ref) async {
    if (value != '') {
      ref
          .read(TodoController.provider.notifier)
          .saveTodo(newTitle: title.text, newDescription: description.text);
    }
  }

  Future<void> _exitDialogAndShowSnackbar(
    BuildContext context,
    ErrorTodoState state,
  ) async {
    Navigator.of(context).maybePop();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(state.error.message)),
    );
  }

  Future<void> _exitPageAndShowSnackbar(
    BuildContext context,
    SuccessTodoState state,
  ) async {
    Navigator.of(context)
      ..maybePop() // exits loading dialog
      ..maybePop(widget.originalTodo); // exits page

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(state.message)),
    );
  }
}
