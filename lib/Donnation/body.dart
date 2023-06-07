import 'package:flutter/material.dart';
import 'package:jabk_laah/Components/background.dart';
import 'package:jabk_laah/Constante.dart';
import 'package:jabk_laah/screens/SignUp/Components/SigninScreen.dart';

import '../models/articl.dart';
import '../models/debt.dart';
import '../services/deptapi.dart';

class DonationField extends StatefulWidget {
  const DonationField({Key? key, required this.article, required this.image}) : super(key: key);
  final Article article;
  final String image;
  @override
  _DonationFieldState createState() => _DonationFieldState();
}

class _DonationFieldState extends State<DonationField> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _MontantC = TextEditingController();
  String? _selectedAmount;

  final List<String> _amounts = [    '10 DHS',    '20 DHS',    '50 DHS',    '100 DHS',    '500 DHS',    '1000 DHS'  ];

  @override
  void dispose() {
    _nameController.dispose();
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
                      controller: _nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nom du donneur',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _MontantC,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Montant du don',
                      ),
                    ),


                    const SizedBox(height: 26.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            String name = _nameController.text;
                            String amount = _MontantC.text;
                            double parsedAmount = double.tryParse(amount) ?? 0.0;

                            Dept debt = Dept(
                              name: "donnation",
                              description: "charity",
                              type: "DEBT",
                              amount: parsedAmount
                            );
                            DebtService debtService=new DebtService();


                            debtService.saveDebt(debt);
                            print('name: $name, amount: $amount');
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
