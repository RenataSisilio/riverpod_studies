abstract interface class AuthClientInterface {
  /// Creates a new user.
  ///
  /// Returns the data retrieved from API.
  Future signUp(Map<String, dynamic> data);

  /// Authenticates an user.
  ///
  /// Returns the data retrieved from API (expectedly, the token).
  Future signIn(Map<String, dynamic> data);

  /// Unauthenticates the current user (clearing token data).
  ///
  /// Returns the data retrieved from API.
  Future signOut();

  /// Deletes the current user (and ALL ITS AUTH DATA from the API).
  ///
  /// Returns the data retrieved from API.
  Future delete();
}
