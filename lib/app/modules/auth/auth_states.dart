import '../../core/errors/app_error_interfaces.dart';

sealed class AuthState {}

final class InitialAuthState implements AuthState {}

final class LoadingAuthState implements AuthState {}

final class SuccessAuthState implements AuthState {}

final class ErrorAuthState implements AuthState {
  ErrorAuthState(this.error);

  final AppError error;
}
