abstract interface class ClientInterface {
  /// Retrieves information from ```endpoint```.
  ///
  /// Returns ideally a ```Map<String, dynamic>``` when ```id != null```
  /// or a ```List<Map<String, dynamic>>``` when ```id == null```
  Future<dynamic> get(String endpoint, {String? id});

  /// Retrieves information of all instances from ```endpoint```
  /// where ```field``` is equal to ```value```.
  ///
  /// Returns a ```List<Map<String, dynamic>>```
  /// with the data of all found instances.
  Future<List<Map<String, dynamic>>> getWhere(
    String endpoint, {
    required String field,
    required dynamic value,
  });

  /// Creates a new object in ```endpoint```.
  ///
  /// Returns the data retrieved from API.
  Future<dynamic> create(String endpoint, {required Map<String, dynamic> data});

  /// Replaces (PUT) the entire object in ```endpoint``` identified by ```id```.
  ///
  /// Returns the data retrieved from API.
  Future<dynamic> replace(
    String endpoint, {
    required String id,
    required Map<String, dynamic> data,
  });

  /// Edits (POST) data inside the object in ```endpoint``` identified by ```id```.
  ///
  /// Returns the data retrieved from API.
  Future<dynamic> edit(
    String endpoint, {
    required String id,
    required Map<String, dynamic> data,
  });

  /// Deletes the object in ```endpoint``` identified by ```id```.
  ///
  /// Returns the data retrieved from API.
  Future<dynamic> delete(String endpoint, {required String id});
}
