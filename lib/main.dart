import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_project/admin/login.dart';
import 'package:new_project/admin/model_of_bank.dart';
import 'package:new_project/bankInformation.dart';
import 'package:new_project/branch.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bank Information',
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
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
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
          child: ListView.builder(
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
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 6.0),
                                              child: Text("30k"),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.favorite_border,
                                              color: Colors.red,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 6.0),
                                              child: Text("3k"),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Branch(
                                                      bankName:
                                                          _myBankList[position]
                                                              .bankName)));
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
