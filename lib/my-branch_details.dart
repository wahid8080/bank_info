
import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:new_project/admin/model_of_ATM.dart';

class MyBranchDetails extends StatefulWidget {

  String bankName;
  String address;
  double lat;
  double lang;
  MyBranchDetails({this.bankName,this.address,this.lat,this.lang});

  @override
  _MyBranchDetailsState createState() => _MyBranchDetailsState(bankName: bankName,address:address,lat:lat,lang:lang);
}

class _MyBranchDetailsState extends State<MyBranchDetails> {

  String bankName;
  String address;
  double lat;
  double lang;
  _MyBranchDetailsState({this.bankName,this.address,this.lat,this.lang});


  final DBRef = FirebaseDatabase.instance.reference();
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    initValue();
    _goToPosition1();
    _onAddMarkerButtonPressed();
    super.initState();
  }

  initValue()async{

    setState(() {
      isLoading = true;
    });

    await faceBranchData();

    setState(() {
      isLoading = false;
    });
  }

  List<ModelOfATM> _myATM_Both=[];

  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(23.730041, 90.372936);
  final Set<Marker> _markers = {};
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;

  static final CameraPosition _position1 = CameraPosition(
    //bearing: 192.833,
    target: LatLng(23.730041, 90.372936),
    //tilt: 59.440,
    zoom: 7.0,
  );

  Future<void> _goToPosition1() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_position1));
  }
  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(_lastMapPosition.toString()),
          position: LatLng(lat, lang),
          infoWindow: InfoWindow(
            title: 'This is a Title',
            snippet: 'This is a snippet',
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
    });
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
                      Text('Bank Name',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),),
                      Text(bankName,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w300)),
                      SizedBox(height: 10,),
                      Text('Address',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500)),
                      Text(address,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w300)),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              height: MediaQuery.of(context).size.height/1.4,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
                mapType: _currentMapType,
                markers: _markers,
                onCameraMove: _onCameraMove,
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> faceBranchData()async{
    await DBRef.child("ATM_Both").child(bankName).once().then((DataSnapshot dataSnapshot){
      for(var value in dataSnapshot.value.keys){
        _myATM_Both.add(ModelOfATM(
          lat: dataSnapshot.value[value]['lat'],
          lang: dataSnapshot.value[value]['lang'],
          bankName : dataSnapshot.value[value]['bankName'],
          bothName: dataSnapshot.value[value]['bothName'],
          bothNo: dataSnapshot.value[value]['bothNo'],
          address: dataSnapshot.value[value]['address'],
          phone: dataSnapshot.value[value]['phone'],
        ));
        print(dataSnapshot.value[value]['bankName']);
      }
    }).whenComplete(() {
      isLoading = false;
    });
  }
}
