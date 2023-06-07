import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jabk_laah/Constante.dart';
import 'package:jabk_laah/screens/Login/Components/body.dart';

import 'package:jabk_laah/screens/facturePaiment.dart';
import 'package:jabk_laah/services/deptapi.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bill/finalbull.dart';
import '../services/AuthInterceptor.dart';
class Clientscreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ClientscreenState();
  }
}

class ClientscreenState extends State<Clientscreen> {
  var _currentIndex = 0;
  List<Widget> list = [FactureP(), Detail()];

  @override
  void initState() {
    super.initState();
    generateDebtAndBill();
  }

  DebtService debtService = DebtService();

  void generateDebtAndBill() async {
    await debtService.generateDebts();
    await debtService.generateBill();
  }


  void logout() async {


    try {
      // Make the API call to delete the bill
      final url = 'http://10.0.2.2:8080/api/client/bill/delete';
      Dio dio = Dio();
      dio.interceptors.add(AuthInterceptor());

      Response<dynamic> response = await dio.delete<dynamic>(url);

      if (response.statusCode == 200) {
        print('Bill deleted');
      } else {
        throw Exception('Failed to delete the bill');
      }
    } catch (e) {
      print('Error: $e');
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');

    Navigator.pushAndRemoveUntil<dynamic>(
      context,
      MaterialPageRoute<dynamic>(builder: (context) => Body()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Jabk_Lah",
          style: TextStyle(color: Colors.grey),
        ),
        backgroundColor: PrimaryLightColor,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: logout,
              child: Row(
                children: [
                  Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: list[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: PrimaryColor,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "liste de creance",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: "Facture",
          ),
        ],
      ),
    );
  }
}





