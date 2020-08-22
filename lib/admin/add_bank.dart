import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_project/admin/model_of_bank.dart';
import 'package:new_project/admin/model_of_bank_info.dart';
import 'package:new_project/admin/model_of_branch.dart';
import 'package:new_project/google_map.dart';
import 'package:new_project/theme_data/ThemeData.dart';
import 'package:toast/toast.dart';

class AddBank extends StatefulWidget {
  @override
  _AddBankState createState() => _AddBankState();
}

class _AddBankState extends State<AddBank> {

  FirebaseUser user;
  FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseStorage storage = FirebaseStorage.instance;

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
  String url;

  TextEditingController districtNameController = TextEditingController();
  TextEditingController divisionNameController = TextEditingController();
  TextEditingController branchNameController = TextEditingController();
  TextEditingController branchAddressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController routingNumberController = TextEditingController();

  TextEditingController depositLimitisionController = TextEditingController();
  TextEditingController withdrowLimitisionController = TextEditingController();
  TextEditingController interestLimitisionController = TextEditingController();

  double lat,lang;
  String selectBankName;
  String districtName;
  String divisionName;
  String branchName;
  String branchAddress;
  String phoneNumber;
  String routingNumber;

  bool addBankBool = false;
  bool addBranchBool = false;
  bool addAccountOfBank = false;
  bool addBabkInfoBool = false;
  bool isLoading = true;
  bool isWorking = false;
  bool isWorking1 = false;

  bool depositLimitision = false;
  bool withdrowLimitision = false;
  bool interestLimitision = false;

  String depositLimitisionString;
  String withdrowLimitisionString;
  String interestLimitisionString;



  bool salartAccount = false;
  bool studentAccount = false;
  bool saveingsAccount = false;
  bool currentAccount = false;
  bool foreignCurrencyAccount = false;

  List<String> bankList=[];

  @override
  void initState() {
    // TODO: implement initState
    faceData();
    getCurrentUser();
    geoLocation();
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
            SizedBox(height: 20,),
            Container(
              color: Colors.green,
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
                    (isWorking)?Container(
                      alignment: Alignment.center,
                      height: 40,
                      child: CircularProgressIndicator(),
                    ):InkWell(
                      onTap: () {
                        setState(() {
                          isWorking = true;
                        });
                        _getImageUrl(imageFile).then((value){
                          print("First value"+value);
                          var myData = ModelOfBank(imageFile: value,bankName: bankName,bankTitle: bankTitle,headOffice: headOffice,bankInfo: bankInfo);
                          print("second value"+myData.imageFile);
                          addBank(myData,imageFile);
                          imageFile = null;
                        });

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
              color: Colors.green,
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
                    Text('Google Map',style: localText,),
                    SizedBox(height: 3,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MyGoogleMap()));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        alignment: Alignment.center,
                        color: Colors.red,
                        child: Text('Open Google Map',style: titleTextWhite,textAlign: TextAlign.center,),
                      ),
                    ),
                    SizedBox(height: 10,),
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
                    SizedBox(height: 10,),
                    Text('District name',style: localText,),
                    SizedBox(height: 3,),
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
                          controller: districtNameController,
                          onChanged: (text){
                            setState(() {
                              districtName = text;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text('Division Name',style: localText,),
                    SizedBox(height: 3,),
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
                          controller: divisionNameController,
                          onChanged: (text){
                            setState(() {
                              divisionName = text;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text('Branch name',style: localText,),
                    SizedBox(height: 3,),
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
                          controller: branchNameController,
                          onChanged: (text){
                            setState(() {
                              branchName = text;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text('Branch Address',style: localText,),
                    SizedBox(height: 3,),
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
                          controller: branchAddressController,
                          onChanged: (text){
                            setState(() {
                              branchAddress = text;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text('Branch Phone Number',style: localText,),
                    SizedBox(height: 3,),
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
                          controller: phoneNumberController,
                          onChanged: (text){
                            setState(() {
                              phoneNumber = text;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text('Routing Number',style: localText,),
                    SizedBox(height: 3,),
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
                          controller: routingNumberController,
                          onChanged: (text){
                            setState(() {
                              routingNumber = text;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    (isWorking1)?Container(
                      height: 40,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    ):InkWell(
                      onTap: () {
                        setState(() {
                          isWorking1 = true;
                        });
                        var myData = ModelOfBranch(
                            lat: lat,
                            lang: lang,
                            selectBank: selectBankName,
                            districtName: districtName,
                            divisionName: divisionName,
                            branchName: branchName,
                            branchAddress: branchAddress,
                            phoneNumber: phoneNumber,
                            routingNumber: routingNumber
                        );
                        addBranch(myData);
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
              color: Colors.green,
              height: 70,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Add Bank Information',style: localTextWhite,),
                    IconButton(icon: (!addBabkInfoBool)?Icon(Icons.add,color: Colors.white,):Icon(Icons.clear,color: Colors.white), onPressed: (){
                      setState(() {
                        addBabkInfoBool = !addBabkInfoBool;
                      });
                    })
                  ],
                ),
              ),
            ),
            (addBabkInfoBool)?Container(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
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
                    SizedBox(height: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Types of Accounts'),
                        Padding(
                          padding: const EdgeInsets.only(left:30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Checkbox(value: currentAccount, onChanged: (value){
                                    setState(() {
                                      currentAccount = !currentAccount;
                                    });
                                  }),
                                  Text('Current Account',style: localText,)
                                ],
                              ),
                              Row(
                                children: [
                                  Checkbox(value: salartAccount, onChanged: (value){
                                    setState(() {
                                      salartAccount = !salartAccount;
                                    });
                                  }),
                                  Text('Salary Account',style: localText,)
                                ],
                              ),
                              Row(
                                children: [
                                  Checkbox(value: studentAccount, onChanged: (value){
                                    setState(() {
                                      studentAccount = !studentAccount;
                                    });
                                  }),
                                  Text('Student Account',style: localText,)
                                ],
                              ),
                              Row(
                                children: [
                                  Checkbox(value: saveingsAccount, onChanged: (value){
                                    setState(() {
                                      saveingsAccount = !saveingsAccount;
                                    });
                                  }),
                                  Text('Saving Account',style: localText,)
                                ],
                              ),
                              Row(
                                children: [
                                  Checkbox(value: foreignCurrencyAccount, onChanged: (value){
                                    setState(() {
                                      foreignCurrencyAccount = !foreignCurrencyAccount;
                                    });
                                  }),
                                  Text('Foreign Currency Account',style: localText,)
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Checkbox(value: depositLimitision, onChanged: (value){
                              setState(() {
                                depositLimitision = !depositLimitision;
                              });
                            }),
                            Text('Deposit Limitation',style: localText),
                          ],
                        ),
                        (depositLimitision)?Padding(
                          padding: const EdgeInsets.only(left:15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               SizedBox(height: 3,),
                               Text('Comment',style: localText,),
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
                                     controller: depositLimitisionController,
                                     onChanged: (text){
                                       setState(() {
                                         depositLimitisionString = text;
                                       });
                                     },
                                   ),
                                 ),
                               ),
                             ],
                          ),
                        ):Container()
                      ],
                    ),
                    SizedBox(height: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Checkbox(value: withdrowLimitision, onChanged: (value){
                              setState(() {
                                withdrowLimitision = !withdrowLimitision;
                              });
                            }),
                            Text('Withdraw Limitation',style: localText),
                          ],
                        ),
                        (withdrowLimitision)?Padding(
                          padding: const EdgeInsets.only(left:15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 3,),
                              Text('Comment',style: localText,),
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
                                    controller: withdrowLimitisionController,
                                    onChanged: (text){
                                      setState(() {
                                        withdrowLimitisionString = text;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ):Container()
                      ],
                    ),
                    SizedBox(height: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Checkbox(value: interestLimitision, onChanged: (value){
                              setState(() {
                                interestLimitision = !interestLimitision;
                              });
                            }),
                            Text('Interest Limitation',style: localText),
                          ],
                        ),
                        (interestLimitision)?Padding(
                          padding: const EdgeInsets.only(left:15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 3,),
                              Text('Comment',style: localText,),
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
                                    controller: interestLimitisionController,
                                    onChanged: (text){
                                      setState(() {
                                        interestLimitisionString = text;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ):Container()
                      ],
                    ),
                    SizedBox(height: 20,),
                    (isWorking1)?Container(
                      height: 40,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    ):InkWell(
                      onTap: () {
                        setState(() {
                          isWorking1 = true;
                        });
                        var myData = ModelOfBankInfo(
                            selectedBank: selectBankName,
                            currentAccount: currentAccount,
                            salartAccount: salartAccount,
                            studentAccount: studentAccount,
                            saveingsAccount: saveingsAccount,
                            foreignCurrencyAccount: foreignCurrencyAccount,
                            depositLimitision: depositLimitision,
                            depositLimitisionString: depositLimitisionString,
                            withdrowLimitision: withdrowLimitision,
                            withdrowLimitisionString: withdrowLimitisionString,
                            interestLimitision: interestLimitision,
                            interestLimitisionString: interestLimitisionString
                        );
                        addBankInfo(myData);
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

  Future<String> _getImageUrl(File image)async{
    StorageReference reference = storage.ref().child("Images").child('BankImage').child(DateTime.now().millisecondsSinceEpoch.toString());
    StorageUploadTask uploadTask = reference.putFile(image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }

  void addBank(ModelOfBank bank,File imageFile){

    DBRef.child("BankName").push().set({
      'imageFile' : bank.imageFile,
      'bankName' : bank.bankName,
      'bankTitle' : bank.bankTitle,
      'headOffice' :bank.headOffice,
      'bankInfo': bank.bankInfo
    }).whenComplete((){
      Toast.show('Data insert successfully', context);
      setState(() {
        isWorking =false;
      });
    });
  }

  void addBranch(ModelOfBranch branch){
    DBRef.child("branchInfo").child(branch.selectBank).push().set({
      'lat' : branch.lat,
      'lang' : branch.lang,
      'selectBank' :branch.selectBank,
      'districtName': branch.districtName,
      'divisionName' : branch.divisionName,
      'branchName' : branch.branchName,
      'branchAddress' :branch.branchAddress,
      'phoneNumber': branch.phoneNumber,
      'routingNumber': branch.routingNumber,
    }).whenComplete(() {
      Toast.show('Success', context);
      setState(() {
        isWorking1 = false;
      });
    });
  }

  void addBankInfo(ModelOfBankInfo bankInfo){
    DBRef.child("BankInfoInfo").child(bankInfo.selectedBank).set({
      'selectedBank' :bankInfo.selectedBank,
      'currentAccount': bankInfo.currentAccount,
      'salartAccount' : bankInfo.salartAccount,
      'studentAccount' : bankInfo.studentAccount,
      'saveingsAccount' :bankInfo.saveingsAccount,
      'foreignCurrencyAccount': bankInfo.foreignCurrencyAccount,
      'depositLimitision': bankInfo.depositLimitision,
      'depositLimitisionString' : bankInfo.depositLimitisionString,
      'withdrowLimitision' : bankInfo.withdrowLimitision,
      'withdrowLimitisionString' :bankInfo.withdrowLimitisionString,
      'interestLimitision': bankInfo.interestLimitision,
      'interestLimitisionString': bankInfo.interestLimitisionString,
    }).whenComplete(() {
      Toast.show('Success', context);
      setState(() {
        isWorking1 = false;
      });
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

  void geoLocation()async{
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    lat = position.latitude;
    lang = position.longitude;
    print(position);
  }
}
