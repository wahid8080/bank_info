import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_project/admin/model_of_Subscribe.dart';
import 'package:new_project/theme_data/ThemeData.dart';

class ViewAccountSubscription extends StatefulWidget {
  ViewAccountSubscription({Key key}) : super(key: key);

  @override
  _ViewAccountSubscriptionState createState() =>
      _ViewAccountSubscriptionState();
}

class _ViewAccountSubscriptionState extends State<ViewAccountSubscription> {
  CollectionReference collectionRef = FirebaseFirestore.instance.collection('bankSubscription');

  bool isLoading = true;

  List<ModelOfSubscribe> _subscriptionData=[];

  @override
  initState(){
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [

        ],
        title: Text("Account Subscriptions"),
      ),
      body: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: _subscriptionData.length,
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
                      Text('Bank Name : ${_subscriptionData[position].bankName}',style: TextStyle(fontSize: 16),),
                      Text('Name :${_subscriptionData[position].userName}',style: TextStyle(fontSize: 16)),
                      Text('Email :${_subscriptionData[position].email}',style: TextStyle(color: Colors.grey[700],fontSize: 14)),
                    ],
                  ),
                ),
              ),
            );
          }
      ),
    );
  }


  void faceData()async{

    QuerySnapshot querySnapshot =await collectionRef.get();
    final allData = querySnapshot.docs;

    for(var items in allData){
      setState(() {
        _subscriptionData.add(ModelOfSubscribe(
          bankName: items['BankName'],
          email: items['email'],
          description: items['description'],
          userName: items['userName'],
        ));
      });
    }
  }

}