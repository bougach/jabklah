import 'package:jabk_laah/models/creancier.dart';

class Article {
  int id;
  String? name;
  String type;
  dynamic creditor;

  Article({ required this.id, this.name, required this.type,  this.creditor});
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] as int,
      name: json['name'] as String?,
      type: json['type'] as String,
      creditor: json['creditor'] as dynamic,
    );
  }
}