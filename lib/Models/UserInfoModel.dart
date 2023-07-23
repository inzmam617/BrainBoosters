class UserModel {
  final String? email;
  final String? name;
  UserModel({this.name, this.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
      return UserModel(
        email: json['email'],
        name: json['name'],
      );

  }
}
