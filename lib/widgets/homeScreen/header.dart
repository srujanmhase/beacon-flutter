import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class headerRow extends StatefulWidget {
  @override
  _headerRowState createState() => _headerRowState();
}

class _headerRowState extends State<headerRow> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome to",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              Text(
                "Beacon",
                style: TextStyle(fontSize: 38, color: Colors.white),
              )
            ],
          ),
          FaIcon(
            FontAwesomeIcons.broadcastTower,
            size: 40,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
