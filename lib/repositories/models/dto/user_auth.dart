import 'package:loomi_chalenge/repositories/models/data/user.dart';

class UserAuth extends User {
  final String accessToken;
  final String refreshToken;

  UserAuth(this.accessToken, this.refreshToken, {required super.id, required super.username, required super.email});

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['accessToken'] = accessToken;
    json['refreshToken'] = refreshToken;
    return json;
  }

  factory UserAuth.fromJson(Map<String, dynamic> json) {
    return UserAuth(
      json['accessToken'],
      json['refreshToken'],
      id: json['id'],
      username: json['username'],
      email: json['email'],
    );
  }

}