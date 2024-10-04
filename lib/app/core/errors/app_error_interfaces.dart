abstract interface class AppError {
  AppError(this.message);

  final String message;
}

abstract interface class ClientError implements AppError {}

abstract interface class DataError implements AppError {}

