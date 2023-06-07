import 'package:jabk_laah/models/creancier.dart';

class CustomResponse {
  final int statusCode;
  final String status;
  final String message;

     dynamic data ;
CustomResponse({
  required this.statusCode,
  required this.status,
  required this.message,

  required this.data,

});
}
class CustomResponseData {
  List<Creanciers>? creditors;
  // Creditor? creditor;
  // List<Article>? articles;
  // Article? article;
  // List<Debt>? debts;
  // Debt? debt;
  // List<Bill>? bills;
  // Product? product;
  // List<Product>? products;
  // ProductCategory? pcategory;
  // List<ProductCategory>? pcategories;
  // dynamic paymentIntent;
  // List<Order>? orders;
  // User? client;

  CustomResponseData({
    this.creditors,
    // this.creditor,
    // this.articles,
    // this.article,
    // this.debts,
    // this.debt,
    // this.bills,
    // this.product,
    // this.products,
    // this.pcategory,
    // this.pcategories,
    // this.paymentIntent,
    // this.orders,
    // this.client,
  });
}

