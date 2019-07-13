import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  final IconData iconData;
  SmallButton({this.iconData});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 48,
      margin: EdgeInsets.symmetric(horizontal: 18),
      child: RaisedButton(
          onPressed: () {},
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(5),
          ),
          color: Colors.black.withOpacity(0.16),
          focusElevation: 0,
          hoverElevation: 0,
          child: Icon(iconData ,color: Colors.white,)
      ),
    );
  }
}

class LargeButton extends StatelessWidget {
  final _buttonColor = Color(0xff5FD247);
  final String buttonText;

  LargeButton({this.buttonText});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 162,
      height: 48,
      child: RaisedButton(
        onPressed: () {},
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(5),
        ),
        color: _buttonColor,
        child: Text(
          this.buttonText,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}

