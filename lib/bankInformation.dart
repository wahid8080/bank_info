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
  final DBRef = FirebaseDatabase.instance.reference();

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

    await faceBankInfoData();

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
        }
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
                            IconButton(icon: Icon(Icons.description,color: Colors.green,), onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateAccount(bankName:bankName)));
                            })
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  (myBankInfo.currentAccount)?Icon(Icons.done,color: Colors.green,):Icon(Icons.clear,color: Colors.red,),
                                  Text('1) Current Account',style: localText,),
                                ],
                              ),
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
      })
    );
  }
  Future<void>faceBankInfoData()async{
    await DBRef.child("BankInfoInfo").child(bankName).once().then((snapshot){
      var myData = snapshot.value;

      myBankInfo = ModelOfBankInfo(
        selectedBank: myData['selectedBank'],
        currentAccount: myData['currentAccount'],
        salartAccount: myData['salartAccount'],
        studentAccount: myData['studentAccount'],
        saveingsAccount:myData['saveingsAccount'],
        foreignCurrencyAccount:myData['foreignCurrencyAccount'],
        depositLimitision:myData['depositLimitision'],
        depositLimitisionString:myData['depositLimitisionString'],
        withdrowLimitision:myData['withdrowLimitision'],
        withdrowLimitisionString:myData['withdrowLimitisionString'],
        interestLimitision:myData['interestLimitision'],
        interestLimitisionString:myData['interestLimitisionString'],
      );
    }).catchError((value){
      setState(() {
        Toast.show(value, context);
      });
    });
  }

}
