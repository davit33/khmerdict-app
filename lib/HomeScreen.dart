// ignore: file_names
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeApp extends StatefulWidget {
  const HomeApp({super.key});

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  late List<DictData> list = [];
  String? searchWord;

  void loadData() async {
    Future<String> loadJsonFromAssets() async {
      return await rootBundle.loadString('assets/json/db.json');
    }

    final jsonString = await loadJsonFromAssets();
    final List<dynamic> jsonList = jsonDecode(jsonString);
    final List<DictData> dictDataList =
        jsonList.map((e) => DictData.fromJson(e)).toList();
    for (int i = 0; i < dictDataList.length; i++) {
      if (searchWord! == dictDataList[i].main.toString()) {
        setState(() {
          list.add(dictDataList[i]);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
      ),
      body: CustomPaint(
        painter: BacgroundPaint(),
        child: Column(
          children: <Widget>[
            Center(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: const Text(
                  "វចនានុក្រមខ្មែរ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Kantumruy',
                    fontSize: 32,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15.0, bottom: 25.0),
              child: TextField(
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Kantumruy',
                    fontSize: 22.0),
                textAlign: TextAlign.center,
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color(0xFF1AFFFFFF),
                  hintText: "ស្វែងរកពាក្យ",
                  hintStyle: TextStyle(
                      color: Color(0xFF86899B),
                      fontFamily: 'Kantumruy',
                      fontSize: 22.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.white),
                  ),
                ),
                onChanged: (value) {
                  setState(() async {
                    Future.delayed(const Duration(milliseconds: 200), () {
                      searchWord = value;
                      loadData();
                    });
                  });
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: ((context, index) {
                  return ListTile(
                    title: Text(
                      list[index].definition.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Kantumruy',
                        fontSize: 16,
                      ),
                    ),
                  );
                }),
                itemCount: list.length,
                physics: const BouncingScrollPhysics(),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFF2A2F4F),
    );
  }
}

class DictData {
  final int? id;
  final String? main;
  final String? pronunciation;
  // ignore: non_constant_identifier_names
  final String? part_of_speech;
  final String? definition;
  final String? example;

  // ignore: non_constant_identifier_names
  DictData(
      {this.id,
      this.definition,
      this.example,
      this.main,
      this.part_of_speech,
      this.pronunciation});

  factory DictData.fromJson(Map<String, dynamic> json) {
    return DictData(
        id: json['id'],
        main: json['main'],
        pronunciation: json['pronunciation'],
        part_of_speech: json['part_of_speech'],
        definition: json['definition'],
        example: json['definition']);
  }
}

class BacgroundPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    final paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = const Color(0xFF5D6179);

    final heightLine = height ~/ 40; // your Horizontal line
    final widthLine = (width ~/ 20); // your Vertical line

    for (int i = 1; i < height; i++) {
      if (i % heightLine == 0) {
        Path linePath = Path();
        linePath
            .addRect(Rect.fromLTRB(0, i.toDouble(), width, (i + 1).toDouble()));
        canvas.drawPath(linePath, paint);
      }
    }
    for (int i = 1; i < width; i++) {
      if (i % widthLine == 0) {
        Path linePath = Path();
        linePath.addRect(
            Rect.fromLTRB(i.toDouble(), 0, (i + 1).toDouble(), height));
        canvas.drawPath(linePath, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
