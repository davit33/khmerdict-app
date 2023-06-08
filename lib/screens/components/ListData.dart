import 'package:flutter/material.dart';
import 'package:khmerdict/model/DictData.dart';
import 'package:khmerdict/screens/components/TextList.dart';
import 'package:khmerdict/screens/components/constant.dart';

class ListData extends StatelessWidget {
  const ListData({super.key, this.results});
  final List<DictData>? results;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: ((context, index) {
          return Container(
            padding:
                const EdgeInsets.only(left: 11.0, right: 11.0, bottom: 11.0),
            child: Card(
              color: const Color(0xff38ffffff),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: <Widget>[
                        TextList(
                          colour: Colors.white,
                          fontSize: 24,
                          text: results![index].main.toString(),
                        ),
                        Visibility(
                          visible: results![index].part_of_speech!.isNotEmpty,
                          child: Card(
                            elevation: 0.0,
                            color: const Color(0xff4dffffff),
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 5.0, right: 5.0, top: 3.0, bottom: 3.0),
                              child: TextList(
                                colour: Colors.white,
                                fontSize: 16,
                                text: results![index].part_of_speech.toString(),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, bottom: 15.0),
                    child: TextList(
                      colour: Colors.white,
                      fontSize: 16,
                      text: results![index].definition.toString(),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, bottom: 15.0),
                    child: Row(
                      children: <Widget>[
                        const TextList(
                          colour: Color(0xFFBBBDC7),
                          fontSize: 14,
                          text: read,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: TextList(
                            colour: Colors.white,
                            fontSize: 14,
                            text: results![index].pronunciation.toString(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
