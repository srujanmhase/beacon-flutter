import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class currentWatching extends StatefulWidget {
  final int concW;
  const currentWatching({this.concW});
  @override
  _currentWatchingState createState() => _currentWatchingState();
}

class _currentWatchingState extends State<currentWatching> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      decoration: BoxDecoration(
          color: Color(0xff4E5FF8),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              //color: Colors.grey[500],
              color: Color(0xff4E5FF8).withOpacity(0.7),
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
            Text("${widget.concW.toString()}",
                style: TextStyle(color: Colors.white, fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
