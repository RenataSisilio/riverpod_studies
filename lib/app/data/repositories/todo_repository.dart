import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../client/client_interface.dart';
import '../../client/parse_sdk_client.dart';
import '../../core/utils/constants/messages.dart';
import '../../models/todo.dart';
import '../mappings/todo_mapping.dart';

final class TodoRepository {
  TodoRepository(this._client);

  final ClientInterface _client;

  static const _endpoint = 'Todo';

  /// Creates a new ```Todo```, saving it through the client.
  ///
  /// Returns a record with a success message
  /// and the data of the created Todo,
  /// in case of success.
  Future<(String, Todo)> create({
    required String title,
    required String description,
  }) async {
    try {
      final userId = switch (_client) {
        ParseSdkClient() =>
          (await ParseUser.currentUser() as ParseUser?)?.objectId ?? '',
        _ => '',
      };

      final receivedData = await _client.create(
        _endpoint,
        data: Todo(
          userId: userId,
          title: title,
          description: description,
        ).toMap(_client),
      );

      final createdTodo = todoFromMap(receivedData);

      return (Messages.successfulCreateTodo, createdTodo);
    } catch (e) {
      rethrow;
    }
  }

  /// Retrieves all ```Todo```s of the current ```User``` through the client.
  Future<List<Todo>> getMyTodos() async {
    try {
      final userId = switch (_client) {
        ParseSdkClient() =>
          (await ParseUser.currentUser() as ParseUser?)?.objectId ?? '',
        _ => '',
      };

      final results = await _client.getWhere(
        _endpoint,
        field: 'userId',
        value: userId,
      );

      return [...results.map((e) => todoFromMap(e))];
    } catch (e) {
      rethrow;
    }
  }

  /// Edits a ```Todo``` info, saving it through the client.
  ///
  /// Returns a record with a success message
  /// and the data of the edited Todo,
  /// in case of success.
  Future<(String, Todo)> edit({
    required Todo originalTodo,
    String? newTitle,
    String? newDescription,
  }) async {
    try {
      final receivedData = await _client.replace(
        _endpoint,
        id: originalTodo.id!,
        data: originalTodo
            .copyWith(
              title: newTitle,
              description: newDescription,
            )
            .toMap(_client),
      );

      final savedTodo = todoFromMap(receivedData);

      return (Messages.successfulEditTodo, savedTodo);
    } catch (e) {
      rethrow;
    }
  }

  /// Marks a ```Todo``` as, saving it through the client.
  ///
  /// Returns the data of the edited Todo,
  /// in case of success.
  Future<Todo> markAsDone(Todo todo, {bool done = true}) async {
    try {
      final receivedData = await _client.replace(
        _endpoint,
        id: todo.id!,
        data: todo.copyWith(done: done).toMap(_client),
      );

      final savedTodo = todoFromMap(receivedData);

      return savedTodo;
    } catch (e) {
      rethrow;
    }
  }

  /// Deletes a ```Todo``` through the client.
  ///
  /// Returns a success message in case of success.
  Future<String> delete(Todo todo) async {
    try {
      await _client.delete(_endpoint, id: todo.id ?? 'null-id');

      return Messages.successfulDeleteTodo;
    } catch (e) {
      rethrow;
    }
  }
}
