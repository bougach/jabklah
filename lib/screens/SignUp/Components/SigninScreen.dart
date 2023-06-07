import 'package:flutter/material.dart';
import 'package:jabk_laah/Components/background.dart';
import 'package:jabk_laah/screens/Login/Components/Backgroud.dart';
import 'package:jabk_laah/screens/SignUp/Components/body.dart';
class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return  Scaffold(

      body:Body(),

    );
  }
}


