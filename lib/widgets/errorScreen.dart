import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class errorScreen extends StatefulWidget {
  @override
  _errorScreenState createState() => _errorScreenState();
}

class _errorScreenState extends State<errorScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('5707-error.json'),
          Column(
            children: [
              Text(
                "There seems to be an error",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              Text(
                "That's all we know",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              )
            ],
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
