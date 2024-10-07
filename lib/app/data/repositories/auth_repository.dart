import '../../client/auth_client_interface.dart';
import '../../core/utils/constants/messages.dart';
import '../../models/user.dart';
import '../mappings/user_mapping.dart';

// TODO: review doc
final class AuthRepository {
  AuthRepository(this._client);

  final AuthClientInterface _client;

  /// Creates a new user and authenticates it.
  ///
  /// Returns true in case of success, and throws (or rethrows) an specific error in case.
  Future<bool> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final user = User(username: username, email: email, password: password);

      final data = user.toMap(_client);

      await _client.signUp(data);

      return true;
    } catch (e) {
      rethrow;
    }
  }

  /// Authenticates an user.
  ///
  /// Returns true in case of success, and throws (or rethrows) an specific error in case.
  Future<bool> signIn({
    required String password,
    required String username,
  }) async {
    try {
      final user = User(
        username: username,
        password: password
      );

      final data = user.toMap(_client);

      await _client.signIn(data);

      return true;
    } catch (e) {
      rethrow;
    }
  }

  /// Unauthenticates the current user (clearing token data).
  ///
  /// Returns a success message for the user, or rethrows the client error.
  Future<String> signOut() async {
    try {
      await _client.signOut();

      return Messages.successfulSignOut;
    } catch (e) {
      rethrow;
    }
  }

  /// Deletes the current user (and ALL ITS AUTH DATA from the API).
  ///
  /// Returns a success message for the user, or rethrows the client error.
  Future<String> delete() async {
    try {
      await _client.delete();

      return Messages.successfulDeleteUser;
    } catch (e) {
      rethrow;
    }
  }

  /// Locally saves the current user.
  ///
  /// Returns ```true``` in case of success.
  Future<bool> saveUserLocally() {
    // TODO: implement user persistency
    throw UnimplementedError();
  }

  /// Retrieves the current user from local storage.
  ///
  /// Returns ```true``` in case of success.
  Future<bool> getCurrentUser() {
    // TODO: implement user persistency (retrieve)
    throw UnimplementedError();
  }

  /// Sends an email to verify user's email adress.
  ///
  /// Returns a success message for the user, or rethrows the client error.
  Future<String> sendVerificationEmail(String email) async {
    // TODO: implement sendVerificationEmail
    throw UnimplementedError();
  }

  /// Sends an email to reset user's password.
  ///
  /// Returns the validation token in case of success.
  Future<String> sendResetPasswordEmail(String email) async {
    // TODO: implement sendResetPasswordEmail
    throw UnimplementedError();
  }

  /// Resets user's password.
  ///
  /// Returns a success message for the user, or rethrows the client error.
  Future<bool> resetPassword({
    required String email,
    required String token,
    required String newPassword,
  }) async {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }
}
