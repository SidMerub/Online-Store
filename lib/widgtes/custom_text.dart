import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String text;

  TitleText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.black, // Default text color
        fontSize: 25.0, // Default font size
        fontWeight: FontWeight.w500, // Default font weight
      ),
    );
  }
}
class NormalText extends StatelessWidget {
  final String text;

  NormalText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.black, // Default text color
        fontSize: 20.0, // Default font size
        fontWeight: FontWeight.w300, // Default font weight
      ),
    );
  }
}
