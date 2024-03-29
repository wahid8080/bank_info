import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_project/admin/model_of_ATM.dart';
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
  CollectionReference collectionRef = FirebaseFirestore.instance.collection('AtmInfo');

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

  List<ModelOfATM> _myATM_Both=[];
  String bankName;
  _ATMState({this.bankName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('ATM'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), onPressed: (){

            })
          ],),
        body: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: _myATM_Both.length,
            itemBuilder: (context,position){
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MyBranchDetails(bankName: bankName,address:_myATM_Both[position].address,lat:_myATM_Both[position].lat,lang:_myATM_Both[position].lang)));
                  },
                  child: Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.red,width: 1)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('ATM Both Name : ${_myATM_Both[position].bothName}',style: localTextTitle,),
                          Text('Address :${_myATM_Both[position].address}',style: TextStyle(color: Colors.green,fontSize: 16)),
                          Text('Phone :${_myATM_Both[position].phone}',style: TextStyle(color: Colors.green,fontSize: 16)),
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

    QuerySnapshot querySnapshot =await collectionRef.where('bankName',isEqualTo: bankName).get();
    final allData = querySnapshot.docs;

    print(allData.length);
    for(var items in allData){

      setState(() {
        _myATM_Both.add(ModelOfATM(
          lat: items['lat'],
          lang: items['lang'],
          bankName : items['bankName'],
          bothName: items['bothName'],
          bothNo: items['bothNo'],
          address: items['address'],
          phone: items['phone'],
        ));
      });
    }
  }

}
