import 'dart:async';
import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

bool shouldUpload;

void openBox() async {
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  await Hive.openBox('session');
}

DateTime setEndTime(startTime, duration) {
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
  return endTime;
}

class geoStream {
  final _controller = StreamController<Position>();
  Stream<Position> get stream => _controller.stream;
  Position _currentPosition;
  Position currPos;

  getCurrentPosition() async {
    currPos = await Geolocator.getCurrentPosition();
  }

  geoStream() {
    Timer.periodic(Duration(minutes: 2), (timer) async {
      print('STARTING GEOLOCATION ATTEMPT');
      _currentPosition = await Geolocator.getCurrentPosition();
    });
  }
}

class uploadUtility {
  final locationStream = geoStream().stream;
  var subscription;
  bool init = true;

  uploadUtility(startTime, duration, frequency, docRef, context) {
    DateTime endTime = setEndTime(startTime, duration);

    subscription = locationStream.listen((location) {
      var now = DateTime.now();
      shouldUpload = (endTime.isAfter(now)) ? true : false;
      String nowStr = now.toString();

      if (now.isAfter(endTime)) {
        subscription.cancel();
      }

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
