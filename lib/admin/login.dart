import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_project/admin/add_bank.dart';
import 'package:new_project/theme_data/ThemeData.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseUser user;

  bool isEmpty = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Email',
                  style: localText,
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      autofocus: false,
                      autocorrect: false,
                      textInputAction: TextInputAction.done,
                      style: TextStyle(
                          height: 1.5, fontSize: 12, fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        alignLabelWithHint: true,
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                      controller: emailController,
                      onChanged: (text) {
                        setState(() {
                          email = text;
                        });
                      },
                    ),
                  ),
                ),
                (email == null && isEmpty)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.error,
                            color: Colors.red,
                            size: 12,
                          ),
                          Text(
                            'Enter your email',
                            style: errorText,
                            textAlign: TextAlign.end,
                          ),
                        ],
                      )
                    : Container(),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Password',
                  style: localText,
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: TextField(
                      keyboardType: TextInputType.visiblePassword,
                      autofocus: false,
                      autocorrect: false,
                      textInputAction: TextInputAction.done,
                      style: TextStyle(
                          height: 1.5, fontSize: 12, fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(),
                      ),
                      controller: passwordController,
                      onChanged: (text) {
                        setState(() {
                          password = text;
                        });
                      },
                    ),
                  ),
                ),
                (password == null && isEmpty)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.error,
                            color: Colors.red,
                            size: 12,
                          ),
                          Text(
                            'Enter your password',
                            style: errorText,
                            textAlign: TextAlign.end,
                          ),
                        ],
                      )
                    : Container(),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isEmpty = true;
                    });
                  },
                  child: InkWell(
                    onTap: () {
                      loginUser(email: email, password: password);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.red, width: 2)),
                      child: Text('Login', style: titleTextWhite),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<FirebaseUser> loginUser({String email, String password}) async {
    try {
      var result = FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {

            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddBank()));
      });
    } catch (e) {
      // throw the Firebase AuthException that we caught
      throw new AuthException(e.code, e.message);
    }
  }
}
