import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BankInfo extends StatefulWidget {
  @override
  _BankInfoState createState() => _BankInfoState();
}

class _BankInfoState extends State<BankInfo> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text('Bank Information'),),
      body: Container(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left:8.0,right: 8.0,top: 4,bottom: 4),
              child: Card(
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: height/4,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text('Type Of Account',style: TextStyle(fontSize: 24,color: Colors.green),),
                        Padding(
                          padding: const EdgeInsets.only(left:20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('1) Current Account'),
                              Text('2) Salary Account'),
                              Text('3) Student Account'),
                              Text('4) Saving Account'),
                              Text('5) Foreign Currency Account'),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:8.0,right: 8.0,top: 4,bottom: 4),
              child: Card(
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: height/4,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text('Deposit Limitision',style: TextStyle(fontSize: 24,color: Colors.green)),
                        Padding(
                          padding: const EdgeInsets.only(left:10.0),
                          child: Text('Description: an institution that deals in money and its substitutes and provides other financial services. Banks accept deposits and make loans and derive a profit from the difference in the interest rates paid and charged, respectively.'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:8.0,right: 8.0,top: 4,bottom: 4),
              child: Card(
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: height/4,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text('Withdrow Limitision',style: TextStyle(fontSize: 24,color: Colors.green)),
                        Padding(
                          padding: const EdgeInsets.only(left:10.0),
                          child: Text('Description: an institution that deals in money and its substitutes and provides other financial services. Banks accept deposits and make loans and derive a profit from the difference in the interest rates paid and charged, respectively.'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:8.0,right: 8.0,top: 4,bottom: 4),
              child: Card(
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: height/4,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text('Interst information',style: TextStyle(fontSize: 24,color: Colors.green)),
                        Padding(
                          padding: const EdgeInsets.only(left:10.0),
                          child: Text('Description: an institution that deals in money and its substitutes and provides other financial services. Banks accept deposits and make loans and derive a profit from the difference in the interest rates paid and charged, respectively.'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
