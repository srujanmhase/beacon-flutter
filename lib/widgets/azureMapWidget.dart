import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:beacon/constants.dart';

class azureMapsView extends StatefulWidget {
  final double latitude;
  final double longitude;
  const azureMapsView({this.latitude, this.longitude});

  @override
  _azureMapsViewState createState() => _azureMapsViewState();
}

class _azureMapsViewState extends State<azureMapsView> {
  @override
  Widget build(BuildContext context) {
    double latitude = widget.latitude;
    double longitude = widget.longitude;

    return FlutterMap(
        options: MapOptions(
          center: LatLng(latitude, longitude),
          zoom: 13.0,
        ),
        layers: [
          new TileLayerOptions(
            urlTemplate:
                "https://atlas.microsoft.com/map/tile/png?api-version=1&layer=basic&style=main&tileSize=256&view=Auto&zoom={z}&x={x}&y={y}&subscription-key=" +
                    azureKey,
            additionalOptions: {'subscriptionKey': azureKey},
          ),
          new MarkerLayerOptions(
            markers: [
              new Marker(
                width: 100.0,
                height: 100.0,
                point: new LatLng(latitude, longitude),
                builder: (ctx) => new Container(
                  child: new Icon(
                    Icons.location_on,
                    color: Color(0xff4E5FF8),
                  ),
                ),
              ),
            ],
          )
        ]);
  }
}
