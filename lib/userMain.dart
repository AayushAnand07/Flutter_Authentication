import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page/services/Auth.dart';
import 'package:login_page/signup.dart';
import 'dart:async';

import 'login.dart';

class userMain extends StatelessWidget {
  const userMain({Key? key}) : super(key: key);

  Future logOut(BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      await _auth.signOut().then((value) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => Authentication()));
      });
    } catch (e) {
      print("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            logOut(context);
          },
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 13),
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                      colors: [Color(0xff0F52BA), Color(0xff002366)])),
              alignment: Alignment.center,
              child: Text(
                'Sign Out',
                style: simpleButtonstyle(),
              )),
        ),
      ),
    );
  }
}
