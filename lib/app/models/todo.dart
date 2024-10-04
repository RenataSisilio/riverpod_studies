class Todo {
  Todo({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.shared,
    required this.sharedWith,
  });

  final String id;
  final String userId;
  final String title;
  final String description;
  bool shared;
  List<String> sharedWith;

  Todo copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    bool? shared,
    List<String>? sharedWith,
  }) {
    return Todo(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      shared: shared ?? this.shared,
      sharedWith: sharedWith ?? this.sharedWith,
    );
  }

  @override
  String toString() {
    return 'Todo(id: $id, userId: $userId, title: $title, description: $description, shared: $shared, sharedWith: $sharedWith)';
  }
}
