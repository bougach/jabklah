import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:jabk_laah/models/debt.dart';
import 'package:jabk_laah/services/AuthInterceptor.dart';

class DebtService {
  Dio dio = Dio();

  static const String apiUrl = 'http://10.0.2.2:8080/api/client';

  Future<void> generateDebts() async {
    dio.interceptors.add(AuthInterceptor());

    final url = '$apiUrl/articles/debts/generate';

    try {
      final Response<dynamic> response = await dio.post<dynamic>(url);
      print(response.statusCode);
    } catch (e) {
      throw Exception('Failed to generate debts: $e');
    }
  }

  Future<List<Dept>> getDebtsByArticle(int articleId) async {
    dio.interceptors.add(AuthInterceptor());

    final url = '$apiUrl/articles/$articleId/debts';

    try {
      final Response<dynamic> response = await dio.get<dynamic>(url);
      print(response.statusCode);

      if (response.statusCode == 200) {
        final dynamic data = response.data;
        final List<dynamic> debtsJson = data['data']['debts'] as List<dynamic>;
        final debts = debtsJson.map<Dept>((dynamic json) => Dept.fromJson(json as Map<String, dynamic>)).toList();
        print(debts);
        return debts;
      } else {
        throw Exception('Failed to retrieve debts for article $articleId');
      }
    } catch (e) {
      throw Exception('Failed to retrieve debts for article $articleId: $e');
    }
  }

  Future<void> bindDebtToBill(String debtIds) async {
    dio.interceptors.add(AuthInterceptor());

    final url = '$apiUrl/bind/$debtIds';

    try {
      final Response<dynamic> response = await dio.put<dynamic>(url);
      print(response.statusCode);
    } catch (e) {
      throw Exception('Failed to bind debts to bill: $e');
    }
  }

  Future<void> generateBill() async {
    dio.interceptors.add(AuthInterceptor());

    final url = '$apiUrl/bill/generate';

    try {
      final Response<dynamic> response = await dio.post<dynamic>(url);
      print(response.statusCode);
    } catch (e) {
      throw Exception('Failed to generate bill: $e');
    }
  }

  Future<List<Dept>> findBillDebts() async {
    dio.interceptors.add(AuthInterceptor());

    final url = '$apiUrl/bill/debts';

    try {
      final Response<dynamic> response = await dio.get<dynamic>(url);
      print(response.statusCode);

      if (response.statusCode == 200) {
        final dynamic data = response.data;
        final List<dynamic> debtsJson = data['data']['debts'] as List<dynamic>;
        final debts = debtsJson.map<Dept>((dynamic json) => Dept.fromJson(json as Map<String, dynamic>)).toList();
        return debts;
      } else {
        throw Exception('Failed to retrieve bill debts');
      }
    } catch (e) {
      throw Exception('Failed to retrieve bill debts: $e');
    }
  }

  Future<void> saveDebt(Dept debt) async {
    dio.interceptors.add(AuthInterceptor());

    final url = '$apiUrl/articles/debts/save';

    try {
      final Response<dynamic> response = await dio.post<dynamic>(
        url,
        data: json.encode(debt.toJson()), // Convert debt object to JSON
        options: Options(contentType: 'application/json'), // Set the request headers
      );
      print(response.statusCode);
    } catch (e) {
      throw Exception('Failed to save debt: $e');
    }
  }
}
