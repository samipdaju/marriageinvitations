import 'package:flutter/material.dart';
class Heading extends StatelessWidget {
  final String header;

  Heading(this.header);

  @override
  Widget build(BuildContext context) {
    return Text(
      header,
      style: TextStyle(
          color: Color(0xffBF933B), fontSize: 35, fontWeight: FontWeight.bold),
    );
  }
}

class TextFields extends StatelessWidget {
  final Function onPress;
  final String label;
  final String hint;

  TextFields({this.onPress, this.label,this.hint});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: TextField(
          style: TextStyle(fontSize: 25, color: Color(0xffCCCCCC)),
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            border: OutlineInputBorder(),

            labelText: label,
            hintText: hint,
            labelStyle: TextStyle(
              fontSize: 25,
              color: Color(0xffCCCCCC),
            ),
          ),
          onChanged: onPress),
    );
  }
}
