// ignore: file_names
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khmerdict/model/DictData.dart';
import 'package:khmerdict/utils/BacgroundPaint.dart';

class HomeApp extends StatefulWidget {
  const HomeApp({super.key});

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  List<dynamic> _jsonData = [];
  final _controller = TextEditingController();
  List<DictData> _results = [];
  String? searchWord = "";

  @override
  void initState() {
    super.initState();
    _loadJsonData();
  }

  Future<void> _loadJsonData() async {
    final jsonString = await rootBundle.loadString('assets/json/db.json');
    setState(() {
      _jsonData =
          json.decode(jsonString).map((e) => DictData.fromJson(e)).toList();
    });
  }

  void _onTextChanged(String value) {
    setState(() {
      if (value.isNotEmpty) {
        _results = _search(value);
      } else {
        _results.clear();
      }
    });
  }

  List<DictData> _search(String query) {
    final results = <DictData>[];
    for (final item in _jsonData) {
      if (item.main.toString().toLowerCase().contains(query.toLowerCase())) {
        results.add(item);
      }
    }
    return results;
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
                padding: const EdgeInsets.all(10.0),
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
                controller: _controller,
                onChanged: (value) {
                  _onTextChanged(value);
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: ((context, index) {
                  return ListTile(
                    title: Text(
                      _results[index].definition.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Kantumruy',
                        fontSize: 16,
                      ),
                    ),
                  );
                }),
                itemCount: _results.length,
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
