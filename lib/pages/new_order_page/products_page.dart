import 'package:flutter/material.dart';
import 'package:stock_app/services/api_services.dart';
import 'package:stock_app/theme/style.dart';
import 'package:stock_app/models/datum_model.dart' as model;
import 'dart:convert';
class ProductPage extends StatefulWidget {
  final model.Category category;
  final String token;
  ProductPage({this.category, this.token});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final _ScaffoldKey = new GlobalKey<ScaffoldState>();
  Future<void> _createOrder ({List items, BuildContext context}) async{
    try{
      final String result = await createOrder(body: items,token: widget.token);
    }catch(e){
      print(e);
      _ScaffoldKey.currentState.showSnackBar(SnackBar(content: Text("fiald to create new order")));
      return;
    }

    _ScaffoldKey.currentState.showSnackBar(SnackBar(content: Text("new order created successfully")));



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _ScaffoldKey,
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
              child: ListView.builder(
                itemCount: widget.category.products.length,
                itemBuilder: (BuildContext context, int index) {
                  model.Product product = widget.category.products[index];
                  return CardItem(
                    product: product,

                  );
                  return Card(
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 55,
                          height: 55,
                          margin: EdgeInsets.all(7),
                          decoration: BoxDecoration(
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
                            initialValue: "1",
                            keyboardType: TextInputType.number,
                            onSaved: (value) {
                              print(value);
                            },
                            validator: (value) {
                              if (value == null) {
                                return null;
                              }
                              final n = num.tryParse(value);
                              if (n == null) {
                                return '"$value" is not a valid number';
                              }
                              return null;
                            },
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
            ), // Text form
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
                  onPressed: () {
                    List <Map> items = List<Map>();

                    orders.forEach((item){
//                      print(item.toMap());
                      Map map = (item.toMap());
                      items.add(map);

                      print(map);
//                      print("product id : ${item.productId} , count : ${item.qty}");
                    });
                    _createOrder(context: context, items: items);
//                    createOrder(body: items,token: widget.token);
//                    print(json.encode(items));
//                    _formKey.currentState.validate();
//                    _formKey.currentState.save();
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Rubik-Regular",
                        fontSize: 18),
                  ),
                ),
              ),
            ) // Button
          ],
        ),
      )),
    );
  }
}

List<OrderItem> orders = [];

class CardItem extends StatefulWidget {
  final model.Product product;

  CardItem({this.product});

  @override
  _CardItemState createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _countEditController = TextEditingController();

  bool _active = false;
  OrderItem orderItem;


  @override
  void initState() {
    _countEditController.text = "1";
    this.orderItem = new OrderItem(productId: int.parse(widget.product.id.toString()), qty: int.parse(_countEditController.text));
    super.initState();
  }

//  @override
//  void didUpdateWidget(CardItem oldWidget) {
//    this.orderItem.qty = int.parse(_countEditController.text);
//    super.didUpdateWidget(oldWidget);
//  }

  @override
  Widget build(BuildContext context) {
//    TextEditingController _countController = TextEditingController();

    return Container(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _active = !_active;
          });

          if (orders.contains(orderItem)) {
//            print("it is avalble");
            orders.remove(orderItem);
          } else {
//            print("it is not avilable");
            print(++ orderItem.productId);
            orders.add(orderItem);
            print(orderItem.qty);
            formKey.currentState.validate();
//            formKey.currentState.save();
          }

          print(orders);
//          print(orders.first.qty);
        },
        child: Opacity(
          opacity: _active ? 1 : 0.5,
          child: Card(
//            color: _active ? Colors.white : Colors.grey,
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
                          image: widget.product.images.isNotEmpty ? NetworkImage(
                            widget.product.images.first.url  ) : NetworkImage("https://bookyourstock.com/uploads/vendor_banner_image/default.jpg"))),
                ),
                Text(
                  widget.product.name,
                  style: TextStyle(color: textColor, fontSize: 15),
                ),
                Expanded(
                  child: Container(),
                ),
                Container(
                  width: 70,
//              height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Form(
                      key: formKey,
                      child: TextFormField(
                        onEditingComplete:(){
                          FocusScope.of(context).requestFocus(new FocusNode());
                          formKey.currentState.validate();
                          orderItem.qty = int.parse(_countEditController.text);
                          print("edit");
                        } ,
                        autovalidate: true,
                        controller: _countEditController,
                        textAlign: TextAlign.center,
                        onSaved: (value){
                          print(value);
                        },
                        style: TextStyle(),
//                      initialValue: "1",
                        keyboardType: TextInputType.number,

                        validator: (value) {
                          if (value == null) {
                            return null;
                          }
                          final n = num.parse(value);
                          if (n == null) {
                            return '"$value" is not a valid number';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "count",
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//
//class MyCustomButton extends StatelessWidget {
//  final String text;
//  final Function callBack;
//
//  MyCustomButton({this.text, this.callBack});
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      margin: EdgeInsets.only(top: 47),
//      child: SizedBox(
//        width: 262,
//        height: 48,
//        child: RaisedButton(
//          elevation: 0,
//          shape: new RoundedRectangleBorder(
//              borderRadius: new BorderRadius.circular(5.0)),
//          color: Color(0xff5FD247),
//          onPressed: this.callBack,
//          child: Text(
//            this.text,
//            style: TextStyle(
//                color: Colors.white, fontFamily: "Rubik-Regular", fontSize: 18),
//          ),
//        ),
//      ),
//    );
//  }
//}

class OrderItem {
  int productId;
  int qty;

  OrderItem({this.productId, this.qty});

  Map toMap() {
    Map map = {
      'product_id' : this.productId,
      'qty' : this.qty
    };


    return map;
  }
}
