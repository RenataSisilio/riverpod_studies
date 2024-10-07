import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../core/errors/client_errors.dart';
import '../core/private/parse_sdk_keys.dart';
import 'client_interface.dart';

final class ParseSdkClient implements ClientInterface {
  ParseSdkClient() {
    Parse().initialize(
      keyApplicationId,
      keyParseServerUrl,
      clientKey: keyClientKey,
      debug: true,
    );
  }

  @override
  Future create(String endpoint, {required Map<String, dynamic> data}) async {
    try {
      final object = ParseObject(endpoint);

      for (var field in data.entries) {
        object.set(field.key, field.value);
      }

      final response = await object.save();

      if (response.success) {
        return (response.result as ParseObject).toJson();
      }

      throw ParseSdkClientError(response.error!);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future delete(String endpoint, {required String id}) async {
    try {
      final object = ParseObject(endpoint)..objectId = id;

      final response = await object.delete();

      if (response.success) {
        return response.result;
      }

      throw ParseSdkClientError(response.error!);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future edit(
    String endpoint, {
    required String id,
    required Map<String, dynamic> data,
  }) async {
    try {
      final object = ParseObject(endpoint)..objectId = id;

      for (var field in data.entries) {
        object.set(field.key, field.value);
      }

      final response = await object.update();

      if (response.success) {
        return response.result;
      }

      throw ParseSdkClientError(response.error!);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future get(String endpoint, {String? id}) async {
    try {
      if (id == null) {
        final query = QueryBuilder(ParseObject(endpoint));

        final response = await query.query();

        if (response.success && response.results != null) {
          return response.results!.map((e) => (e as ParseObject).toJson());
        }

        throw ParseSdkClientError(response.error!);
      } else {
        final response = await ParseObject(endpoint).getObject(id);

        if (response.success && response.result != null) {
          final object = response.result as ParseObject;

          return object.toJson();
        }

        throw ParseSdkClientError(response.error!);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future replace(
    String endpoint, {
    required String id,
    required Map<String, dynamic> data,
  }) async {
    try {
      final object = ParseObject(endpoint)..objectId = id;

      for (var field in data.entries) {
        object.set(field.key, field.value);
      }

      final response = await object.save();

      if (response.success) {
        final object = response.result as ParseObject;

        return object.toJson();
      }

      throw ParseSdkClientError(response.error!);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getWhere(
    String endpoint, {
    required String field,
    required value,
  }) async {
    try {
      final query = QueryBuilder(ParseObject(endpoint))
        ..whereEqualTo(field, value);

      final response = await query.query();

      if (response.success && response.results != null) {
        return [...response.results!.map((e) => (e as ParseObject).toJson())];
      }

      throw ParseSdkClientError(response.error!);
    } catch (e) {
      rethrow;
    }
  }
}
