import 'dart:developer';

import 'package:get_it/get_it.dart';

import '../client/auth_client_interface.dart';
import '../client/parse_sdk_auth_client.dart';
import '../data/repositories/auth_repository.dart';

abstract final class DependencyInjection {
  static final getIt = GetIt.instance;

  static T get<T extends Object>() => getIt.get();

  static void setAllDependencies() {
    getIt.registerSingleton<AuthClientInterface>(ParseSdkAuthClient());

    getIt.registerSingleton(AuthRepository(getIt.get()));

    log('All global dependencies successfully registered!');
  }
}
