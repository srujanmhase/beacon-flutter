import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'widgets/sharingScreen/currentWatching.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';

class shareScreen extends StatefulWidget {
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
  Widget build(BuildContext context) {
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
                    height: screenHeight(context, mulBy: 0.7),
                    width: screenWidth(context, mulBy: 1),
                    decoration: BoxDecoration(color: Colors.grey[300]),
                    child: googleMapsView(),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Column(
                children: [
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
                        "Last Transmitted 1 min ago",
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Tracking ID",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              Text("3xDB778oop",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white))
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 9, 20, 9),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Last Location:",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white)),
                              Text("3.466644, 7.77668890",
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
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)))),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          screenWidth(context, mulBy: 0.2),
                                          0,
                                          screenWidth(context, mulBy: 0.2),
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
            currentWatching()
          ],
        )),
      ),
    );
  }
}

// class mapView extends StatefulWidget {
//   @override
//   _mapViewState createState() => _mapViewState();
// }

// class _mapViewState extends State<mapView> {
//   @override
//   Widget build(BuildContext context) {
//     return FlutterMap(
//       options: MapOptions(center: LatLng(19.202609, 72.970689), zoom: 13.0),
//       layers: [
//         TileLayerOptions(
//             urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//             subdomains: ['a', 'b', 'c']),
//         MarkerLayerOptions(
//           markers: [
//             Marker(
//               width: 80.0,
//               height: 80.0,
//               point: LatLng(19.202609, 72.970689),
//               builder: (ctx) => Container(
//                 child: FaIcon(
//                   FontAwesomeIcons.mapMarker,
//                   color: Colors.blue,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

class googleMapsView extends StatefulWidget {
  @override
  _googleMapsViewState createState() => _googleMapsViewState();
}

class _googleMapsViewState extends State<googleMapsView> {
  CameraPosition _initialPosition =
      CameraPosition(target: LatLng(19.202609, 72.970689), zoom: 10);

  // Position _position = await determinePosition();

  Completer<GoogleMapController> _mapController = Completer();

  void _onMapCreated(GoogleMapController controller) async {
    _mapController.complete(controller);
  }

  Set<Marker> _markers = Set.from([
    Marker(
        markerId: MarkerId('newyork'),
        position: LatLng(19.202609, 72.970689),
        infoWindow:
            InfoWindow(title: 'New York', snippet: 'Welcome to New York')),
  ]);

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      markers: _markers,
      mapType: MapType.normal,
      buildingsEnabled: true,
      // onMapCreated: _onMapCreated,
      initialCameraPosition: _initialPosition,
    );
  }
}

class mapStateGeo extends StatefulWidget {
  @override
  _mapStateGeoState createState() => _mapStateGeoState();
}

class _mapStateGeoState extends State<mapStateGeo> {
  final List<_PositionItem> _positionItems = <_PositionItem>[];
  StreamSubscription<Position> _positionStreamSubscription;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  bool _isListening() => !(_positionStreamSubscription == null ||
      _positionStreamSubscription.isPaused);

  void _toggleListening() {
    if (_positionStreamSubscription == null) {
      final positionStream = Geolocator.getPositionStream();
      _positionStreamSubscription = positionStream.handleError((error) {
        _positionStreamSubscription?.cancel();
        _positionStreamSubscription = null;
      }).listen((position) => setState(() => _positionItems.add(
          _PositionItem(_PositionItemType.position, position.toString()))));
      _positionStreamSubscription?.pause();
    }

    setState(() {
      if (_positionStreamSubscription == null) {
        return;
      }

      if (_positionStreamSubscription.isPaused) {
        _positionStreamSubscription.resume();
      } else {
        _positionStreamSubscription.pause();
      }
    });
  }

  @override
  void dispose() {
    if (_positionStreamSubscription != null) {
      _positionStreamSubscription.cancel();
      _positionStreamSubscription = null;
    }

    super.dispose();
  }
}

enum _PositionItemType {
  permission,
  position,
}

class _PositionItem {
  _PositionItem(this.type, this.displayValue);

  final _PositionItemType type;
  final String displayValue;
}
