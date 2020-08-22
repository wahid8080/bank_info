import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_project/admin/login.dart';
import 'package:new_project/admin/model_of_bank.dart';
import 'package:new_project/atm.dart';
import 'package:new_project/bankInformation.dart';
import 'package:new_project/branch.dart';
import 'package:new_project/create_account.dart';
import 'package:new_project/routing.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'bangladeshi bank information',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DBRef = FirebaseDatabase.instance.reference();
  int count = 0;
  List<ModelOfBank> _myBankList = [];

  bool isLoading = true;

  bool isSearch = false;

  TextEditingController searchController = TextEditingController();
  String search;

  @override
  void initState() {
    // TODO: implement initState
    initValue();
    super.initState();
  }

  initValue() async {
    setState(() {
      isLoading = true;
    });

    await faceData();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BD Bank Info'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {
            setState(() {
              isSearch = true;
            });
          }),
          IconButton(icon: Icon(Icons.person), onPressed: (){
            setState(() {
              if (count > 2) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Login()));
              }
              count++;
            });
          })
        ],
      ),
      body: Builder(builder: (context) {
        if (isLoading) {
          return Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
        }

        return SafeArea(
          child: Stack(
            children: [

              ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: _myBankList.length,
                  itemBuilder: (context, position) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                      child: Card(
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      'Bank Info',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.info, color: Colors.grey),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => BankInfo(
                                                      bankName:
                                                      _myBankList[position]
                                                          .bankName)));
                                        }),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          _myBankList[position].imageFile),
                                    ),
                                  ),
                                ),
                                Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Text(
                                            _myBankList[position]
                                                .bankTitle
                                                .toUpperCase(),
                                            style: Theme.of(context).textTheme.title,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10.0),
                                          child: Text(_myBankList[position].bankName),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              InkWell(
                                                onTap: (){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ATM(bankName: _myBankList[position].bankName,)));
                                                },
                                                child: Container(
                                                  child: Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.local_atm,
                                                        color: Colors.red,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(
                                                            left: 6.0),
                                                        child: Text("ATM"),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: (){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>RoutingList(bankName: _myBankList[position].bankName)));
                                                },
                                                child: Container(
                                                  child: Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.storage,
                                                        color: Colors.red,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(
                                                            left: 6.0),
                                                        child: Text("Routing"),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => Branch(bankName: _myBankList[position].bankName)));
                                                },
                                                child: Container(
                                                  child: Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.home,
                                                        color: Colors.red,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(
                                                            left: 6.0),
                                                        child: Text(
                                                          "Branch",
                                                          style: TextStyle(
                                                              decoration: TextDecoration
                                                                  .underline,
                                                              color: Colors.green),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )),
                              ],
                            )),
                      ),
                    );
                  }),
              (!isSearch)?Container():Container(
                color: Colors.white,
                alignment: Alignment.center,
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          autofocus: false,
                          autocorrect: false,
                          textInputAction: TextInputAction.done,
                          style: TextStyle(height: 1.5, fontSize: 12, fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                            hintText: 'Type to search',
                            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          controller: searchController,
                          onChanged: (text) {
                            setState(() {
                              search = text;
                            });
                          },
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: (){
                        setState(() {
                          isSearch = false;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          )
        );
      }),
    );
  }

  Future<void> faceData() async {
    await DBRef.child("BankName").once().then((DataSnapshot dataSnapshot) {
      for (var value in dataSnapshot.value.keys) {
        _myBankList.add(ModelOfBank(
          imageFile: dataSnapshot.value[value]['imageFile'],
          bankName: dataSnapshot.value[value]['bankName'],
          bankTitle: dataSnapshot.value[value]['bankTitle'],
          headOffice: dataSnapshot.value[value]['headOffice'],
          bankInfo: dataSnapshot.value[value]['bankInfo'],
        ));
        print(dataSnapshot.value[value]['bankName']);
      }
    }).whenComplete(() {
      isLoading = false;
    });
  }
}
