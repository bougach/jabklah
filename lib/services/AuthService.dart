import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/ProspectRequest.dart';
import '../models/admineAuthentification.dart';

class AuthService {
  Future<AuthenticationResponse> authenticate(AdminAuthRequest request) async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8080/api/auth/authenticate'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(request.toJson()),
      );
      print(response.statusCode);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonBody = jsonDecode(response.body) as Map<String, dynamic>;
        return AuthenticationResponse.fromJson(jsonBody);
      } else {
        throw Exception('Failed to authenticate');
      }
    } catch (e) {
      throw Exception('Failed to authenticate: $e');
    }
  }

  Future<dynamic> register(ProspectRequest request) async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8080/api/auth/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(request.toJson()),
      );
      print(response.statusCode);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonBody = jsonDecode(response.body) as Map<String, dynamic>;
        return jsonBody;
      } else {
        throw Exception('Failed to register');
      }
    } catch (e) {
      throw Exception('Failed to register: $e');
    }
  }
}
