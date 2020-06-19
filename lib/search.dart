import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
        ),
        actions: <Widget>[
            Container(
              color: Colors.white,
            ),
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: (){

          }),

        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (BuildContext context, int index){
                return searchItem();
            },
            ),
          ),

          
        ],
      ),
    );
  }


  static Widget searchItem(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left:8.0,top: 4.0),
          child: Container(
            alignment: Alignment.center,
            height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(0xFFEEEEEE),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left:10.0,right: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right:8.0),
                    child: Text("Barishal"),
                  ),
                  GestureDetector(
                      onTap: (){

                      },
                      child: Icon(Icons.close,size: 18,)),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
