import 'package:flutter/widgets.dart';

import '../../models/todo.dart';
import '../../modules/modules_export.dart';
import '../dependency_injection.dart';
import '../widgets/missing_implementation_page.dart';

abstract interface class Routes {
  static const root = '/';
  static const missingImpl = '/missing-implementation';

  static const signIn = '/auth/sign-in';
  static const signUp = '/auth/sign-up';
  static const recoveryPassword = '/auth/recovery-password';

  static const home = '/home';

  static const todo = '/todo';

  // TODO: document
  static final routes = {
        Routes.signIn: (context) => const SignInPage(),
        Routes.signUp: (context) => const SignUpPage(),
        Routes.recoveryPassword: (context) => const RecoveryPasswordPage(),
        Routes.home: (context) {
          DependencyInjection.setHomeDependencies();
          return const HomePage();
        },
        Routes.todo: (context) => TodoPage(
              ModalRoute.of(context)!.settings.arguments as Todo?,
            ),
        Routes.missingImpl: (context) => const MissingImplementationPage(),
      };
}
