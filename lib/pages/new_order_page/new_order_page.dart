import 'package:flutter/material.dart';
import 'package:stock_app/models/datum_model.dart';
import 'package:stock_app/pages/new_order_page/products_page.dart';
import 'package:stock_app/services/get_datum_service.dart';
import 'package:stock_app/theme/style.dart';

class CreateOrderPage extends StatelessWidget {
  final String token;

  CreateOrderPage({this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 65, bottom: 20),
              child: Text(
                "List of Categories",
                style: TextStyle(color: Colors.white, fontSize: 23),
              ),
            ),
            FutureBuilder<Categories>(
              future: getCategories(token: this.token),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                }
                if (snapshot.hasData) {
                  Categories categories = snapshot.data;
                  return categories.categories.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: categories.categories.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(categories.categories[index].name,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 21)),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProductPage(
                                            token: this.token,
                                                category: categories
                                                    .categories[index],
                                              )));
                                },
                              );
                            },
                          ),
                        )
                      : Text(
                          "list is empty",
                          style: TextStyle(color: Colors.white, fontSize: 23),
                        );
                }
                return CircularProgressIndicator();
              },
            )
          ],
        ),
      ),
    );
  }
}
