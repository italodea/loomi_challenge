

import 'dart:developer';

import 'package:firebase_storage/firebase_storage.dart';

class FirestoreHandler{
  final String message;

  FirestoreHandler(this.message);

  static String getErrorMessage(FirebaseException e) {
    switch (e.message) {
      case 'PERMISSION_DENIED':
        return 'You do not have permission to access this resource.';
      case 'NOT_FOUND':
        return 'The requested resource was not found.';
      case 'Unable to establish connection on channel.':
        return 'Unable to establish connection on channel.';
      default:
        log('Unknown Firestore error: ${e.message}');
        return 'An unknown error occurred.';
    }
  }

  @override
  String toString() {
    return 'FirestoreException: $message';
  }
}