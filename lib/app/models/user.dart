final class User {
  User({
    List<String>? friends,
    this.id,
    this.username = '',
    this.email = '',
    required this.password,
  }) : friends = friends ?? [];

  final String? id;
  final String username;
  final String email;
  final String password;
  final List<String> friends;

  User copyWith({
    String? id,
    String? username,
    String? email,
    String? password,
    List<String>? friends,
  }) =>
      User(
        id: id ?? this.id,
        username: username ?? this.username,
        email: email ?? this.email,
        password: password ?? this.password,
        friends: friends ?? this.friends,
      );

  @override
  String toString() =>
      'User(id: $id, username: $username, email: $email, password: $password, friends: $friends)';
}
