import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/dependency_injection.dart';
import '../../../core/errors/app_error_interfaces.dart';
import '../../../data/repositories/auth_repository.dart';
import '../auth_states.dart';

class RecoveryPasswordController extends Notifier<AuthState> {
  RecoveryPasswordController(this._repo);

  @override
  AuthState build() {
    return LoadingAuthState();
  }

  final AuthRepository _repo;

  /// Controller for user's email field.
  final email = TextEditingController();

  /// Controller for user's new password field.
  final newPassword = TextEditingController();

  /// Starts the reset password process.
  Future<void> resetPassword() async {
    try {
      // TODO: implement reset password complete flow
      await _repo.sendResetPasswordEmail(email.text);
    } on AppError catch (e) {
      state = ErrorAuthState(e);
    }
  }

  static final provider =
      NotifierProvider<RecoveryPasswordController, AuthState>(
    () => RecoveryPasswordController(DependencyInjection.get()),
  );
}
