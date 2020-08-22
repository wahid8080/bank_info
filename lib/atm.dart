import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_project/admin/model_of_branch.dart';
import 'package:new_project/my-branch_details.dart';
import 'package:new_project/theme_data/ThemeData.dart';

class ATM extends StatefulWidget {
  String bankName;
  ATM({this.bankName});
  @override
  _ATMState createState() => _ATMState(bankName : bankName);
}

class _ATMState extends State<ATM> {
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
  _ATMState({this.bankName});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ATM'),),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(height: 1,color: Colors.grey,),
              Text('From branch'),
              Text('Description'),
              Divider(height: 1,color: Colors.grey,),
              Text('To branch'),
              Text('Description'),
              Divider(height: 1,color: Colors.grey,),
              Text('Routing number'),
              Text('4587966'),
              Divider(height: 1,color: Colors.grey,),
            ],
          ),
        ),
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
