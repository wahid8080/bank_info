
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyBranchDetails extends StatefulWidget {
  @override
  _MyBranchDetailsState createState() => _MyBranchDetailsState();
}

class _MyBranchDetailsState extends State<MyBranchDetails> {

  GoogleMapController mapController;

  LatLng myLocation = LatLng(45.521563, -122.677433);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Branch Details'),),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(border: Border.all(color: Colors.red,width: 1)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Branch Name',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),),
                      Text('Islami bank barishal shakha',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w300)),
                      SizedBox(height: 30,),
                      Text('Address',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500)),
                      Text('Bibir puskuni 3 no road , Barishal city',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w300)),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              height: MediaQuery.of(context).size.height/1.4,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: myLocation,
                  zoom: 11.0,
                ),
                onMapCreated: _onMapCreated,

              ),
            ),
          ],
        ),
      ),
    );
  }
}
