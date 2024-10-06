import '../../client/auth_client_interface.dart';
import '../../client/parse_sdk_auth_client.dart';
import '../../core/errors/data_errors.dart';
import '../../models/user.dart';

extension Mapping on User {
  Map<String, dynamic> toMap(AuthClientInterface client) {
    return switch (client) {
      ParseSdkAuthClient() => {
          'objectId': id,
          'username': username,
          'email': email,
          'password': password,
          'friends': friends,
        },
      _ => throw UnhandledClientTypeError(
          modelName: runtimeType,
          clientType: client.runtimeType,
        ),
    };
  }
}

User userFromMap(Map<String, dynamic> map) {
  return switch (map) {
    {
      'objectId': String id,
      'username': String username,
      'email': String email,
      'password': String password,
      'friends': List? friends
    } =>
      User(
        id: id,
        username: username,
        email: email,
        password: password,
        friends: friends == null ? [] : [...friends.map((e) => e as String)],
      ),
    _ => throw InvalidDataFormatError(modelName: User, data: map),
  };
}
