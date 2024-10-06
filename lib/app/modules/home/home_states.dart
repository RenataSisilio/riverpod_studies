import '../../core/errors/app_error_interfaces.dart';
import '../../models/todo.dart';

sealed class HomeState {}

final class InitialHomeState implements HomeState {}

final class LoadingHomeState implements HomeState {}

final class SuccessHomeState implements HomeState {
  SuccessHomeState(this.todos);

  final List<Todo> todos;
}

final class ErrorHomeState implements HomeState {
  ErrorHomeState(this.error);

  final AppError error;
}
