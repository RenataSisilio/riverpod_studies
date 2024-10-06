import '../../core/errors/app_error_interfaces.dart';

sealed class TodoState {}

final class InitialTodoState implements TodoState {}

final class LoadingTodoState implements TodoState {}

final class SuccessTodoState implements TodoState {
  SuccessTodoState(this.message);

  final String message;
}

final class ErrorTodoState implements TodoState {
  ErrorTodoState(this.error);

  final AppError error;
}
