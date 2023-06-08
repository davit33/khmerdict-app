import 'package:flutter/material.dart';
import 'package:khmerdict/screens/components/constant.dart';

class InputSearch extends StatelessWidget {
  const InputSearch({super.key, this.controller, this.ontextChange});
  final TextEditingController? controller;
  final Function? ontextChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          left: 15.0, right: 15.0, top: 15.0, bottom: 15.0),
      child: TextField(
        style: const TextStyle(
            color: Colors.white, fontFamily: appFont, fontSize: 22.0),
        textAlign: TextAlign.center,
        cursorColor: Colors.white,
        decoration: const InputDecoration(
          filled: true,
          fillColor: Color(0xFF1AFFFFFF),
          hintText: searchWord,
          hintStyle: TextStyle(
              color: Color(0xFF86899B),
              fontFamily: appFont,
              fontSize: 22.0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.white),
          ),
        ),
        controller: controller,
        onChanged: (value) {
          ontextChange!(value);
        },
      ),
    );
  }
}
