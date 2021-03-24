import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

class errorScreen extends StatefulWidget {
  @override
  _errorScreenState createState() => _errorScreenState();
}

class _errorScreenState extends State<errorScreen> {
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
    return Material(
      color: Colors.white,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: screenWidth(context, mulBy: 1),
                child: SizedBox(
                    height: 200, child: Lottie.asset('assets/5707-error.json')),
              ),
            ],
          ),
          Positioned(
              bottom: 0,
              child: Column(
                children: [
                  Container(
                    height: screenHeight(context, mulBy: 0.3),
                    width: screenWidth(context, mulBy: 1),
                    decoration: BoxDecoration(
                        color: Color(0xff4E5FF8),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        FaIcon(
                          FontAwesomeIcons.broadcastTower,
                          color: Colors.white,
                          size: 40,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Error Retrieving Beacon Session",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 50,
                            width: screenWidth(context, mulBy: 0.7),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                              child: Text(
                                "Go Back",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 18),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
