import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_project/admin/model_of_bank.dart';
import 'package:new_project/theme_data/ThemeData.dart';
import 'package:toast/toast.dart';

class AddBank extends StatefulWidget {
  @override
  _AddBankState createState() => _AddBankState();
}

class _AddBankState extends State<AddBank> {

  FirebaseUser user;
  FirebaseAuth auth = FirebaseAuth.instance;

  final DBRef = FirebaseDatabase.instance.reference();

  TextEditingController bankNameController = TextEditingController();
  TextEditingController bankTitleController = TextEditingController();
  TextEditingController headOfficeController = TextEditingController();
  TextEditingController bankInfoController = TextEditingController();
  String bankName;
  String bankTitle;
  String bankInfo;
  String headOffice;
  File imageFile;

  String selectBankName;


  bool addBankBool = false;
  bool addBranchBool = false;
  bool isLoading = true;

  List<String> bankList=[];

  @override
  void initState() {
    // TODO: implement initState
    faceData();
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
      appBar: AppBar(title: Text('Add Information'),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color(0xFFd6cf00),
              height: 70,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Add Bank Information',style: localTextWhite,),
                    IconButton(icon: (!addBankBool)?Icon(Icons.add,color: Colors.white,):Icon(Icons.clear,color: Colors.white), onPressed: (){
                      setState(() {
                        addBankBool = !addBankBool;
                      });
                    })
                  ],
                ),
              ),
            ),
            (addBankBool)?Container(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                          controller: bankTitleController,
                          onChanged: (text){
                            setState(() {
                              bankTitle = text;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text('Head office',style: localText,),
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
                          controller: headOfficeController,
                          onChanged: (text){
                            setState(() {
                              headOffice = text;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text('Bank Inforation',style: localText,),
                    SizedBox(height: 5,),
                    Container(
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
                          controller: bankInfoController,
                          onChanged: (text){
                            setState(() {
                              bankInfo = text;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    InkWell(
                      onTap: () {
                        var myData = ModelOfBank(imageFile: imageFile,bankName: bankName,bankTitle: bankTitle,headOffice: headOffice,bankInfo: bankInfo);
                        addBank(myData);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.red, width: 2)),
                        child: Text('Save', style: titleTextWhite),
                      ),
                    ),
                  ],
                ),
              ),
            ):Container(),
            SizedBox(height: 20,),
            Container(
              color: Color(0xFFd6cf00),
              height: 70,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Add Branch',style: localTextWhite,),
                    IconButton(icon: (!addBranchBool)?Icon(Icons.add,color: Colors.white,):Icon(Icons.clear,color: Colors.white), onPressed: (){
                      setState(() {
                        addBranchBool = !addBranchBool;
                      });
                    })
                  ],
                ),
              ),
            ),
            (addBranchBool)?Container(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
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
                              value: selectBankName,
                              items: bankList.map((String value){
                                return DropdownMenuItem<String>(child: Text(value),value: value,);
                              }).toList(),
                              onChanged: (value){
                                setState(() {
                                  selectBankName = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text('Address',style: localText,),
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
                    Text('Discreption',style: localText,),
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
                          controller: bankTitleController,
                          onChanged: (text){
                            setState(() {
                              bankTitle = text;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    InkWell(
                      onTap: () {
                        //addBranch();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.red, width: 2)),
                        child: Text('Save', style: titleTextWhite),
                      ),
                    ),
                  ],
                ),
              ),
            ):Container(),
            SizedBox(height: 20,),
            Container(
              color: Color(0xFFd6cf00),
              height: 70,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Add Account Of Bank',style: localTextWhite,),
                    IconButton(icon: (!addBranchBool)?Icon(Icons.add,color: Colors.white,):Icon(Icons.clear,color: Colors.white), onPressed: (){
                      setState(() {
                        addBranchBool = !addBranchBool;
                      });
                    })
                  ],
                ),
              ),
            ),
            (addBranchBool)?Container(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
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
                              value: selectBankName,
                              items: bankList.map((String value){
                                return DropdownMenuItem<String>(child: Text(value),value: value,);
                              }).toList(),
                              onChanged: (value){
                                setState(() {
                                  selectBankName = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text('Address',style: localText,),
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
                    Text('Discreption',style: localText,),
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
                          controller: bankTitleController,
                          onChanged: (text){
                            setState(() {
                              bankTitle = text;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    InkWell(
                      onTap: () {
                        //addBranch();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.red, width: 2)),
                        child: Text('Save', style: titleTextWhite),
                      ),
                    ),
                  ],
                ),
              ),
            ):Container(),
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

  void addBank(ModelOfBank bank){
    DBRef.child("BankName").push().set({
      'bankName' : bank.bankName,
      'bankTitle' : bank.bankTitle,
      'headOffice' :bank.headOffice,
      'bankInfo': bank.bankInfo
    });
  }

  void addBranch(ModelOfBank bank){
    DBRef.child("BankName").push().set({
      'bankName' : bank.bankName,
      'bankTitle' : bank.bankTitle,
      'headOffice' :bank.headOffice,
      'bankInfo': bank.bankInfo
    });
  }

  void faceData(){
    String bankName;
    DBRef.child("BankName").once().then((DataSnapshot dataSnapshot){
      for(var value in dataSnapshot.value.keys){
        print(dataSnapshot.value[value]['bankName']);
        bankName = dataSnapshot.value[value]['bankName'];
        bankList.add(bankName);
      }
    });
  }
}
