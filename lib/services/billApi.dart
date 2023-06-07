import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'AuthInterceptor.dart';

class BillService {
  Dio dio = Dio();

  Future<void> payBill(BuildContext context) async {
    try {
      dio.interceptors.add(AuthInterceptor());
      String apiUrl = 'http://10.0.2.2:8080/api/cmi/payment';

      final response = await dio.post<dynamic>(apiUrl);


    } catch (e) {
      print(" erooor  nari");
    }

    }
    Future<void> confirmBill(BuildContext context, String verificationCode) async {
      try {
        dio.interceptors.add(AuthInterceptor());
        String apiUrl = 'http://10.0.2.2:8080/api/cmi/confirm';

        final response = await dio.post<dynamic>(
          apiUrl,
          data: verificationCode,
        );

      } catch (e) {
        print(" erooor conf nari");
      }
  }
}
