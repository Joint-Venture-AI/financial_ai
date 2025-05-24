class UserModel {
  final String name;
  final String email;
  final String password;
  final String? country;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
    this.country,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      country: json['country'],
      name: json['fullName'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'fullName': name,
      'email': email,
      'password': password,
    };
  }
}
