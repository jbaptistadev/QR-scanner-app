class User {
  final int id;
  final String username;
  final String fullName;
  final String? token;

  User({
    required this.id,
    required this.username,
    required this.fullName,
    this.token,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'],
      fullName: map['fullName'],
      id: map['id'],
    );
  }
}
