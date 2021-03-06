import 'dart:ui';
import 'dart:io';

import 'package:beacon/blogic/locationUtility.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:beacon/main.dart';
import 'package:beacon/sharingScreen.dart';
import 'package:clipboard/clipboard.dart';
import 'package:random_string/random_string.dart';
import 'package:clipboard/clipboard.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
//import 'package:share_plus/share_plus.dart';

class startSharing extends StatefulWidget {
  final String bCodeGenerated;
  const startSharing({this.bCodeGenerated});

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

  String dropdownValue = '10 Minutes';
  Box sessionBox;

  void openBox() async {
    Directory directory = await pathProvider.getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    await Hive.openBox('s');
    sessionBox = Hive.box('s');
  }

  void setSessionBox(duration, startTime, bCode) {
    sessionBox.put('duration', duration);
    sessionBox.put('startTime', startTime);
    sessionBox.put('bCode', bCode);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    openBox();
  }

  @override
  Widget build(BuildContext context) {
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
                                    widget.bCodeGenerated,
                                    style: TextStyle(
                                        color: Colors.grey[800], fontSize: 18),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      FlutterClipboard.copy(
                                              widget.bCodeGenerated)
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
                                  // InkWell(
                                  //   onTap: () {
                                  //     Share.share(
                                  //         'Track me on a map using my BCode ${widget.bCodeGenerated}',
                                  //         subject: 'Look what I made!');
                                  //   },
                                  //   child:
                                  //       Center(child: Icon(Icons.share_sharp)),
                                  // ),
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
                  onScreen = true;
                  setSessionBox(
                      dropdownValue, DateTime.now(), widget.bCodeGenerated);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => shareScreen(
                                bCode: widget.bCodeGenerated,
                              )));
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => shareScreen(
                  //               bCode: widget.bCodeGenerated,
                  //               duration: dropdownValue,
                  //               startTime: DateTime.now(),
                  //             )));
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
