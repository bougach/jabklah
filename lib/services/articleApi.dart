import 'package:dio/dio.dart';
import 'package:jabk_laah/models/articl.dart';
import 'package:jabk_laah/services/AuthInterceptor.dart';

class ArticleService {
  Dio dio = Dio();

  Future<List<Article>> getArticlesByCreditor(int id) async {
    dio.interceptors.add(AuthInterceptor());
    final url = "http://10.0.2.2:8080/api/client/creditors/$id/articles";

    try {
      final Response<dynamic> response = await dio.get<dynamic>(url);
      if (response.statusCode == 200) {
        final dynamic jsonData = response.data;
        final List<dynamic> results = jsonData['data']['articles'] as List<dynamic>;

        final articles = results.map((dynamic e) {
          return Article.fromJson(e as Map<String, dynamic>);
        }).toList();
        print(articles);
        return articles;
      } else {
        throw Exception('Failed to fetch articles for creditor $id');
      }
    } catch (e) {
      throw Exception('Failed to fetch articles for creditor $id: $e');
    }
  }
}
