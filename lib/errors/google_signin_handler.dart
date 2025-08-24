import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInHandler {
  static String getErrorMessage(GoogleSignInExceptionCode e) {
    switch (e) {
      case GoogleSignInExceptionCode.canceled:
        return 'Sign-In canceled. You can try again or use another method.';
      case GoogleSignInExceptionCode.clientConfigurationError:
        return 'Configuration error. Please check your Google Sign-In setup.';
      case GoogleSignInExceptionCode.interrupted:
        return 'Sign-In interrupted. Please retry the process.';
      case GoogleSignInExceptionCode.providerConfigurationError:
        return 'Provider configuration error. Contact support if this persists.';
      case GoogleSignInExceptionCode.uiUnavailable:
        return 'Sign-In UI unavailable. Try again later or use another device.';
      case GoogleSignInExceptionCode.unknownError:
        return 'Unknown error. Please try again or contact support.';
      case GoogleSignInExceptionCode.userMismatch:
        return 'User mismatch. Please sign in with the correct Google account.';
    }
  }
}
