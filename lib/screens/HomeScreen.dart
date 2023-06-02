// ignore: file_names
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khmerdict/model/DictData.dart';
import 'package:khmerdict/screens/components/DialogAbout.dart';
import 'package:khmerdict/screens/components/InputSearch.dart';
import 'package:khmerdict/screens/components/ListData.dart';
import 'package:khmerdict/screens/components/TextList.dart';
import 'package:khmerdict/screens/components/constant.dart';
import 'package:khmerdict/utils/BacgroundPaint.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeApp extends StatefulWidget {
  const HomeApp({super.key});

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  List<dynamic> _jsonData = [];
  final _controller = TextEditingController();
  List<DictData> _results = [];
  bool _isFirstOpen = true;

  @override
  void initState() {
    super.initState();
    _checkIfFirstOpen();
    _loadJsonData();
  }

  //check for user open first app
  Future<void> _checkIfFirstOpen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isFirstOpen = prefs.getBool(firstOpen) ?? true;
      if (_isFirstOpen) {
        prefs.setBool(firstOpen, false);
        showDialog(
          context: context,
          barrierColor: Colors.black26,
          builder: (BuildContext context) {
            return const DialogAbout();
          },
        );
      }
    });
  }

  //load data from file json local
  Future<void> _loadJsonData() async {
    final jsonString = await rootBundle.loadString(directoryFile);
    setState(() {
      _jsonData =
          json.decode(jsonString).map((e) => DictData.fromJson(e)).toList();
    });
  }

  //function when text changed and check search text empty
  void _onTextChanged(String value) {
    setState(() {
      if (value.isNotEmpty) {
        _results = _search(value);
      } else {
        _results.clear();
      }
    });
  }

  //query text for result
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
            //Header
            Center(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: const Text(
                  titleApp,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: appFont,
                    fontSize: 32,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            //Textfield for search word
            InputSearch(
              controller: _controller,
              ontextChange: (value) {
                _onTextChanged(value);
              },
            ),
            //List data for result
            ListData(results: _results),
          ],
        ),
      ),
      backgroundColor: const Color(0xFF2A2F4F),
    );
  }
}
