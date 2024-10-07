import 'app_error_interfaces.dart';

final class InvalidDataFormatError implements DataError {
  InvalidDataFormatError({required Type modelName, required Map<String, dynamic> data}) : _data = data, _modelName = modelName;
  
  final Type _modelName;
  final Map<String, dynamic> _data;
  
  @override
  String get message => 'Invalid data format.\n$_data cannot be turned into the type "$_modelName".';
}

final class UnhandledClientTypeError implements DataError {
  UnhandledClientTypeError({required Type modelName, required Type clientType}) : _clientType = clientType, _modelName = modelName;

  final Type _modelName;
  final Type _clientType;

  @override
  String get message =>
      'Ainda não foi feita a implementação do mapping de ${_modelName.toString().toUpperCase()} para o client $_clientType';
}
