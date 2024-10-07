abstract interface class AppError {
  AppError(this.message);

  /// A friendly error message to show to the final user.
  final String message;
}

abstract interface class ClientError implements AppError {}

abstract interface class DataError implements AppError {}

