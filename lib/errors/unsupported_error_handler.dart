class UnsupportedErrorHandler {
  static String getErrorMessage(UnsupportedError error) {
    switch (error.message) {
      case 'Unsupported operation':
        return 'An operation was not completed successfully.';
      case 'UnimplementedError':
        return 'This feature is not available yet.';
      case 'Bad state':
        return 'The application is in an invalid state.';
      default:
        return 'Unknown error.';
    }
  }
}
