import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loomi_chalenge/repositories/models/data/comment.dart';
import 'package:loomi_chalenge/repositories/models/data/movie.dart';
import 'package:loomi_chalenge/services/comments_service.dart';
import 'package:loomi_chalenge/services/firebase_auth_service.dart';

class CommentCardController extends GetxController {


  RxBool isExpanded = false.obs;
  RxBool isFullyExpanded = false.obs;

  final FirebaseAuthService authService = FirebaseAuthService();
  final Rx<User?> currentUser = Rx<User?>(null);

  final TextEditingController commentController = TextEditingController();
  final CommentsService commentsService = CommentsService();

  @override
  void onInit() {
    super.onInit();
    getCurrentUser();
  }

  void toggleExpanded() {
    isExpanded.value = !isExpanded.value;
  }

  void toggleFullyExpanded() {
    isFullyExpanded.value = !isFullyExpanded.value;
  }

  void getCurrentUser() async {
    await authService.getCurrentUser().then((user) {
      if (user != null) {
        currentUser.value = user;
      }
    });
  }

  Future<void> sendComment(Movie movie) async {
    if (currentUser.value != null) {
      Comment comment = Comment(
        comment: commentController.text.trim(),
      );
      await commentsService.addComment(comment, movie.id.toString());
      commentController.clear();
    }
  }
}
