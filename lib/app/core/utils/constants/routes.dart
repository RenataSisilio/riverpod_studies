abstract interface class Routes {
  static const root = '/';
  static const missingImpl = '/missing-implementation';

  static const signIn = '/auth/sign-in';
  static const signUp = '/auth/sign-up';
  static const recoveryPassword = '/auth/recovery-password';

  static const home = '/home';
}
