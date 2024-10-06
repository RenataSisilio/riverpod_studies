import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/core/dependency_injection.dart';
import 'app/core/utils/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection.setGlobalDependencies();
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
      routes: Routes.routes,
    );
  }
}
