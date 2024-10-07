import 'package:flutter/widgets.dart';

import '../../models/todo.dart';
import '../../modules/modules_export.dart';
import '../dependency_injection.dart';
import '../widgets/missing_implementation_page.dart';

abstract interface class Routes {
  /// Initial route of the app (or the module)
  static const root = '/';

  /// Route to the default "missing implementation" page,
  /// for all the pages that are still missing.
  static const missingImpl = '/missing-implementation';

  static const signIn = '/auth/sign-in';
  static const signUp = '/auth/sign-up';
  static const recoveryPassword = '/auth/recovery-password';

  static const home = '/home';

  static const todo = '/todo';

  /// The application's top-level routing table.
  ///
  /// When a named route is pushed with [Navigator.pushNamed],
  /// the route name is looked up in this map. If the name is present,
  /// the associated [widgets.WidgetBuilder] is used
  /// to construct a [MaterialPageRoute] that performs an appropriate transition,
  /// including [Hero] animations, to the new route.
  ///
  /// (souce: [MaterialApp.routes])
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
