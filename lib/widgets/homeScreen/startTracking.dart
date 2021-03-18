import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:beacon/main.dart';
import 'package:beacon/blogic/uiLogic.dart';

class startTracking extends StatefulWidget {
  @override
  _startTrackingState createState() => _startTrackingState();
}

class _startTrackingState extends State<startTracking> {
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
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          width: screenWidth(context, mulBy: 0.85),
          height: 140,
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.35),
              borderRadius: BorderRadius.circular(17)),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Track your Friend with BCode",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  createCupDiag(context);
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
                        "Start Tracking",
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
