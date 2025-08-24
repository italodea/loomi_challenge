import 'package:loomi_chalenge/services/prefs.dart';

class LocalAuth {

  final Prefs _prefs = Prefs();

  Future<bool> checkAuth() async {
    String? token = await _prefs.getToken();
    if (token == null) {
      return false;
    } else {
      return true;
    }
  }
}