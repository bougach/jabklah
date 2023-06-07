import 'package:flutter/material.dart';
import 'package:jabk_laah/Components/background.dart';
import 'package:jabk_laah/Constante.dart';

import '../../../models/AccountType.dart';
import '../../../models/ProspectRequest.dart';
import '../../../services/AuthService.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cinController = TextEditingController();

  List<String> accountTypes = [
    "Plafond_200DH",
    "Plafond_5000DH",
   "Plafond_20000DH",
    "Plafond_50000DH",
  ];
  String? selectedAccountType;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Sign in",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.blueGrey,
              ),
            ),
            Container(
              width: size.width * 0.9,
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                color: PrimaryLightColor,
                borderRadius: BorderRadius.circular(29),
              ),
              child: TextField(
                controller: firstNameController,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: PrimaryColor,
                  ),
                  hintText: "First Name",
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              width: size.width * 0.9,
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                color: PrimaryLightColor,
                borderRadius: BorderRadius.circular(29),
              ),
              child: TextField(
                controller: lastNameController,
                obscureText: true,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: PrimaryColor,
                  ),
                  hintText: "Last Name",
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              width: size.width * 0.9,
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                color: PrimaryLightColor,
                borderRadius: BorderRadius.circular(29),
              ),
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: PrimaryColor,
                  ),
                  hintText: "Username",
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              width: size.width * 0.9,
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                color: PrimaryLightColor,
                borderRadius: BorderRadius.circular(29),
              ),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.email,
                    color: PrimaryColor,
                  ),
                  hintText: "Email",
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              width: size.width * 0.9,
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                color: PrimaryLightColor,
                borderRadius: BorderRadius.circular(29),
              ),
              child: TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.phone,
                    color: PrimaryColor,
                  ),
                  hintText: "Phone",
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              width: size.width * 0.9,
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                color: PrimaryLightColor,
                borderRadius: BorderRadius.circular(29),
              ),
              child: TextField(
                controller: cinController,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.credit_card,
                    color: PrimaryColor,
                  ),
                  hintText: "CIN",
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              width: size.width * 0.9,
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                color: PrimaryLightColor,
                borderRadius: BorderRadius.circular(29),
              ),
              child:  DropdownButtonFormField<String>(
                value: selectedAccountType,
                onChanged: (value) {
                  setState(() {
                    selectedAccountType = value;
                  });
                },
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.credit_card,
                    color: PrimaryColor,
                  ),
                  hintText: "Account Type",
                  border: InputBorder.none,
                ),
                items: accountTypes.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
              ),
            ),
            Container(
              width: 200.0,
              margin: EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: TextButton(
                  onPressed: () {                    registerUser();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).primaryColor),
                    foregroundColor: MaterialStateProperty.all<Color>(
                        PrimaryLightColor),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                    ),
                    textStyle:
                    MaterialStateProperty.all<TextStyle>(TextStyle(fontSize: 16)),
                  ),
                  child: Text('signup'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void registerUser() async {
    // Create a ProspectRequest object using the input field values
    ProspectRequest request = ProspectRequest(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      username: usernameController.text,
      email: emailController.text,
      phone: phoneController.text,
      cin: cinController.text,
      type: selectedAccountType?.toString() ?? '',
    );

    try {
      AuthService authService = AuthService();
      await authService.register(request);


      showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Registration Successful'),
            content: Text('You have successfully registered.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );

      firstNameController.clear();
      lastNameController.clear();
      usernameController.clear();
      emailController.clear();
      phoneController.clear();
      cinController.clear();
      setState(() {
        selectedAccountType = null;
      });
    } catch (e) {
      // Registration failed, display an error message
      showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Registration Failed'),
            content: Text('Failed to register. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
