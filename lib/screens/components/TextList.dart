import 'package:flutter/material.dart';
import 'package:khmerdict/screens/components/constant.dart';

class TextList extends StatelessWidget {
  const TextList({super.key, this.text, this.colour, this.fontSize});
  final String? text;
  final Color? colour;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
        color: colour,
        fontFamily: appFont,
        fontSize: fontSize,
      ),
    );
  }
}
