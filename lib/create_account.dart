
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Account'),),
      body: Container(
        alignment: Alignment.center,
        child: Text(bankName),
      ),
    );
  }
}
