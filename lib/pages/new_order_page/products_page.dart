import 'package:flutter/material.dart';
import 'package:stock_app/theme/style.dart';
import 'package:stock_app/models/datum_model.dart' as model;

class ProductPage extends StatelessWidget {
  final model.Category category;
  final _formKey = GlobalKey<FormState>();
  ProductPage({this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Center(
          child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 35),
        child: Column(
          children: <Widget>[
            Text(
              "products list",
              style: TextStyle(color: Colors.white, fontSize: 23),
            ),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView.builder(
                  itemCount: category.products.length,
                  itemBuilder: (BuildContext context, int index) {
                    model.Product product = category.products[index];
                    return Card(
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 55,
                            height: 55,
                            margin: EdgeInsets.all(7),
                            decoration: BoxDecoration(
//                  shape: BoxShape.circle,
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        "https://www.telegraph.co.uk/content/dam/technology/2018/09/13/TELEMMGLPICT000174292421_trans_NvBQzQNjv4BqnjcgOEmjComRJj7yhDPboTG8XMH-8JMVI20-FMdq02s.jpeg?imwidth=450"))),
                          ),
                          Text(
                            "Iphone X Max",
                            style: TextStyle(color: textColor, fontSize: 15),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Container(
                            width: 70,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              textAlign: TextAlign.center,

//                              initialValue: "1",
//                              keyboardType: TextInputType.number,
//                              validator: (value){
//                                if(value == null) {
//                                  return null;
//                                }
//                                final n = num.tryParse(value);
//                                if(n == null) {
//                                  return '"$value" is not a valid number';
//                                }
//                                return true;
//                              },
                              decoration: InputDecoration(
                                hintText: "count",
                              ),
                            ),
                          ),
                        ],
                      ),
                    );

                  },
                ),
              ),
            ),// Text form
            Container(
              margin: EdgeInsets.only(top: 47),
              child: SizedBox(
                width: 262,
                height: 48,
                child: RaisedButton(
                  elevation: 0,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(5.0)),
                  color: Color(0xff5FD247),
                  onPressed: (){
//                    _formKey.currentState.validate();

                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(
                        color: Colors.white, fontFamily: "Rubik-Regular", fontSize: 18),
                  ),
                ),
              ),
            )// Button
          ],
        ),
      )),
    );
  }
}
//
//class CardItem extends StatelessWidget {
//
////  final GlobalKey<FormState> formKey;
////
////  CardItem({this.formKey});
//
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      child: Card(
//        child: Row(
//          children: <Widget>[
//            Container(
//              width: 55,
//              height: 55,
//              margin: EdgeInsets.all(7),
//              decoration: BoxDecoration(
////                  shape: BoxShape.circle,
//                  borderRadius: BorderRadius.circular(5),
//                  image: DecorationImage(
//                      fit: BoxFit.fill,
//                      image: NetworkImage(
//                          "https://www.telegraph.co.uk/content/dam/technology/2018/09/13/TELEMMGLPICT000174292421_trans_NvBQzQNjv4BqnjcgOEmjComRJj7yhDPboTG8XMH-8JMVI20-FMdq02s.jpeg?imwidth=450"))),
//            ),
//            Text(
//              "Iphone X Max",
//              style: TextStyle(color: textColor, fontSize: 15),
//            ),
//            Expanded(
//              child: Container(),
//            ),
//            Container(
//              width: 70,
////              height: 50,
//              margin: EdgeInsets.symmetric(horizontal: 10),
//              child: Form(
//
////                  key: ProductPage.formKey,
//                  child: TextFormField(
//                textAlign: TextAlign.center,
//                style: TextStyle(),
//                initialValue: "1",
//                keyboardType: TextInputType.number,
//                validator: (value){
//                  if(value == null) {
//                    return null;
//                  }
//                  final n = num.tryParse(value);
//                  if(n == null) {
//                    return '"$value" is not a valid number';
//                  }
//                  return null;
//                },
//                decoration: InputDecoration(
//                  hintText: "count",
//                ),
//              )),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}

class MyCustomButton extends StatelessWidget {
  final String text;
  final Function callBack;

  MyCustomButton({this.text, this.callBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 47),
      child: SizedBox(
        width: 262,
        height: 48,
        child: RaisedButton(
          elevation: 0,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5.0)),
          color: Color(0xff5FD247),
          onPressed: this.callBack,
          child: Text(
            this.text,
            style: TextStyle(
                color: Colors.white, fontFamily: "Rubik-Regular", fontSize: 18),
          ),
        ),
      ),
    );
  }
}
