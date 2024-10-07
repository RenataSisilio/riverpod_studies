final class Todo {
  Todo({
    this.id,
    required this.userId,
    required this.title,
    required this.description,
    this.done = false,
    this.shared = false,
    List<String>? sharedWith,
  }) : sharedWith = sharedWith ?? [];

  // TODO: document
  final String? id;
  final String userId;
  final String title;
  final String description;
  final bool done;
  final bool shared;
  final List<String> sharedWith;

  Todo copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    bool? done,
    bool? shared,
    List<String>? sharedWith,
  }) {
    return Todo(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      done: done ?? this.done,
      shared: shared ?? this.shared,
      sharedWith: sharedWith ?? this.sharedWith,
    );
  }

  @override
  String toString() {
    return 'Todo(id: $id, userId: $userId, title: $title, description: $description, done: $done, shared: $shared, sharedWith: $sharedWith)';
  }
}
