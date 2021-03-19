import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class googleMapsView extends StatefulWidget {
  final double latitude;
  final double longitude;

  const googleMapsView({this.latitude, this.longitude});

  @override
  _googleMapsViewState createState() => _googleMapsViewState();
}

class _googleMapsViewState extends State<googleMapsView> {
  Completer<GoogleMapController> _mapController = Completer();

  void _onMapCreated(GoogleMapController controller) async {
    _mapController.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    double latitude = widget.latitude;
    double longitude = widget.longitude;

    Set<Marker> _markers = Set.from([
      Marker(
          markerId: MarkerId('self'),
          position: LatLng(latitude, longitude),
          infoWindow: InfoWindow(title: "Your Location")),
    ]);
    CameraPosition _initialPosition =
        CameraPosition(target: LatLng(latitude, longitude), zoom: 10);
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
