import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/dependency_injection.dart';
import '../../core/errors/app_error_interfaces.dart';
import '../../data/repositories/todo_repository.dart';
import '../../models/todo.dart';
import 'home_states.dart';

final class HomeController extends Notifier<HomeState> {
  HomeController(this._repo);

  @override
  HomeState build() => InitialHomeState();

  final TodoRepository _repo;
  final _todos = <Todo>[];

  Future<void> getMyTodos() async {
    try {
      state = LoadingHomeState();

      _todos.clear();
      _todos.addAll(await _repo.getMyTodos());

      state = SuccessHomeState(_todos);
    } on AppError catch (e) {
      state = ErrorHomeState(e);
    }
  }

  Future<void> delete(Todo todo) async {
    try {
      state = LoadingHomeState();

      await _repo.delete(todo);

      _todos.remove(todo);

      state = SuccessHomeState(_todos);
    } on AppError catch (e) {
      state = ErrorHomeState(e);
    }
  }

  void replace(Todo originalTodo, Todo savedTodo) {
    final index = _todos.indexOf(originalTodo);

    _todos.replaceRange(index, index + 1, [savedTodo]);

    state = SuccessHomeState(_todos);
  }

  static final provider = NotifierProvider<HomeController, HomeState>(
      () => HomeController(DependencyInjection.get()));
}
