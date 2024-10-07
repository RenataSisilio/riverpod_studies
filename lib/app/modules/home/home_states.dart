import '../../core/errors/app_error_interfaces.dart';
import '../../models/todo.dart';

sealed class HomeState {}

final class InitialHomeState implements HomeState {}

final class LoadingHomeState implements HomeState {}

final class SuccessHomeState implements HomeState {
  SuccessHomeState(this.todos);

  /// A list with all the ```Todo```s
  /// that belong to the current ```User```.
  final List<Todo> todos;
}

final class ErrorHomeState implements HomeState {
  ErrorHomeState(this.error);

  /// The thrown ```AppError```.
  ///
  /// It can be a ```ExternalError```, a ```DataError```,
  /// or any class that extends ```AppError```.
  final AppError error;
}
