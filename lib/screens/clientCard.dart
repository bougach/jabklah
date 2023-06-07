import 'package:flutter/material.dart';
import 'package:jabk_laah/Donnation/body.dart';
import 'package:jabk_laah/Recharge/RechargeScreen.dart';
import 'package:jabk_laah/Recharge/body.dart';
import 'package:jabk_laah/bill/factureField.dart';
import 'package:jabk_laah/models/creancier.dart';
import 'package:jabk_laah/services/deptapi.dart';

import '../models/articl.dart';
import '../services/articleApi.dart';

class ClientCard extends StatefulWidget {
  const ClientCard({
    Key? key,
    required this.test,
  }) : super(key: key);

  final Creanciers test;

  @override
  _ClientCardState createState() => _ClientCardState();
}

class _ClientCardState extends State<ClientCard> {
  List<Article> articleList = [];

  @override
  void initState() {
    super.initState();
    listArticles();
  }

  Future<void> listArticles() async {
    ArticleService articleService = ArticleService();
    final response =
    await articleService.getArticlesByCreditor(widget.test.id!);
    setState(() {
      articleList = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      height: 100, // <-- set the height here
      child: Row(
        children: [
          Image.asset(
            widget.test.image!,
            width: size.width * 0.3,
            height: size.height * 0.3,
          ),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.test.name!,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var article in articleList)
                          InkWell(
                            onTap: () {
                              if (article.type == "ARTICLE_RECHARGE") {
                                Navigator.push<dynamic>(
                                  context,
                                  MaterialPageRoute<dynamic>(
                                    builder: (context) => Body(
                                      article: article,
                                      image: widget.test.image,
                                    ),
                                  ),
                                );
                              } else if (article.type == "ARTICLE_ABONNEMENT") {
                                Navigator.push<dynamic>(
                                  context,
                                  MaterialPageRoute<dynamic>(
                                    builder: (context) => FactureField(
                                      article: article,
                                      image: widget.test.image,
                                      name: widget.test.name,
                                    ),
                                  ),
                                );
                              } else if (article.type == "CHARITY") {
                                Navigator.push<dynamic>(
                                  context,
                                  MaterialPageRoute<dynamic>(
                                    builder: (context) => DonationField(
                                      article: article,
                                      image: widget.test.image,
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text(
                                article.name!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  decoration: TextDecoration.none, // Remove the underline
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
