import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/dependency_injection.dart';
import '../../../core/errors/app_error_interfaces.dart';
import '../../../data/repositories/auth_repository.dart';
import '../auth_states.dart';

class SignUpController extends Notifier<AuthState> {
  SignUpController(this._repo);

  @override
  AuthState build() {
    return InitialAuthState();
  }

  final AuthRepository _repo;

  /// Starts the sign up call with the current values
  Future<void> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      state = LoadingAuthState();

      await _repo.signUp(
        email: email,
        password: password,
        username: username,
      );

      await _repo.signIn(username: username, password: password);
      
      state = SuccessAuthState();
    } on AppError catch (e) {
      state = ErrorAuthState(e);
    }
  }

  static final provider = NotifierProvider<SignUpController, AuthState>(
    () => SignUpController(DependencyInjection.get()),
  );
}
