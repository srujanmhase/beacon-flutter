import 'dart:html';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class loadingScreen extends StatefulWidget {
  @override
  _loadingScreenState createState() => _loadingScreenState();
}

class _loadingScreenState extends State<loadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('8001-pulse.json'),
          Text(
            "Loading Session..",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Go Back"))
        ],
      ),
    );
  }
}
