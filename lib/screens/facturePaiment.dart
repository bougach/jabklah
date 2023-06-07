import 'package:flutter/material.dart';
import 'package:jabk_laah/Constante.dart';
import 'package:jabk_laah/data.dart';
import 'package:jabk_laah/models/articl.dart';
import 'package:jabk_laah/screens/Login/Components/Backgroud.dart';
import 'package:jabk_laah/screens/clientCard.dart';
import 'package:http/http.dart' as http;
import 'package:jabk_laah/services/CreancierApi.dart';
import 'package:jabk_laah/services/articleApi.dart';

import '../models/creancier.dart';

class FactureP extends StatefulWidget {
  FactureP({Key? key}) : super(key: key);

  @override
  _FacturePState createState() => _FacturePState();
}

class _FacturePState extends State<FactureP> {
  List<Creanciers> criditorlist = [];

  void initState() {
    super.initState();
    listCreancier();
  }

  Future<void> listCreancier() async {
    CreditorService service = new CreditorService();
    final response = await service.listCreancier();
    setState(() {
      criditorlist = response;
    });
  }



  @override
  Widget build(BuildContext context) {

    return Background(
      child: Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: Column(
          children: [

            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                children:criditorlist.map((list) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: ClientCard(test: list),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
