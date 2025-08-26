import 'dart:convert';

import 'package:loomi_chalenge/services/prefs.dart';

class LocalAuth {

  final Prefs _prefs = Prefs();

  Future<bool> checkAuth() async {
    String? token = await _prefs.getToken();
    if (token == null || await isExpiredToken(token)) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> isExpiredToken(String token) async {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return true;

      final payload = parts[1];
      final normalized = base64Url.normalize(payload);
      final decoded = utf8.decode(base64Url.decode(normalized));
      final payloadMap = json.decode(decoded);

      final exp = payloadMap['exp'];
      if (exp == null) return true;

      final expiry = DateTime.fromMillisecondsSinceEpoch(exp * 1000, isUtc: true).subtract(const Duration(hours: 3));
      DateTime now = DateTime.now().toUtc().subtract(const Duration(hours: 3));
      return now.isAfter(expiry);
    } catch (e) {
      return true;
    }
  }
}