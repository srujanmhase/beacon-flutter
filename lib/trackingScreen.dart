import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'widgets/gmap.dart';
import 'widgets/sharingScreen/currentWatching.dart';

class trackingScreen extends StatefulWidget {
  final String bCode;
  const trackingScreen({this.bCode});

  @override
  _trackingScreenState createState() => _trackingScreenState();
}

class _trackingScreenState extends State<trackingScreen> {
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
    //return;
  }
}
