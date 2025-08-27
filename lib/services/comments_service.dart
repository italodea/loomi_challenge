import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:loomi_chalenge/errors/custom_exception.dart';
import 'package:loomi_chalenge/repositories/models/data/comment.dart';

class CommentsService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<Comment>> getCommentsByMovieId(int movieId) async {
    try {
      final querySnapshot = await firestore
          .collection('comments')
          .where('movie_id', isEqualTo: movieId)
          .orderBy('created_at', descending: true)
          .get();
      return querySnapshot.docs
          .map((doc) => Comment.fromJson(doc.data()))
          .toList();
    } catch (e) {
      // print(e);
      // print(e.runtimeType);
      throw CustomException(e);
    }
  }

  Future<Comment> addComment(Comment comment, String movieId) async {
    try {
      final fb_auth.User? firebaseUser = fb_auth.FirebaseAuth.instance.currentUser;
      if (firebaseUser == null) {
        throw CustomException('Usuário não autenticado');
      }
      final docRef = await firestore.collection('comments').add({
        'movie_id': movieId,
        'author_id': firebaseUser.uid,
        'author_name': firebaseUser.displayName ?? '',
        'author_email': firebaseUser.email ?? '',
        'author_photo_url': firebaseUser.photoURL ?? '',
        'comment': comment.comment,
        'created_at': DateTime.now().toIso8601String(),
        'reply_id': comment.replyId,
      }); 

      print("Comment added: ${comment.comment}");

      final doc = await docRef.get();
      final data = doc.data()!..['id'] = doc.id;
      return Comment.fromJson(data);
    } catch (e) {
      log("Error adding comment: $e");
      throw CustomException(e);
    }
  }

  Future<void> updateComment(String commentId, Map<String, dynamic> data) async {
    try {
      await firestore.collection('comments').doc(commentId).update(data);
    } catch (e) {
      throw CustomException(e);
    }
  }

  Future<void> deleteComment(String commentId) async {
    try {
      await firestore.collection('comments').doc(commentId).delete();
    } catch (e) {
      throw CustomException(e);
    }
  }

  Future<void> addReplyToComment(String commentId, Comment reply) async {
    try {
      await firestore.collection('comments').doc(commentId).update({
        'replies': FieldValue.arrayUnion([reply.toJson()])
      });
    } catch (e) {
      throw CustomException(e);
    }
  }
}