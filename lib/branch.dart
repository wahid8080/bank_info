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
  final DBRef = FirebaseDatabase.instance.reference();
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

    await faceBranchData();

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
  Future<void> faceBranchData()async{
    await DBRef.child("branchInfo").child(bankName).once().then((DataSnapshot dataSnapshot){
      for(var value in dataSnapshot.value.keys){
        _myBranch.add(ModelOfBranch(
          lat: 0.0,
          lang: 0.0,
          selectBank: dataSnapshot.value[value]['selectBank'],
          districtName: dataSnapshot.value[value]['districtName'],
          divisionName: dataSnapshot.value[value]['divisionName'],
          branchName: dataSnapshot.value[value]['branchName'],
          branchAddress: dataSnapshot.value[value]['branchAddress'],
          phoneNumber: dataSnapshot.value[value]['phoneNumber'],
          routingNumber: dataSnapshot.value[value]['routingNumber'],
        ));
        print(dataSnapshot.value[value]['bankName']);
      }
    }).whenComplete(() {
      isLoading = false;
    });
  }

}
