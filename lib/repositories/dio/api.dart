import 'package:loomi_chalenge/repositories/dio/base_request.dart';
import 'package:loomi_chalenge/repositories/models/data/user.dart';
import 'package:loomi_chalenge/repositories/models/dto/user_auth.dart';


class CustomAPI extends BaseRequest {

  CustomAPI() : super("http://localhost:3000/api");


  Future<UserAuth> login(String username, String password) async {
    final response = await post("auth/login", data: {
      "username": username,
      "password": password,
    });

    return UserAuth.fromJson(response);
  }

  Future<User> fetchUser(String token) async {
    setAuthorization(token);
    final response = await get("auth/me");
    return User.fromJson(response);
  }

  Future<UserAuth> refreshToken(String token, String refreshToken) async {
    setAuthorization(token);
    final response = await post("auth/refresh", data: {
      "refreshToken": refreshToken,
    });

    return UserAuth.fromJson(response);
  }

  Future<void> register(String username, String email, String password, String firebaseUID) async {
    var data = await post("/auth/local/register", data: {
      "username": username,
      "email": email,
      "password": password,
      "firebase_UID": firebaseUID
    });
    print("========data========");
    print(data);
    print("========data========");
  }
}