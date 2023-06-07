import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jabk_laah/Components/welcomeScreen.dart';
import 'package:jabk_laah/Constante.dart';
import 'package:jabk_laah/Recharge/body.dart';
import 'package:jabk_laah/screens/clientscreen.dart';
import 'package:jabk_laah/screens/facturePaiment.dart';
import 'package:jabk_laah/services/AuthInterceptor.dart';

import 'bill/finalbull.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {


   MyApp(){
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: "Jabk-lah",
      theme: ThemeData(
        primaryColor: PrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: WelcomeScreen(),

    );
  }
}
