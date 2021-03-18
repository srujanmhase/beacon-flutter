import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class currentWatching extends StatefulWidget {
  @override
  _currentWatchingState createState() => _currentWatchingState();
}

class _currentWatchingState extends State<currentWatching> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: 20,
        top: 20,
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xff4E5FF8),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[500],
                  offset: Offset(2, 2),
                  blurRadius: 6,
                  spreadRadius: 2,
                )
              ]),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.eye,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 20,
                ),
                Text("3", style: TextStyle(color: Colors.white, fontSize: 18)),
              ],
            ),
          ),
        ));
  }
}
