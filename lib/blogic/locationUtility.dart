import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

bool shouldUpload;
bool onScreen = true;

class locationUtility {
  var duration;

  Stream<Position> locationStream(
      DateTime startTime, var duration, int frequency) async* {
    DateTime endTime;

    switch (duration) {
      case '10 Minutes':
        endTime = startTime.add(Duration(minutes: 10));
        break;
      case '30 Minutes':
        endTime = startTime.add(Duration(minutes: 30));
        break;
      case '1 Hour':
        endTime = startTime.add(Duration(hours: 1));
        break;
      case '2 Hours':
        endTime = startTime.add(Duration(hours: 2));
        break;
      case '3 Hours':
        endTime = startTime.add(Duration(hours: 3));
        break;
      default:
        print('Invalid Inputs');
    }

    Position currentPosition;
    while (endTime.isAfter(startTime)) {
      print('STARTING GEOLOCATION ATTEMPT');
      currentPosition = await Geolocator.getCurrentPosition();
      yield currentPosition;
      await Future.delayed(const Duration(minutes: 2));
    }
  }
}

class uploadUtility {
  final locationListner = locationUtility();
  bool init = true;
  DateTime endTime;

  uploadUtility(startTime, duration, frequency, docRef, context) {
    switch (duration) {
      case '10 Minutes':
        endTime = startTime.add(Duration(minutes: 10));
        break;
      case '30 Minutes':
        endTime = startTime.add(Duration(minutes: 30));
        break;
      case '1 Hour':
        endTime = startTime.add(Duration(hours: 1));
        break;
      case '2 Hours':
        endTime = startTime.add(Duration(hours: 2));
        break;
      case '3 Hours':
        endTime = startTime.add(Duration(hours: 3));
        break;
      default:
        print('Invalid Inputs');
    }

    locationListner
        .locationStream(startTime, duration, frequency)
        .listen((location) {
      var now = DateTime.now();
      shouldUpload = (endTime.isAfter(now) && onScreen) ? true : false;

      String nowStr = now.toString();

      if (init && shouldUpload) {
        DocumentReference locationDoc =
            FirebaseFirestore.instance.collection('live').doc(docRef);
        locationDoc.set({
          'lat': location.latitude,
          'long': location.longitude,
          'startTime': startTime,
          'latestUpload': nowStr,
          'concW': 0
        });
        print('SET Added location $location $docRef $now $startTime');
        init = false;
      } else if (init != true && shouldUpload) {
        DocumentReference locationDoc =
            FirebaseFirestore.instance.collection('live').doc(docRef);
        locationDoc.update({
          'lat': location.latitude,
          'long': location.longitude,
          'latestUpload': nowStr
        });
        print('UPDATED location $location $docRef $now $startTime');
      }
    });
  }
}

class viewUpdateIncrement {
  viewUpdateIncrement(docRef) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('live').doc(docRef);

    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);

      if (!snapshot.exists) {
        print('Document does not exist');
      }

      int newViewCount = snapshot.data()['concW'] + 1;
      transaction.update(documentReference, {'concW': newViewCount});
    }).then((value) => print("INCREMENTED - UPDATED VIEW COUNT"));
  }
}

class viewUpdateDecrement {
  viewUpdateDecrement(docRef) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('live').doc(docRef);

    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);

      if (!snapshot.exists) {
        print('Document does not exist');
      }

      int newViewCount = snapshot.data()['concW'] - 1;
      transaction.update(documentReference, {'concW': newViewCount});
    }).then((value) => print("DECREMENTED - UPDATED VIEW COUNT"));
  }
}
