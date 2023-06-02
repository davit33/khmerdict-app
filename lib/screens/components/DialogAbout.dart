import 'package:flutter/material.dart';
import 'package:khmerdict/screens/components/TextList.dart';
import 'package:khmerdict/screens/components/constant.dart';

class DialogAbout extends StatelessWidget {
  const DialogAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF38FFFFFF),
      title: const Center(
        child: TextList(
          text: wellcome,
          colour: Colors.white,
          fontSize: 22.0,
        ),
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: const <Widget>[
          TextList(
            text: about,
            colour: Colors.white,
            fontSize: 16.0,
          ),
          TextList(
            text: credit,
            colour: Colors.white,
            fontSize: 16.0,
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const TextList(
              text: started,
              colour: Colors.white,
              fontSize: 18.0,
            ))
      ],
    );
  }
}
