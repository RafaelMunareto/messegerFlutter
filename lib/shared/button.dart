import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final label;
  final tap;
  Button({this.label, this.tap});

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16, bottom: 10, right: 16, left: 16),
      child: ElevatedButton(
        child: Text(
          widget.label,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        style: ElevatedButton.styleFrom(
            primary: Color(0xff593799), // background
            onPrimary: Color(0xff593799),
            padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
            shape: new RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0))),
        onPressed: widget.tap,
      ),
    );
  }
}
