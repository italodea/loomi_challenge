import 'package:firebase_auth/firebase_auth.dart';

class FirebaseHandler {

  static String getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-credential':
        return 'Invalid authentication credential.';
      case 'network-request-failed':
        return 'Network error. Please try again.';
      case 'email-already-in-use':
        return 'Email is already in use.';
      case 'requires-recent-login':
        return 'This operation requires recent authentication. Please log in again.';
      default:
        return 'An unknown error occurred.';
    }
  }
}