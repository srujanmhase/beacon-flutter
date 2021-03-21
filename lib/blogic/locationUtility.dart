import 'package:geolocator/geolocator.dart';

class locationUtility {
  var duration;

  Stream<Position> locationStream(DateTime startTime, var duration) async* {
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
      currentPosition = await Geolocator.getCurrentPosition();
      yield currentPosition;
      await Future.delayed(const Duration(minutes: 2));
    }
  }
}

class uploadUtility {
  final locationListner = locationUtility();

  uploadUtility(startTime, duration, docRef) {
    locationListner.locationStream(startTime, duration).listen((location) {
      var now = DateTime.now();
      print('Added location $location $docRef $now');
    });
  }
}
