import 'package:flutter/material.dart';
import 'package:stock_app/theme/style.dart';

class CardItem extends StatelessWidget {
  // final String status;
  final String productTitle;
  final int count;
  final Status status;
  CardItem({this.count, this.status, this.productTitle});

  @override
  Widget build(BuildContext context) {
    Color _textColor;
    Color _statusColor;
    String _statusText;

    if(this.status == Status.Canceled){
      _statusColor = Colors.pinkAccent;
      _textColor = Colors.white;
      _statusText = "Canceld";
    }else if(this.status == Status.Approved){
      _statusColor = Colors.greenAccent;
      _textColor = mainColor;
      _statusText = "Approved";
    }else{
      _statusColor = Colors.blueAccent;
      _textColor = Colors.white;
      _statusText = "Checking";
    }


    return GestureDetector(
      onTap: () {},
      child: Card(
        color: _statusColor,
        margin: EdgeInsets.symmetric(vertical: (5)),
        child: Container(
          padding: EdgeInsets.all(10),
          height: 70,
          // color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 50,
                height: 50,
                child: Image.asset("assets/avatar.png"),
                color: Colors.orange,
              ), // image
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    this.productTitle,
                    style: TextStyle(color: _textColor, fontSize: 19),
                  ), // text
                  Text(
                    "count : $count",
                    style: TextStyle(color: _textColor, fontSize: 16),
                  ),
                ],
              ),

              Text(_statusText,
                  style: TextStyle(color: _textColor, fontSize: 19)),
            ],
          ),
        ),
      ),
    );
  }
}


enum Status{
  Approved,
  Canceled,
  Checking
} 