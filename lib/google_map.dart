
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class MyGoogleMap extends StatefulWidget {
  @override
  _MyGoogleMapState createState() => _MyGoogleMapState();
}

class _MyGoogleMapState extends State<MyGoogleMap> {

  GoogleMapController mapController;

  LatLng myLocation = LatLng(45.521563, -122.677433);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Location'),
        ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: myLocation,
          zoom: 11.0,
        ),
        onMapCreated: _onMapCreated,

      )
    );
  }
}
