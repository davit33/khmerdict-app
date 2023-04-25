import 'package:flutter/material.dart';
import 'package:khmerdict/model/DictData.dart';

class ListData extends StatelessWidget {
  const ListData({super.key, this.results});
  final List<DictData>? results;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: ((context, index) {
          return ListTile(
            title: Text(
              results![index].definition.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Kantumruy',
                fontSize: 16,
              ),
            ),
          );
        }),
        itemCount: results!.length,
        physics: const BouncingScrollPhysics(),
      ),
    );
  }
}
