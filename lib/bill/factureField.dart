import 'package:flutter/material.dart';
import 'package:jabk_laah/Components/background.dart';
import 'package:jabk_laah/models/debt.dart';

import '../Constante.dart';
import '../models/articl.dart';
import '../services/deptapi.dart';

class FactureField extends StatefulWidget {
  const FactureField({Key? key, required this.image, required this.article, required this.name})
      : super(key: key);
  final Article article;
  final String image;
  final String name;

  @override
  _FactureFieldState createState() => _FactureFieldState();
}

class _FactureFieldState extends State<FactureField> {
  List<Dept> debtlist = [];
  bool istaped=false;

  @override
  void initState() {
    super.initState();
    listDept();
  }
  DebtService debtService=new DebtService();


  Future<void> listDept() async {
    final response2 = await debtService.getDebtsByArticle(widget.article.id);
    setState(() {
      debtlist = response2;
    });
  }

  void bindDebtsToBill() async {
    List<int?> debtIds = debtlist.map((debt) => debt.id).toList();
    String debtIdsString = debtIds.join(',');

    await debtService.bindDebtToBill(debtIdsString);
  }

  @override
  Widget build(BuildContext context) {
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
                Image.asset(widget.image),
                Text(
                  '${widget.name}',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Debts to pay:',
                  style: TextStyle(fontSize: 20, color: PrimaryColor),
                ),
                const SizedBox(height: 16.0),
                (debtlist.isEmpty || istaped==true )
                    ? Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Text('No debts found',style: TextStyle(fontSize: 40,color: Colors.red,fontWeight: FontWeight.bold),),
                    ) // Display a message when the debt list is empty
                    : Column(
                      children: [
                        Container(
                  height: 200, // Adjust the height as needed
                  child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: debtlist.length,
                        itemBuilder: (context, index) {
                          final debt = debtlist[index];
                          final cdeptColor = debt.type == 'DEBT' ? Colors.red : Colors.green;

                          return Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    debt.type,
                                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: cdeptColor),
                                  ),
                                  Text(
                                    '${debt.amount} Dhs',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: PrimaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                  ),
                ),
                        Container(
                          width: 200.0,
                          margin: EdgeInsets.all(16.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: TextButton(
                              onPressed: () {
                                bindDebtsToBill();
                                setState(() {
                                  istaped=true;


                                });
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
                                foregroundColor: MaterialStateProperty.all<Color>(PrimaryLightColor),
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                                ),
                                textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(fontSize: 16)),
                              ),
                              child: Text('Payer'),
                            ),
                          ),
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

