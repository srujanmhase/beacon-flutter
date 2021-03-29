import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:flutter/material.dart';
import 'dart:io';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  await Hive.openBox('session');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: hiveHome(),
    );
  }
}

class hiveHome extends StatefulWidget {
  @override
  _hiveHomeState createState() => _hiveHomeState();
}

class _hiveHomeState extends State<hiveHome> {
  Box sessionBox;
  void setSessionBox(duration, startTime, bCode) {
    sessionBox.put('duration', duration);
    sessionBox.put('startTime', startTime);
    sessionBox.put('bCode', bCode);
  }

  @override
  void initState() {
    super.initState();
    sessionBox = Hive.box('session');
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              setSessionBox('10 Minutes', DateTime.now(), 'hdbcjd');
            },
            child: Text("SetSessionBoxs"),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => secondPage()));
              },
              child: Text("Navigate"))
        ],
      ),
    );
  }
}

class secondPage extends StatefulWidget {
  @override
  _secondPageState createState() => _secondPageState();
}

class _secondPageState extends State<secondPage> {
  Box sessionBox;
  String text;
  String duration;
  DateTime now;
  String bCode;
  String dummyText = "initial state";

  void setNewText() {
    setState(() {
      dummyText = "newDummyText";
    });
  }

  void setText(duration, now, bCode) {
    text = "$duration $now $bCode";
  }

  @override
  void initState() {
    super.initState();
    sessionBox = Hive.box('session');
    duration = sessionBox.get('duration');
    now = sessionBox.get('startTime');
    bCode = sessionBox.get('bCode');
    setText(duration, now, bCode);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text),
        Text(dummyText),
        ElevatedButton(
            onPressed: () {
              setNewText();
            },
            child: Text("setNewText"))
      ],
    ));
  }
}
