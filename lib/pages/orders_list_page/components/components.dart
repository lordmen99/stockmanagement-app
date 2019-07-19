import 'package:flutter/material.dart';
import 'package:stock_app/theme/style.dart';

class CardItem extends StatelessWidget {
  // final String status;
  final String productTitle;
  final int count;
  final String status;
  final String imageUrl;
  CardItem({this.count, this.status, this.productTitle, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    Color _textColor;
    Color _statusColor;
    String _statusText;

    if(this.status == "OrderItemStatus.CANCELED"){
      _statusColor = Colors.pinkAccent;
      _textColor = Colors.white;
      _statusText = "Canceld";
    }else if(this.status == "OrderItemStatus.APPROVED"){
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
                // child: Image.asset("assets/avatar.png"),
                // child: Image.network("http://localhost:8000/images/1561961247.41WglAapeDL.jpg"),
                  child: imageUrl == null ? Text("dfdf") : Image.network(imageUrl),

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

// enum OrderItemStatus { CANCELED, APPROVED, CHECKING_BY_STOCK }

// enum Status{
//   Approved,
//   Canceled,
//   Checking
// } 

// final statusValues = new EnumValues({
//     "Approved": Status.Approved,
//     "Canceled": Status.Canceled,
//     "Checking By Stock": Status.Checking
// });

// class EnumValues<T> {
//     Map<String, T> map;
//     Map<T, String> reverseMap;

//     EnumValues(this.map);

//     Map<T, String> get reverse {
//         if (reverseMap == null) {
//             reverseMap = map.map((k, v) => new MapEntry(v, k));
//         }
//         return reverseMap;
//     }
// }
