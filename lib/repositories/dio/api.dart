import 'dart:io';

import 'package:loomi_chalenge/errors/custom_exception.dart';
import 'package:loomi_chalenge/repositories/dio/base_request.dart';
import 'package:loomi_chalenge/repositories/models/data/comment.dart';
import 'package:loomi_chalenge/repositories/models/data/movie.dart';
import 'package:loomi_chalenge/repositories/models/data/user.dart';

class CustomAPI extends BaseRequest {
  CustomAPI() : super("http://italodea.com.br:3000/api");

  Future<User> fetchUser(String token) async {
    setAuthorization(token);
    final response = await get("auth/me");
    return User.fromJson(response);
  }

  Future<void> register(
    String token,
    String username,
    String email,
    String firebaseUID,
  ) async {
    setAuthorization(token);
    await post(
      "/auth/local/register",
      data: {"username": username, "email": email, "firebase_UID": firebaseUID},
    );
  }

  Future<List<Movie>> getMovies(String token) async {
    setAuthorization(token);
    List<dynamic> moviesList = await get("/movies");

    return moviesList.map((movie) => Movie.fromJson(movie)).toList();
  }

  Future<List<Comment>> getComments(String token, int id) async {
    setAuthorization(token);
    List<dynamic> commentsList = await get("/comments/$id");

    return commentsList.map((comment) => Comment.fromJson(comment)).toList();
  }

  Future<User> updateMe(
    String token, {
    String? username,
    String? email,
    bool? finishedOnboarding,
  }) async {
    try {
      setAuthorization(token);
      final response = await patch(
        "/users/updateMe",
        data: {
          if (username != null) "username": username,
          if (email != null) "email": email,
          if (finishedOnboarding != null)
            "finished_onboarding": finishedOnboarding,
        },
      );

      return User.fromJson(response);
    } catch (e) {
      throw CustomException(e);
    }
  }

  Future<String> uploadProfilePicture(String token, File file) async {
    try {
      setAuthorization(token);
      final response = await postFile("/users/photo", file: file);

      return response['url'];
    } catch (e) {
      throw CustomException(
        'Failed to upload profile picture',
      );
    }
  }
}
// eyJhbGciOiJSUzI1NiIsImtpZCI6IjkyZTg4M2NjNDY2M2E2MzMyYWRhNmJjMWU0N2YzZmY1ZTRjOGI1ZDciLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vdGVzdGxvb21pLTQxM2Y1IiwiYXVkIjoidGVzdGxvb21pLTQxM2Y1IiwiYXV0aF90aW1lIjoxNzU2MjczMjc5LCJ1c2VyX2lkIjoiOHhENldiTEZwTlNtSHZZa2tLVWNDUE9VSlREMiIsInN1YiI6Ijh4RDZXYkxGcE5TbUh2WWtrS1VjQ1BPVUpURDIiLCJpYXQiOjE3NTYyNzMyNzksImV4cCI6MTc1NjI3Njg3OSwiZW1haWwiOiJpdGFAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJmaXJlYmFzZSI6eyJpZGVudGl0aWVzIjp7ImVtYWlsIjpbIml0YUBnbWFpbC5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.EIyYR40M476re4WG4cjDbJCMlKKNGuaAxEDOyIErc_hlsVfNiUSyxuEbj5kzizgCvzz_AFS02eUEkV5DoZesYnXQz9BDEz4LDcMekv4tajwHItLBXAM1ceRsdRx_-LHIzwMdCYtULKmRA2MxpWT5M8feLBqLPJ44Wp6hiS4vU87DDyfTsjfGSLyOOxv9CvTVsXxoz81LrBzTpkMr6r6IwZugD1UibvV__BohH6YPYMaSdjBoxK5nSJ5-7kf2GZJ12RAIf7PVjlHHsVwjtZjEs7R1cQ2BfDbZR_9UPmfN4HeophMnTaCXNGUwqSW_Un80B-BGL0Yc0a0HQWzUFs-Hng