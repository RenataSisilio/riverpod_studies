import 'app_error_interfaces.dart';

final class InvalidDataFormatError implements DataError {
  InvalidDataFormatError({required this.modelName, required this.data});
  
  final Type modelName;
  final Map<String, dynamic> data;
  
  @override
  String get message => 'Invalid data format.\n$data cannot be turned into the type "$modelName".';
}

final class UnhandledClientTypeError implements DataError {
  UnhandledClientTypeError({required this.modelName, required this.clientType});

  final Type modelName;
  final Type clientType;

  @override
  String get message =>
      'Ainda não foi feita a implementação do mapping de ${modelName.toString().toUpperCase()} para o client $clientType';
}
