import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../core/errors/client_errors.dart';
import '../core/private/parse_sdk_keys.dart';
import 'auth_client_interface.dart';

final class ParseSdkAuthClient implements AuthClientInterface {
  ParseSdkAuthClient() {
    Parse().initialize(
      keyApplicationId,
      keyParseServerUrl,
      clientKey: keyClientKey,
      debug: true,
    );
  }

  @override
  Future delete() async {
    try {
      final currentUser = await ParseUser.currentUser() as ParseUser?;

      if (currentUser == null) {
        throw InvalidSessionError();
      }

      final response = await currentUser.destroy();

      return response?.result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future signIn(Map<String, dynamic> data) async {
    try {
      final username = data['username'].trim();
      final password = data['password'].trim();

      final user = ParseUser(username, password, null);

      var response = await user.login();

      if (response.success) {
        return response.result;
      } else {
        throw ParseSdkClientError(response.error!);
      }

      // According to the doc, this should work, but it isn't
      //
      // final queryUsers = QueryBuilder<ParseUser>(ParseUser.forQuery());
      // final apiResponse = await queryUsers.query();

      // if (apiResponse.success && apiResponse.results != null) {
      //   for (var user in apiResponse.results!) {
      //     if (user case ParseUser()) {
      //       if (user.emailAddress == data['email']) {
      //         user.set('password', data['password']);
      //         await user.save();
      //         log(user.sessionToken ?? 'null sessionToken');
      //         final response = await user.login();

      //         return response.success
      //             ? response.result
      //             : throw ParseSdkClientError(response.error!);
      //       }
      //     }
      //   }
      // }
      // throw UserNotFoundClientError(data['email']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future signOut() async {
    try {
      final currentUser = await ParseUser.currentUser() as ParseUser?;

      if (currentUser == null) {
        throw InvalidSessionError();
      }

      final response = await currentUser.logout();

      return response.result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future signUp(Map<String, dynamic> data) async {
    try {
      final user = ParseUser.createUser(
        data['username'].trim(),
        data['password'].trim(),
        data['email'].trim(),
      );

      var response = await user.signUp();

      return response.success
          ? response.result
          : throw ParseSdkClientError(response.error!);
    } catch (e) {
      rethrow;
    }
  }
}
