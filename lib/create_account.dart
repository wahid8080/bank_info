
import 'package:flutter/material.dart';

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
  String email;


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
                keyboardType: TextInputType.number,
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
                keyboardType: TextInputType.number,
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
                keyboardType: TextInputType.number,
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
                controller: emailController,
                onChanged: (text){
                  setState(() {
                    email = text;
                  });
                },
              ),
            ),
            SizedBox(height: 20,),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateAccount()));
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
}
