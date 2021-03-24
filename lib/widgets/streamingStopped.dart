import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class streamingStopped extends StatefulWidget {
  @override
  _streamingStoppedState createState() => _streamingStoppedState();
}

class _streamingStoppedState extends State<streamingStopped> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('8135-error-screen.json'),
          Text(
            "The streaming session has been terminated",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Go Back"),
          )
        ],
      ),
    );
  }
}
