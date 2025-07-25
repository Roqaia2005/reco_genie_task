class UserModel {
  final String name;
  final String userName;
  final String password;
  final String email;

  UserModel({
    required this.email,
    required this.name,
    required this.userName,
    required this.password,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] as String,
      name: json['name'] as String,
      userName: json['userName'] as String,

      password: json['password'] as String,
    );
  }
}
