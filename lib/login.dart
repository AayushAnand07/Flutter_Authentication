import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page/services/signinWithGoogle.dart';
//import 'package:login_page/services/Auth.dart';
import 'package:login_page/signup.dart';

import 'package:login_page/userMain.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_core/firebase_core.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

//AuthMethod authMethods = new AuthMethod();
final _formkey = GlobalKey<FormState>();
TextEditingController EmailTexteditingController = new TextEditingController();
TextEditingController PasswordTexteditingController =
    new TextEditingController();

var email = "";
var password = "";
bool _isLoading = false;

class _LoginPageState extends State<LoginPage> {
  final _amountController = TextEditingController();
  final _titleController = TextEditingController();

  signIn() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => userMain(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user with that Email');
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('No user with that Email',
              style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
        ),
      );
    }
  }

  RegisterNow() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Signup(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:
          // _isLoading
          //     ? Container(
          //         child: Center(child: CircularProgressIndicator()),
          //       )
          //     :
          SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Lottie.asset('assets/chat.json', width: 150.0, height: 250.0),
            Container(
              height: MediaQuery.of(context).size.height - 250,
              padding: EdgeInsets.symmetric(horizontal: 24),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Image.asset(
                    'assets/images/chat.png',
                    height: 70.0,
                    width: 70.0,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          validator: (val) {
                            return RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(val!)
                                ? null
                                : "Please provide Correct Email";
                          },
                          controller: EmailTexteditingController,
                          decoration: InputDecoration(
                              labelText: "Email",
                              border: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide:
                                    BorderSide(width: 50.0, color: Colors.red),
                              )),
                          // controller: _titleController,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          validator: (val) {
                            return val!.length > 6
                                ? null
                                : "Please provide Password above 6 character";
                          },
                          controller: PasswordTexteditingController,
                          decoration: InputDecoration(
                              labelText: "Password",
                              border: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide:
                                    BorderSide(width: 50.0, color: Colors.red),
                              )),
                          //controller: _amountController,
                        ),
                      ],
                    ),
                  ),
                  Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(vertical: 18),
                      child: Text(
                        'Forget your password?',
                        style: simpleTextFieldstyle(),
                      )),
                  SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        setState(() {
                          _isLoading = true;
                          email = EmailTexteditingController.text;
                          password = PasswordTexteditingController.text;
                        });
                        signIn();
                      }
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 13),
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(colors: [
                              Color(0xff0F52BA),
                              Color(0xff002366)
                            ])),
                        alignment: Alignment.center,
                        child: Text(
                          'Sign in',
                          style: simpleButtonstyle(),
                        )),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 13),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.blueAccent,
                        //  gradient: LinearGradient(colors:[Color(0xff0F52BA),
                        //   Color(0xff002366)])
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Sign in with google',
                        style: simpleButtonstyle(),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(
                      'Dont have an account?',
                      style: simpleTextFieldstyle(),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        RegisterNow();
                      },
                      child: Text(
                        'Register Now',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 17.0,
                        ),
                      ),
                    )
                  ]),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  TextStyle simpleTextFieldstyle() {
    return TextStyle(
      color: Colors.black,
      fontSize: 17,
    );
  }

  TextStyle simpleButtonstyle() {
    return TextStyle(
      color: Colors.white,
      fontSize: 16,
    );
  }
}
