class UserModel {
  final String id;
  final String username;
  final String email;
  final String? password;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
    );
  }
}
