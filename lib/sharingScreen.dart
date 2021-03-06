import 'dart:async';

import 'package:beacon/widgets/azureMapWidget.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:share_plus/share_plus.dart';
import 'widgets/sharingScreen/currentWatching.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'blogic/locationUtility.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'widgets/errorScreen.dart';
import 'widgets/loadingScreen.dart';
import 'package:popup_card/popup_card.dart';

class shareScreen extends StatefulWidget {
  final String bCode;
  //final String duration;
  //final DateTime startTime;
  const shareScreen({this.bCode});

  @override
  _shareScreenState createState() => _shareScreenState();
}

class _shareScreenState extends State<shareScreen> {
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
  void initState() {
    super.initState();
    uploadUtility(context);
  }

  double lat;
  double long;

  @override
  Widget build(BuildContext context) {
    //uploadUtility(widget.startTime, widget.duration, 2, widget.bCode, context);
    DocumentReference locationDocument =
        FirebaseFirestore.instance.collection('live').doc(widget.bCode);
    return StreamBuilder<DocumentSnapshot>(
      stream: locationDocument.snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return errorScreen();
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadingScreen();
        }
        if (snapshot.data.data()['lat'] != null) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Material(
              child: SafeArea(
                  child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    child: Column(
                      children: [
                        Container(
                          height: screenHeight(context, mulBy: 0.8),
                          width: screenWidth(context, mulBy: 1),
                          decoration: BoxDecoration(color: Colors.grey[300]),
                          // child: googleMapsView(
                          //   latitude: snapshot.data.data()['lat'],
                          //   longitude: snapshot.data.data()['long'],
                          // ),
                          child: azureMapsView(
                            latitude: snapshot.data.data()['lat'],
                            longitude: snapshot.data.data()['long'],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Column(
                      children: [
                        SizedBox(
                          width: screenWidth(context, mulBy: 1),
                          child: Row(
                            children: [
                              Expanded(child: Container()),
                              Column(
                                children: [
                                  PopupItemLauncher(
                                    tag: 'addLocation',
                                    child: Material(
                                      color: Colors.white,
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.add_location,
                                          size: 35,
                                          color: Color(0xff4E5FF8),
                                        ),
                                      ),
                                    ),
                                    popUp: PopUpItem(
                                      padding: EdgeInsets.all(
                                          8), // Padding inside of the card
                                      color: Colors.white, // Color of the card
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              18)), // Shape of the card
                                      elevation: 2, // Elevation of the card
                                      tag:
                                          'addLocation', // MUST BE THE SAME AS IN `PopupItemLauncher`
                                      child: Container(
                                        width:
                                            screenWidth(context, mulBy: 0.85),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "Add location marker",
                                              style: TextStyle(fontSize: 22),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  labelText: "Search",
                                                  filled: true,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  height: 50,
                                                  width: screenWidth(context,
                                                      mulBy: 75),
                                                  decoration: BoxDecoration(
                                                      color: Color(0xff4E5FF8),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Center(
                                                    child: Text(
                                                      "Search",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text("No Locations added"),
                                          ],
                                        ),
                                      ), // Your custom child widget.
                                    ),
                                  ),
                                  PopupItemLauncher(
                                    tag: 'addSharing',
                                    child: Material(
                                      color: Colors.white,
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.person_add,
                                          size: 35,
                                          color: Color(0xff4E5FF8),
                                        ),
                                      ),
                                    ),
                                    popUp: PopUpItem(
                                      padding: EdgeInsets.all(
                                          8), // Padding inside of the card
                                      color: Colors.white, // Color of the card
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              18)), // Shape of the card
                                      elevation: 2, // Elevation of the card
                                      tag:
                                          'addSharing', // MUST BE THE SAME AS IN `PopupItemLauncher`
                                      child: Container(
                                        width:
                                            screenWidth(context, mulBy: 0.85),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "Users sharing location",
                                              style: TextStyle(fontSize: 22),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text("Srujan Mhase"),
                                                      Text(
                                                        "Sharing",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.green),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text("John Doe"),
                                                      Text(
                                                        "Sharing",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.green),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text("Lerem Ipsum"),
                                                      Text(
                                                        "Invited",
                                                        style: TextStyle(
                                                            color: Colors.grey),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  labelText: "UID",
                                                  filled: true,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  height: 50,
                                                  width: screenWidth(context,
                                                      mulBy: 75),
                                                  decoration: BoxDecoration(
                                                      color: Color(0xff4E5FF8),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Center(
                                                    child: Text(
                                                      "Invite",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ), // Your custom child widget.
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          //height: 25,
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
                            padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                            child: Text(
                              "Last Transmitted ${snapshot.data.data()['latestUpload']}",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: screenHeight(context, mulBy: 0.28),
                          width: screenWidth(context, mulBy: 1),
                          decoration: BoxDecoration(
                              color: Color(0xff4E5FF8),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[600],
                                  offset: Offset(10, 10),
                                  blurRadius: 10,
                                  spreadRadius: 10,
                                )
                              ]),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 9, 20, 9),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Tracking ID",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    Row(
                                      children: [
                                        Text(widget.bCode,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white)),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            FlutterClipboard.copy(widget.bCode)
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
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        // InkWell(
                                        //   onTap: () {
                                        //     Share.share(
                                        //         'Track me on a map using my BCode ${widget.bCode}',
                                        //         subject: 'Look what I made!');
                                        //   },
                                        //   child: Center(
                                        //       child: Icon(
                                        //     Icons.share_sharp,
                                        //     color: Colors.white,
                                        //   )),
                                        // ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 9, 20, 9),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Last Location:",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white)),
                                    Text(
                                        "${snapshot.data.data()['lat']}, ${snapshot.data.data()['long']}",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white))
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 50,
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            onScreen = false;
                                            locationDocument.delete();
                                            Navigator.pop(context);
                                          },
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10)))),
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                screenWidth(context,
                                                    mulBy: 0.2),
                                                0,
                                                screenWidth(context,
                                                    mulBy: 0.2),
                                                0),
                                            child: Text(
                                              "End Sharing",
                                              style: TextStyle(
                                                  color: Colors.red[900],
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 20,
                    child: Column(
                      children: [
                        currentWatching(
                          concW: snapshot.data.data()['concW'],
                        ),
                      ],
                    ),
                  ),
                ],
              )),
            ),
          );
        }
        return Material(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Location Stream Unavailable"),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Go back"))
            ],
          ),
        );
      },
    );
  }
}
