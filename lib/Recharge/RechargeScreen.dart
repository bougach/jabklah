import 'package:flutter/material.dart';
import 'package:jabk_laah/Components/background.dart';
import 'package:jabk_laah/models/articl.dart';
import 'package:jabk_laah/models/debt.dart';

import '../services/deptapi.dart';

class Body extends StatefulWidget {
  const Body({Key? key, required this.article, required this.image}) : super(key: key);
  final Article article;
  final String image;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController _phoneNumberController = TextEditingController();
  String? _selectedAmount;
  bool _isInternetSelected = true;

  final List<String> _amounts = [
    "10","20","30","40","50","100","200"
  ];

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(
              vertical: 50,
              horizontal: 30,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  widget.image,
                  height: size.height * 0.3,
                  width: double.infinity,
                ),
                const SizedBox(height: 16.0),
                Column(
                  children: [
                    TextFormField(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Numéro de téléphone',
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Montant de recharge',
                        border: OutlineInputBorder(),
                      ),
                      items: _amounts.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedAmount = newValue;
                        });
                      },
                      value: _selectedAmount,
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        Radio(
                          value: true,
                          groupValue: _isInternetSelected,
                          onChanged: (bool? value) {
                            setState(() {
                              _isInternetSelected = value ?? false;
                            });
                          },
                        ),
                        const Text('Internet'),
                        Radio(
                          value: false,
                          groupValue: _isInternetSelected,
                          onChanged: (bool? value) {
                            setState(() {
                              _isInternetSelected = value ?? false;
                            });
                          },
                        ),
                        const Text('Téléphone'),
                      ],
                    ),
                    const SizedBox(height: 26.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            String phoneNumber = _phoneNumberController.text;
                            String amount = _selectedAmount ?? '';
                            String service = _isInternetSelected ? 'Internet' : 'Téléphone';

                            // Convert amount to double
                            double parsedAmount = double.parse(amount);

                            // Create a new Debt object
                            Dept debt = Dept(
                              name: "rechart",
                              description: service,
                              type: "DEBT",
                              amount: parsedAmount,
                            );
                            DebtService debtService=new DebtService();


                            debtService.saveDebt(debt);
                            print(debt);

                            _phoneNumberController.clear();
                            setState(() {
                              _selectedAmount = null;
                              _isInternetSelected = true;
                            });
                          },
                          child: const Text('Valider'),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Annuler'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
