import 'package:firebase_auth/firebase_auth.dart';

class FirebaseHandler {

  static String? getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-credential':
        return 'Invalid authentication credential.';
      default:
        return 'An unknown error occurred.';
    }
  }
}