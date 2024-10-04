import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/core/dependency_injection.dart';
import 'app/core/utils/constants/routes.dart';
import 'app/core/widgets/missing_implementation_page.dart';
import 'app/modules/auth/recovery_password/recovery_password_page.dart';
import 'app/modules/auth/sign_in/sign_in_page.dart';
import 'app/modules/auth/sign_up/sign_up_page.dart';
import 'app/modules/home/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection.setAllDependencies();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: Routes.signIn,
      routes: {
        Routes.signIn: (context) => const SignInPage(),
        Routes.signUp: (context) => const SignUpPage(),
        Routes.recoveryPassword: (context) => const RecoveryPasswordPage(),
        Routes.home: (context) => const HomePage(title: 'Home Page'),
        Routes.missingImpl: (context) => const MissingImplementationPage(),
      },
    );
  }
}
