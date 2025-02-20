class UserModel {
  final String username;
  final String fullName;

  UserModel({required this.username, required this.fullName});

  Map<String, dynamic> toMap() => {
        "username": username,
        "fullName": fullName,
      };
}
