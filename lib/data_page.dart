import 'package:flutter/material.dart';
import './services/get_datum_service.dart';
import 'models/datum_model.dart';

class Data extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data"),
      ),
      body: Center(
        child: FutureBuilder<Categories>(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Categories datum = snapshot.data;
              List<Category> categories = datum.categories;
              return ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, int index) => ListTile(
                        title: Text(categories[index].name),
                      ));
            }
            return CircularProgressIndicator();
          },
          future: null,
        ),
      ),
    );
  }
}
