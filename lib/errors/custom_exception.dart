import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loomi_chalenge/errors/firebase_handler.dart';
import 'package:loomi_chalenge/errors/google_signin_handler.dart';

class CustomException implements Exception {
  String message = "";
  CustomException(dynamic error){
    if(error is GoogleSignInException) {
      message = GoogleSignInHandler.getErrorMessage(error.code);
    } else if (error is FirebaseAuthException) {
      message = FirebaseHandler.getErrorMessage(error);
    } else{
      message = 'Unknown error';
    }
  }

  @override
  String toString() {
    return message;
  }
}
