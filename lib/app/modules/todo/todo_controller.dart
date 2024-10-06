import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/dependency_injection.dart';
import '../../core/errors/app_error_interfaces.dart';
import '../../data/repositories/todo_repository.dart';
import '../../models/todo.dart';
import 'todo_states.dart';

final class TodoController extends Notifier<TodoState> {
  TodoController(this._repo);

  @override
  TodoState build() => InitialTodoState();

  final TodoRepository _repo;

  Future<void> saveTodo({
    required String newTitle,
    required String newDescription,
    Todo? originalTodo,
  }) async {
    try {
      state = LoadingTodoState();

      final (message, savedTodo) = originalTodo == null
          ? await _repo.create(
              title: newTitle,
              description: newDescription,
            )
          : await _repo.edit(
              originalTodo: originalTodo,
              newTitle: newTitle,
              newDescription: newDescription,
            );

      state = SuccessTodoState(message);
    } on AppError catch (e) {
      state = ErrorTodoState(e);
    }
  }

  static final provider = NotifierProvider<TodoController, TodoState>(
      () => TodoController(DependencyInjection.get()));
}
