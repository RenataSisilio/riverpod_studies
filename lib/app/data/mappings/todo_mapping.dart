import '../../client/client_interface.dart';
import '../../client/parse_sdk_client.dart';
import '../../core/errors/data_errors.dart';
import '../../models/todo.dart';

extension Mapping on Todo {
  /// Turns the todo data into a ```Map```, based on the current client.
  Map<String, dynamic> toMap(ClientInterface client) {
    return switch (client) {
      ParseSdkClient() => {
          'objectId': id,
          'userId': userId,
          'title': title,
          'description': description,
          'done': done,
          'shared': shared,
          'sharedWith': sharedWith,
        },
      _ => throw UnhandledClientTypeError(
          modelName: runtimeType,
          clientType: client.runtimeType,
        ),
    };
  }
}

/// Turns the retrieved data into a ```Todo```, based on format.
Todo todoFromMap(Map<String, dynamic> map) {
  return switch (map) {
    {
      'objectId': String id,
      'userId': String userId,
      'title': String title,
      'description': String description,
      'done': bool done,
      'shared': bool shared,
      'sharedWith': List sharedWith,
    } =>
      Todo(
        id: id,
        userId: userId,
        title: title,
        description: description,
        done: done,
        shared: shared,
        sharedWith: [...sharedWith.map((e) => e as String)],
      ),
    _ => throw InvalidDataFormatError(modelName: Todo, data: map),
  };
}
