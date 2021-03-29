import 'package:beacon/widgets/homeScreen/header.dart';
import 'package:beacon/widgets/homeScreen/startTracking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'dart:ui';
import 'widgets/homeScreen/bgStack.dart';
import 'widgets/homeScreen/header.dart';
import 'widgets/homeScreen/startSharing.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lottie/lottie.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  await Hive.openBox('localAuth');
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
          return checkLocalAuth();
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
  String key;
  Box localAuth;
  String bCodeGenerated;
  void _generateNewBCode() {
    String _nBCodeGenerated = randomAlphaNumeric(10);
    setState(() {
      bCodeGenerated = _nBCodeGenerated;
    });
  }

  String getLocalAuthCode() {
    var key = localAuth.get('key');
    return key;
  }

  @override
  void initState() {
    super.initState();
    _generateNewBCode();
    localAuth = Hive.box('localAuth');
    key = getLocalAuthCode();
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
                        startTracking(),
                        SizedBox(
                          height: 20,
                        ),
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
          Lottie.asset('assets/8001-pulse.json'),
          SizedBox(
            height: 20,
          ),
          Text(
            "Loading Beacon",
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
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
          Lottie.asset("assets/5707-error.json"),
          SizedBox(
            height: 20,
          ),
          Text("Error Initialising Firebase")
        ],
      ),
    );
  }
}

class checkLocalAuth extends StatefulWidget {
  @override
  _checkLocalAuthState createState() => _checkLocalAuthState();
}

class _checkLocalAuthState extends State<checkLocalAuth> {
  Box localAuth;
  String key;

  String getLocalAuthCode() {
    var key = localAuth.get('key');
    return key;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    localAuth = Hive.box('localAuth');
    key = getLocalAuthCode();
  }

  void setLocalAuthCode(key) {
    localAuth.put('key', key);
  }

  @override
  Widget build(BuildContext context) {
    if (key == null) {
      key = randomAlphaNumeric(7);
      setLocalAuthCode(key);
      return Material(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome to Beacon"),
            Text("Unique user ID is $key"),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyHomePage()));
                },
                child: Text("Proceed"))
          ],
        ),
      );
    }
    if (key != null) {
      Future.delayed(Duration(seconds: 0), () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyHomePage()));
      });
      return Material(
        child: Center(
          child: CupertinoActivityIndicator(),
        ),
      );
    }
  }
}
