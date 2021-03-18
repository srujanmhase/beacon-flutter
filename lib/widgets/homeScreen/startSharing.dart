import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:beacon/main.dart';
import 'package:beacon/sharingScreen.dart';
import 'package:clipboard/clipboard.dart';
import 'package:random_string/random_string.dart';
import 'package:clipboard/clipboard.dart';
import 'package:share_plus/share_plus.dart';

class startSharing extends StatefulWidget {
  @override
  _startSharingState createState() => _startSharingState();
}

class _startSharingState extends State<startSharing> {
  Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  double screenHeight(BuildContext context, {double mulBy = 1}) {
    return screenSize(context).height * mulBy;
  }

  double screenWidth(BuildContext context, {double mulBy = 1}) {
    return screenSize(context).width * mulBy;
  }

  void _generateNewBCode() {
    String _nBCodeGenerated = randomAlphaNumeric(10);
    setState(() {
      _bCodeGenerated = _nBCodeGenerated;
    });
  }

  String _bCodeGenerated;
  String dropdownValue = '10 Minutes';

  @override
  Widget build(BuildContext context) {
    _generateNewBCode();
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          width: screenWidth(context, mulBy: 0.85),
          height: 300,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.35),
            borderRadius: BorderRadius.circular(17),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Start Sharing your location",
                style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Your BCode",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w300),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18, 10, 18, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        height: 56,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            border:
                                Border.all(color: Colors.grey[700], width: 0.7),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Center(
                                  child: Text(
                                    _bCodeGenerated,
                                    style: TextStyle(
                                        color: Colors.grey[800], fontSize: 18),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      FlutterClipboard.copy(_bCodeGenerated)
                                          .then((value) {
                                        final snackbar = SnackBar(
                                            content: Text(
                                                "BCode copied to the clipboard"));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackbar);
                                      });
                                    },
                                    child: FaIcon(
                                      FontAwesomeIcons.copy,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _generateNewBCode();
                                    },
                                    child: Icon(Icons.autorenew),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Share.share(
                                          'Track me on a map using my BCode $_bCodeGenerated',
                                          subject: 'Look what I made!');
                                    },
                                    child:
                                        Center(child: Icon(Icons.share_sharp)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: dropdownValue,
                  icon: FaIcon(
                    FontAwesomeIcons.angleDown,
                    size: 20,
                    color: Colors.grey[700],
                  ),
                  iconSize: 24,
                  elevation: 16,
                  underline: Container(
                    height: 2,
                    color: Colors.grey[700],
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  items: <String>[
                    '10 Minutes',
                    '30 Minutes',
                    '1 Hour',
                    '2 Hours',
                    '3 Hours'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Container(
                          width: screenWidth(context, mulBy: 1),
                          child: Center(child: Text(value))),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => shareScreen()));
                },
                child: Container(
                  width: 250,
                  height: 45,
                  decoration: BoxDecoration(
                      color: Color(0xff4E5FF8),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        "Start Sharing",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
