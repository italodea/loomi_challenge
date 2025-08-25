import 'package:dio/dio.dart';

class BaseRequest {

  final String baseUrl;
  final Dio _dio = Dio();

  BaseRequest(this.baseUrl);

  void setAuthorization(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  Future<dynamic> get(String endpoint, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get('$baseUrl$endpoint', queryParameters: queryParameters);
      return response.data;
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  Future<Map<String, dynamic>> post(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.post('$baseUrl$endpoint', data: data);
      return response.data;
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  Future<String> delete(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.delete('$baseUrl$endpoint', data: data);
      return response.data;
    } catch (e) {
      return 'Error: $e';
    }
  }

  Future<Map<String, dynamic>> patch(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.patch('$baseUrl$endpoint', data: data);
      return response.data;
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  Future<Map<String, dynamic>> put(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.put('$baseUrl$endpoint', data: data);
      return response.data;
    } catch (e) {
      return {'error': e.toString()};
    }
  }
}