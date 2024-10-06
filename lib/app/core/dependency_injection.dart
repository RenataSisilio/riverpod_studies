import 'dart:developer';

import 'package:get_it/get_it.dart';

import '../client/auth_client_interface.dart';
import '../client/client_interface.dart';
import '../client/parse_sdk_auth_client.dart';
import '../client/parse_sdk_client.dart';
import '../data/repositories/auth_repository.dart';
import '../data/repositories/todo_repository.dart';

abstract final class DependencyInjection {
  static final getIt = GetIt.instance;

  static T get<T extends Object>() => getIt.get();

  static void setGlobalDependencies() {
    getIt.registerSingleton<AuthClientInterface>(ParseSdkAuthClient());

    getIt.registerLazySingleton<ClientInterface>(() => ParseSdkClient());

    getIt.registerSingleton(AuthRepository(getIt.get()));

    log('All global dependencies successfully registered!');
  }

  static void setHomeDependencies() {
    if (!getIt.isRegistered<TodoRepository>()) {
      getIt.registerLazySingleton(() => TodoRepository(getIt.get()));
    }

    log('All Home dependencies successfully registered!');
  }

  static void disposeHomeDependencies() {
    getIt.unregister<TodoRepository>();

    log('All Home dependencies successfully disposed!');
  }
}
