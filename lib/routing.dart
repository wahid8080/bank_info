import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_project/admin/model_of_branch.dart';
import 'package:new_project/admin/model_of_routing.dart';
import 'package:new_project/my-branch_details.dart';
import 'package:new_project/theme_data/ThemeData.dart';

class RoutingList extends StatefulWidget {
  String bankName;
  RoutingList({this.bankName});
  @override
  _RoutingListState createState() => _RoutingListState(bankName : bankName);
}

class _RoutingListState extends State<RoutingList> {
  CollectionReference collectionRef = FirebaseFirestore.instance.collection('RoutingData');

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    initValue();
    super.initState();
  }

  initValue()async{

    setState(() {
      isLoading = true;
    });

    faceData();

    setState(() {
      isLoading = false;
    });
  }

  List<ModelOfRouting> _myRouting=[];
  String bankName;
  _RoutingListState({this.bankName});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Routing'),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.search), onPressed: (){

        })
      ],),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
          itemCount: _myRouting.length,
          itemBuilder: (context,position){
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.red,width: 1)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Bank Name : ${_myRouting[position].bankName}',style: localTextTitle,),
                    Text('From Branch :${_myRouting[position].fromBranch}',style: TextStyle(color: Colors.green,fontSize: 16)),
                    Text('To Branch :${_myRouting[position].toBranch}',style: TextStyle(color: Colors.green,fontSize: 16)),
                    Text('Routing Number :${_myRouting[position].routingNumber}',style: TextStyle(color: Colors.green,fontSize: 16)),
                  ],
                ),
              ),
            ),
          );
          }
      )
    );
  }

  void faceData()async{

    QuerySnapshot querySnapshot =await collectionRef.where('bankName',isEqualTo: '$bankName').get();
    final allData = querySnapshot.docs;

    for(var items in allData){
      setState(() {
        _myRouting.add(ModelOfRouting(
          bankName: items['bankName'],
          fromBranch: items['fromBranch'],
          toBranch: items['toBranch'],
          routingNumber: items['routingNumber'],
        ));
      });
    }
  }
}
