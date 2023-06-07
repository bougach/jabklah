import 'package:flutter/material.dart';
import 'package:jabk_laah/Constante.dart';
import 'package:jabk_laah/screens/Login/Components/body.dart';
import 'package:jabk_laah/screens/SignUp/Components/SigninScreen.dart';

import 'background.dart';
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return  Scaffold(
      body: Background(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Welcome to Jabk_Lah",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.blueGrey

          ),),
          Image.asset("assets/imgs/back1.jpg",height: size.height*0.5,),
          Container(

            width: 200.0,
            margin: EdgeInsets.all(16.0),

            child:ClipRRect(
              borderRadius: BorderRadius.circular(20),
              
                child: TextButton(


              onPressed: () {
                Navigator.push<Body>(context, MaterialPageRoute(builder: (context){return Body();},
                ));
              },
              style: ButtonStyle(

                backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
                foregroundColor: MaterialStateProperty.all<Color>(PrimaryLightColor),

                padding: MaterialStateProperty.all<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                ),
                textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(fontSize: 16)),
              ),
              child: Text('Log in'),
            )),
          ),
          Container(

            width: 200.0,
            margin: EdgeInsets.all(16.0),

            child:ClipRRect(
                borderRadius: BorderRadius.circular(20),

                child: TextButton(


                  onPressed: () {
                    Navigator.push<SignupScreen>(context, MaterialPageRoute(builder: (context){return SignupScreen();},));
                    },
                  style: ButtonStyle(

                    backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
                    foregroundColor: MaterialStateProperty.all<Color>(PrimaryLightColor),

                    padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                    ),
                    textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(fontSize: 16)),
                  ),
                  child: Text('Sign in'),
                )),
          ),




        ],

      ),
      ),
    );
  }
}


