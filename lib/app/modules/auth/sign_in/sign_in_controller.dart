import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/dependency_injection.dart';
import '../../../core/errors/app_error_interfaces.dart';
import '../../../data/repositories/auth_repository.dart';
import '../auth_states.dart';

class SignInController extends Notifier<AuthState> {
  SignInController(this._repo);

  @override
  AuthState build() {
    return InitialAuthState();
  }

  final AuthRepository _repo;

  /// Starts the sign up call with the current values
  Future<void> signIn({
    required String username,
    required String password,
  }) async {
    try {
      state = LoadingAuthState();

      await _repo.signIn(username: username, password: password);

      state = SuccessAuthState();
    } on AppError catch (e) {
      state = ErrorAuthState(e);
    }
  }

  static final provider = NotifierProvider<SignInController, AuthState>(
    () => SignInController(DependencyInjection.get()),
  );
}
