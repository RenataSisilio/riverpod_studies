import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import 'app_error_interfaces.dart';

final class InvalidSessionError implements AppError {
  @override
  // TODO: improve UX
  String get message => 'Invalid session. Please try to login again.';
}

final class UserNotFoundClientError implements AppError {
  UserNotFoundClientError(this.email);

  final String email;

  @override
  String get message => 'User not found: $email';
}

final class ParseSdkClientError implements AppError {
  ParseSdkClientError(this.error);

  final ParseError error;

  @override
  String get message => error.message;
}
