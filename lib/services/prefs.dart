import 'package:get_storage/get_storage.dart';

class Prefs {

  final GetStorage _storage = GetStorage();

  Future<void> saveToken(String token) async{
    await _storage.write('token', token);
  }

  Future<String?> getToken() async {
    return _storage.read('token');
  }

  Future<void> deleteToken() async {
    await _storage.remove('token');
  }
}