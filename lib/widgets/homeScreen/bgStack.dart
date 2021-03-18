import 'package:flutter/material.dart';

class bgStack extends StatefulWidget {
  @override
  _bgStackState createState() => _bgStackState();
}

class _bgStackState extends State<bgStack> {
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
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              //color: Color(0xff4E5FF8),
              gradient: LinearGradient(
                  colors: [Colors.blue, Color(0xff4E5FF8)],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  stops: [0.1, 0.6]),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25)),
              boxShadow: [
                BoxShadow(
                    color: Colors.blue.withOpacity(0.6),
                    blurRadius: 6,
                    offset: Offset(2, 2),
                    spreadRadius: 6)
              ]),
          width: double.infinity,
          height: screenHeight(context, mulBy: 0.4),
        ),
        SizedBox(
          height: screenHeight(context, mulBy: 0.6) - 35,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 80,
                child: Container(
                  width: 150,
                  height: 170,
                  decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.lightGreen.withOpacity(0.6),
                            blurRadius: 6,
                            offset: Offset(2, 2),
                            spreadRadius: 6)
                      ]),
                ),
              ),
              Positioned(
                right: 0,
                top: 40,
                child: Container(
                  width: 270,
                  height: 300,
                  decoration: BoxDecoration(
                      color: Color(0xffFFBD09),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.yellow.withOpacity(0.6),
                            blurRadius: 6,
                            offset: Offset(2, 2),
                            spreadRadius: 6)
                      ]),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  width: 250,
                  height: 150,
                  decoration: BoxDecoration(
                      color: Color(0xffF84E4E),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.red.withOpacity(0.6),
                            blurRadius: 6,
                            offset: Offset(2, 2),
                            spreadRadius: 2)
                      ]),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
