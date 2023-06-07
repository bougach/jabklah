import 'package:dio/dio.dart';
import 'package:jabk_laah/models/creancier.dart';

import 'AuthInterceptor.dart';

class CreditorService {
  Dio dio = Dio();

   Future<List<Creanciers>> listCreancier() async {
     dio.interceptors.add(AuthInterceptor());
    print("hello");
    const url = "http://10.0.2.2:8080/api/client/creditors";

    try {
      final Response<dynamic> response = await dio.get<dynamic>(url);
      if (response.statusCode == 200) {
        final dynamic jsonData = response.data;
        final List<dynamic> results = jsonData['data']['creditors'] as List<dynamic>;

        final creanciers = results.map((dynamic e) {
          return Creanciers.fromMap(e as Map<String, dynamic>);
        }).toList();
        return creanciers;
      } else {
        throw Exception('Failed to fetch creditors');
      }
    } catch (e) {
      throw Exception('Failed to fetch creditors: $e');
    }
  }
}
