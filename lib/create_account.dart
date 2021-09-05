
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:new_project/admin/model_of_Subscribe.dart';
import 'package:toast/toast.dart';

class CreateAccount extends StatefulWidget {
  String bankName;
  CreateAccount({this.bankName});
  @override
  _CreateAccountState createState() => _CreateAccountState(bankName: bankName);
}

class _CreateAccountState extends State<CreateAccount> {
  String bankName;
  _CreateAccountState({this.bankName});

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String email;
  String name;
  String description;


  User user;
  FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseStorage storage = FirebaseStorage.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Subscribe'),),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            Container(
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                autofocus: false,
                autocorrect: false,
                textInputAction: TextInputAction.done,
                style: TextStyle(
                    height: 1.5, fontSize: 12, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  contentPadding:
                  EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                  hintText: 'Email',
                ),
                controller: emailController,
                onChanged: (text){
                  setState(() {
                    email = text;
                  });
                },
              ),
            ),
            SizedBox(height: 20,),
            Container(
              child: TextField(
                keyboardType: TextInputType.name,
                autofocus: false,
                autocorrect: false,
                textInputAction: TextInputAction.done,
                style: TextStyle(
                    height: 1.5, fontSize: 12, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  contentPadding:
                  EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                  hintText: 'User name',
                ),
                controller: nameController,
                onChanged: (text){
                  setState(() {
                    name = text;
                  });
                },
              ),
            ),
            SizedBox(height: 20,),
            Container(
              child: TextField(
                keyboardType: TextInputType.name,
                autofocus: false,
                autocorrect: false,
                textInputAction: TextInputAction.done,
                style: TextStyle(
                    height: 1.5, fontSize: 12, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  contentPadding:
                  EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                  hintText: 'Descreption',
                ),
                controller: descriptionController,
                onChanged: (text){
                  setState(() {
                    description = text;
                  });
                },
              ),
            ),
            SizedBox(height: 20,),
            InkWell(
              onTap: (){
                var myData = ModelOfSubscribe(email: email,userName: name,description: description,bankName: bankName);
                subscriptionUser(myData);
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
      ),
    );
  }

  void subscriptionUser(ModelOfSubscribe modelOfSubscribe)async{

    await _firestore.collection("bankSubscription").add({
      'email' :modelOfSubscribe.email,
      'userName': modelOfSubscribe.userName,
      'description' : modelOfSubscribe.description,
      'BankName' : modelOfSubscribe.bankName,
    }).whenComplete(() {
      Toast.show('Success', context);
      Navigator.pop(context);
    });
  }
}
