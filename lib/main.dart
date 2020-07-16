import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_project/admin/login.dart';
import 'package:new_project/bankInformation.dart';
import 'package:new_project/branch.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bank Information',
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

  int count=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            setState(() {
              if(count>2){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
              }
              count++;
            });
          },
            child: Icon(Icons.home)),
         actions: <Widget>[
           IconButton(icon: Icon(Icons.search), onPressed: (){

           })
         ],
      ),
      body: SafeArea(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 5,
            itemBuilder: (context, position) {
              return Padding(
                padding: const EdgeInsets.only(left:4.0,right: 4.0),
                child: Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Container(
                      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text('Bank Info',style: TextStyle(color: Colors.grey),),
                              IconButton(icon: Icon(Icons.info,color: Colors.grey), onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>BankInfo()));
                              }),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  //image: NetworkImage("https://picsum.photos/250?image=9"),
                                  image: AssetImage('images/al-arafah-islami-bank-limited-3.jpg'),
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
                                  child: Text("Al arafa bank".toUpperCase(),style: Theme.of(context).textTheme.title,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left:10.0),
                                  child: Text('Islami bank limited'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[

                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            Icon(Icons.favorite,color: Colors.red,),
                                            Padding(
                                              padding: const EdgeInsets.only(left:6.0),
                                              child: Text("30k"),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            Icon(Icons.favorite_border,color: Colors.red,),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 6.0),
                                              child: Text("3k"),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Branch()));
                                       },
                                        child: Container(
                                          child: Row(
                                            children: <Widget>[
                                              Icon(Icons.home,color: Colors.red,),
                                              Padding(
                                                padding: const EdgeInsets.only(left:6.0),
                                                child: Text("Branch",style: TextStyle(decoration: TextDecoration.underline,color: Colors.green),),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ),
                        ],
                      )),
                ),
              );
            }),
      ),
    );
  }
}
