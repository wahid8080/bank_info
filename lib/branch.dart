import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_project/admin/model_of_branch.dart';
import 'package:new_project/my-branch_details.dart';
import 'package:new_project/theme_data/ThemeData.dart';

class Branch extends StatefulWidget {
  String bankName;
  Branch({this.bankName});
  @override
  _BranchState createState() => _BranchState(bankName : bankName);
}

class _BranchState extends State<Branch> {

  CollectionReference collectionRef = FirebaseFirestore.instance.collection('branchInfo');

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

  List<ModelOfBranch> _myBranch=[];
  String bankName;
  _BranchState({this.bankName});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Branch'),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.search), onPressed: (){

        })
      ],),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
          itemCount: _myBranch.length,
          itemBuilder: (context,position){
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MyBranchDetails(bankName: bankName,address:_myBranch[position].branchAddress,lat:_myBranch[position].lat,lang:_myBranch[position].lang)));
              },
              child: Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.red,width: 1)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Branch Name : ${_myBranch[position].branchName}',style: localTextTitle,),
                      Text('Address :${_myBranch[position].branchAddress} ${_myBranch[position].districtName}',style: TextStyle(color: Colors.green,fontSize: 16)),
                      Text('phone :${_myBranch[position].phoneNumber}',style: TextStyle(color: Colors.green,fontSize: 16)),
                    ],
                  ),
                ),
              ),
            ),
          );
          }
      )
    );
  }

  void faceData()async{

    QuerySnapshot querySnapshot =await collectionRef.where('selectBank',isEqualTo: '$bankName').get();
    final allData = querySnapshot.docs;

    for(var items in allData){
     setState(() {
       _myBranch.add(ModelOfBranch(
         lat: 0.0,
         lang: 0.0,
         selectBank: items['selectBank'],
         districtName: items['districtName'],
         divisionName: items['divisionName'],
         branchName: items['branchName'],
         branchAddress: items['branchAddress'],
         phoneNumber: items['phoneNumber'],
         routingNumber: items['routingNumber'],
       ));
     });
    }
  }
}
