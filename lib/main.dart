import 'package:beacon/widgets/homeScreen/header.dart';
import 'package:beacon/widgets/homeScreen/startTracking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:random_string/random_string.dart';
import 'dart:ui';
import 'widgets/homeScreen/bgStack.dart';
import 'widgets/homeScreen/header.dart';
import 'widgets/homeScreen/startSharing.dart';
import 'sharingScreen.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Color(0xff4E5FF8));
    return MaterialApp(
      title: 'Flutter Demo',
      home: App(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class App extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return errorState();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MyHomePage();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return loading();
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String bCodeGenerated;
  void _generateNewBCode() {
    String _nBCodeGenerated = randomAlphaNumeric(10);
    setState(() {
      bCodeGenerated = _nBCodeGenerated;
    });
  }

  @override
  void initState() {
    super.initState();
    _generateNewBCode();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  double screenHeight(BuildContext context, {double mulBy = 1}) {
    return screenSize(context).height * mulBy;
  }

  double screenWidth(BuildContext context, {double mulBy = 1}) {
    return screenSize(context).width * mulBy;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Material(
        child: SafeArea(
          child: Stack(
            children: [
              bgStack(),
              SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        headerRow(),
                        SizedBox(
                          height: 50,
                        ),
                        startSharing(
                          bCodeGenerated: bCodeGenerated,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        startTracking()
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class loading extends StatefulWidget {
  @override
  _loadingState createState() => _loadingState();
}

class _loadingState extends State<loading> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Initializing Firebase"),
          SizedBox(
            height: 20,
          ),
          CupertinoActivityIndicator(),
        ],
      ),
    );
  }
}

class errorState extends StatefulWidget {
  @override
  _errorStateState createState() => _errorStateState();
}

class _errorStateState extends State<errorState> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Icon(Icons.warning),
          SizedBox(
            height: 20,
          ),
          Text("Error Initialising Firebase")
        ],
      ),
    );
  }
}
