import 'package:beacon/trackingScreen.dart';
import 'package:beacon/widgets/homeScreen/startTracking.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../sharingScreen.dart';

createCupDiag(BuildContext context) {
  TextEditingController bCodeController = new TextEditingController();

  return showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("Your Friend's BCode"),
          content: Card(
            color: Colors.transparent,
            elevation: 0.0,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: bCodeController,
                  decoration: InputDecoration(
                    labelText: "BCode",
                    filled: true,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            CupertinoButton(
                child: Text("Done"),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => trackingScreen(
                            bCode: bCodeController.text,
                          )));
                }),
            CupertinoButton(
                child: Text(
                  "Back",
                  style: TextStyle(color: Colors.redAccent),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        );
      });
}
