import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_project/admin/model_of_bank_info.dart';
import 'package:new_project/create_account.dart';
import 'package:new_project/theme_data/ThemeData.dart';
import 'package:toast/toast.dart';

class BankInfo extends StatefulWidget {
  String bankName;
  BankInfo({this.bankName});
  @override
  _BankInfoState createState() => _BankInfoState(bankName:bankName);
}

class _BankInfoState extends State<BankInfo> {
  String bankName;
  _BankInfoState({this.bankName});

  bool isLoading = true;
  CollectionReference collectionRef = FirebaseFirestore.instance.collection('BankInfoInfo');

  ModelOfBankInfo myBankInfo;

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bank Information'),),
      body: Builder(builder: (context){
        if(isLoading){
          return Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
        }else{
          try{
            return Container(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.red,width: 1)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Type Of Account',style: TextStyle(fontSize: 18,color: Colors.green),),
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateAccount(bankName: bankName,)));
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.red,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 7),
                                      child: Text('Subscribe',style: TextStyle(color: Colors.white),),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[

                                  Row(
                                    children: [
                                      (myBankInfo.salartAccount)?Icon(Icons.done,color: Colors.green,):Icon(Icons.clear,color: Colors.red,),
                                      Text('2) Salary Account',style: localText,),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      (myBankInfo.studentAccount)?Icon(Icons.done,color: Colors.green,):Icon(Icons.clear,color: Colors.red,),
                                      Text('3) Student Account',style: localText,),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      (myBankInfo.saveingsAccount)?Icon(Icons.done,color: Colors.green,):Icon(Icons.clear,color: Colors.red,),
                                      Text('4) Saving Account',style: localText,),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      (myBankInfo.foreignCurrencyAccount)?Icon(Icons.done,color: Colors.green,):Icon(Icons.clear,color: Colors.red,),
                                      Text('5) Foreign Currency Account',style: localText,),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      (myBankInfo.currentAccount)?Icon(Icons.done,color: Colors.green,):Icon(Icons.clear,color: Colors.red,),
                                      Text('1) Current Account',style: localText,),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  (myBankInfo.depositLimitision)?Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.red,width: 1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text('Deposit Limitision',style: TextStyle(fontSize: 18,color: Colors.green)),
                            Padding(
                              padding: const EdgeInsets.only(left:10.0),
                              child: Text(myBankInfo.depositLimitisionString,style: localText,),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ):Container(),
                  (myBankInfo.withdrowLimitision)?Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),border: Border.all(color: Colors.red,width: 1)),
                      child:  Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text('Withdrow Limitision',style: TextStyle(fontSize: 18,color: Colors.green)),
                            Padding(
                              padding: const EdgeInsets.only(left:10.0),
                              child: Text(myBankInfo.withdrowLimitisionString,style: localText),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ):Container(),
                  (myBankInfo.interestLimitision)?Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),border: Border.all(color: Colors.red,width: 1)),
                      child:  Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text('Interst information',style: TextStyle(fontSize: 18,color: Colors.green)),
                            Padding(
                              padding: const EdgeInsets.only(left:10.0),
                              child: Text(myBankInfo.interestLimitisionString,style: localText),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ):Container(),
                ],
              ),
            );
          }
          catch(e){
            print(e);
          }
        }
        return Container();
      })
    );
  }

  void faceData()async{

    QuerySnapshot querySnapshot =await collectionRef.where('selectedBank',isEqualTo: '$bankName').get();
    final allData = querySnapshot.docs;

    for(var items in allData){
      setState(() {
        myBankInfo = ModelOfBankInfo(
          selectedBank: items['selectedBank'],
          currentAccount: items['currentAccount'],
          salartAccount: items['salartAccount'],
          studentAccount: items['studentAccount'],
          saveingsAccount:items['saveingsAccount'],
          foreignCurrencyAccount:items['foreignCurrencyAccount'],
          depositLimitision:items['depositLimitision'],
          depositLimitisionString:items['depositLimitisionString'],
          withdrowLimitision:items['withdrowLimitision'],
          withdrowLimitisionString:items['withdrowLimitisionString'],
          interestLimitision:items['interestLimitision'],
          interestLimitisionString:items['interestLimitisionString'],
        );
      });
    }
  }
}
