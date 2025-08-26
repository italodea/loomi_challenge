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
      default:
        return 'An unknown error occurred.';
    }
  }
}