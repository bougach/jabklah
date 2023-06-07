import 'package:flutter/material.dart';
import 'package:jabk_laah/screens/Login/Components/Backgroud.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import '../Constante.dart';
import '../models/debt.dart';
import '../services/billApi.dart';
import '../services/deptapi.dart';

class Detail extends StatefulWidget {
  const Detail({Key? key}) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  List<Dept> debtlist = [];
  String otp = '';


  @override
  void initState() {
    super.initState();
    listDept();
  }

  Future<void> listDept() async {
    DebtService debtService = DebtService();

    final response2 = await debtService.findBillDebts();
    setState(() {
      debtlist = response2;
    });
    print(debtlist);
  }

  Color getColor(Set<MaterialState> states) {
    return const Color(0xFFE8E8E8);
  }

  Future<void> payBill() async {
      BillService billService = BillService();

      final response = await billService.payBill(context);
      try{
        // Show a dialog to indicate successful payment
        showDialog<dynamic>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Payment Successful'),
            content: OTPTextField(
              length: 5,
              width: MediaQuery.of(context).size.width,
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldWidth: 40,
              style: TextStyle(fontSize: 17),
              fieldStyle: FieldStyle.underline,
              onChanged: (value) {
                setState(() {
                  otp = value;
                });
              },
              onCompleted: (value) {
                setState(() {
                  otp = value;
                });
              },
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  // Call the confirmBill method with the OTP as an argument
                  billService.confirmBill(context, otp);
                  Navigator.of(context).pop();
                },
                child: const Text('Confirm'),
              ),
            ],
          ),
        );
      }catch(e){
        showDialog<dynamic>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Payment Failed'),
            content: const Text('You do not have enough balance.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );

      }
      
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 78.0, bottom: 14.0),
              child: const Text(
                "RECAPITULATIF DES INFORMATIONS",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 38.0),
              child: DataTable(
                dataRowHeight: 20,
                headingRowHeight: 20,
                headingRowColor: MaterialStateProperty.resolveWith(getColor),
                border: const TableBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.zero,
                    bottomLeft: Radius.zero,
                    bottomRight: Radius.zero,
                  ),
                  top: BorderSide(color: Colors.black, width: 1),
                  left: BorderSide(color: Colors.black, width: 1),
                  right: BorderSide(color: Colors.black, width: 1),
                  bottom: BorderSide(color: Colors.black, width: 1),
                  horizontalInside: BorderSide(color: Colors.black, width: 1),
                ),
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Reference',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Description',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Prix TTC',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ],
                rows: List.generate(debtlist.length, (index) {
                  final item = debtlist[index];
                  return DataRow(
                    color: MaterialStateProperty.resolveWith(getColor),
                    cells: [
                      DataCell(
                        Text(
                          item.id.toString()!,
                          style: const TextStyle(fontSize: 10),
                        ),
                      ),
                      DataCell(
                        Text(
                          item.name!,
                          style: const TextStyle(fontSize: 10),
                        ),
                      ),
                      DataCell(
                        Text(
                          item.amount.toString()!,
                          style: const TextStyle(fontSize: 10),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 40, left: 40, top: 80),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
                  foregroundColor: MaterialStateProperty.all<Color>(PrimaryLightColor),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                  ),
                  textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(fontSize: 16)),
                ),
                onPressed: payBill, // Call the payBill method
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Confirmer et signer",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
