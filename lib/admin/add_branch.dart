import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_project/theme_data/ThemeData.dart';

class AddBank extends StatefulWidget {
  @override
  _AddBankState createState() => _AddBankState();
}

class _AddBankState extends State<AddBank> {

  FirebaseUser user;
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child('bank_name');

  TextEditingController bankNameController = TextEditingController();
  String bankName;
  File imageFile;


  @override
  void initState() {
    // TODO: implement initState
    getCurrentUser();

    super.initState();
  }

  void getCurrentUser()async{
    user = await auth.currentUser();
    print(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Bank'),),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.0),
                border: Border.all(color: Colors.grey),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton(
                      elevation: 0,
                      iconSize: 24,
                      isExpanded: true,
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                      icon: Icon(Icons.arrow_drop_down_circle),
                      hint: Text('Select Bank'),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.0),
                border: Border.all(color: Colors.grey),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    RaisedButton(
                      onPressed: () {
                        _showChooseDialog(context);
                      },
                      child: (imageFile!=null)?Text("Image Selected"):Text("Select Image"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: (imageFile!=null)?Text("1 image attach"):Text("Choose your file"+"\n(*Optional)"),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            Text('Bank Name',style: localText,),
            SizedBox(height: 5,),
            Container(
              height: 40,
              child: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: TextField(
                  keyboardType: TextInputType.text,
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
                  ),
                  controller: bankNameController,
                  onChanged: (text){
                    setState(() {
                      bankName = text;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20,),
            Text('Bank Title',style: localText,),
            SizedBox(height: 5,),
            Container(
              height: 40,
              child: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: TextField(
                  keyboardType: TextInputType.text,
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
                  ),
                  controller: bankNameController,
                  onChanged: (text){
                    setState(() {
                      bankName = text;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20,),
            Text('Bank Inforation',style: localText,),
            SizedBox(height: 5,),
            Container(
              height: 40,
              child: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: TextField(
                  keyboardType: TextInputType.text,
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
                  ),
                  controller: bankNameController,
                  onChanged: (text){
                    setState(() {
                      bankName = text;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showChooseDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.image,color: Colors.grey,),
                          SizedBox(width: 10,),
                          Text('Select Gallery Image'),
                        ],
                      ),
                    ),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),

                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.camera_alt,color: Colors.grey,),
                          SizedBox(width: 10,),
                          Text('Open Camera'),
                        ],
                      ),
                    ),
                    onTap: () {
                      _openCamera(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _openGallery(BuildContext context) async{
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = picture;

    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

}
