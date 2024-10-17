class User {
  final String? userId;
  final String name;
  final String email;
  final String role;

  User({
    required this.userId,
    required this.name,
    required this.email,
    this.role = 'user'
  });

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "name": name,
      "email": email,
      "role": role
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
      userId: map["userId"],
      name: map["name"],
      email: map["email"],
      role: map["role"]
    );
  }

  @override
  String toString() {
    return "User($userId, $name, $email, $role)";
  }
}
