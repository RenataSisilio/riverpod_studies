import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import 'app_error_interfaces.dart';

final class InvalidSessionError implements ClientError {
  @override
  // TODO: improve UX (like refreshing token or something like that)
  String get message => 'Invalid session. Please try to login again.';
}

final class UserNotFoundClientError implements ClientError {
  UserNotFoundClientError(this._email);

  final String _email;

  @override
  String get message => 'User not found: $_email';
}

final class ParseSdkClientError implements ClientError {
  ParseSdkClientError(this._error);

  final ParseError _error;

  @override
  String get message => _error.message;
}
