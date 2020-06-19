import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Branch extends StatefulWidget {
  @override
  _BranchState createState() => _BranchState();
}

class _BranchState extends State<Branch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Branch'),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.search), onPressed: (){

        })
      ],),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
          itemCount: 10,
          itemBuilder: (context,position){
          return branchDesign();
          }
      )
    );
  }
  Widget branchDesign(){
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: 80,
        child: Card(
          elevation: 5.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
               Container(
                 child:  Row(
                   children: <Widget>[
                     Text('Branch Name : ',style: TextStyle(fontSize: 16),),
                     Text('Barishal',style: TextStyle(color: Colors.grey,fontSize: 16)),
                   ],
                 ),
               ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text('Barishal new market, mukta tawer 6 flor, 34/5',style: TextStyle(color: Colors.green,fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
