import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page/services/signinWithGoogle.dart';
//import 'package:login_page/services/Auth.dart';
import 'package:login_page/userMain.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_core/firebase_core.dart';

import 'login.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

//AuthMethod authMethods = new AuthMethod();
bool isLoading = false;
final Formkey = GlobalKey<FormState>();

class _SignupState extends State<Signup> {
  TextEditingController UsernameTexteditingController =
      new TextEditingController();
  TextEditingController EmailTexteditingController =
      new TextEditingController();
  TextEditingController PasswordTexteditingController =
      new TextEditingController();

  var email = "";
  var username = "";
  var password = "";

  registeration() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: EmailTexteditingController.text,
          password: PasswordTexteditingController.text);
      print(UserCredential);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.white60,
          content: Text('you have succesfully created your account',
              style: TextStyle(fontSize: 20.0, color: Colors.black)),
        ),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Column(
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
                          height: 25,
                        ),
                        Form(
                          key: Formkey,
                          child: Column(
                            children: [
                              TextFormField(
                                validator: (val) {
                                  return val!.isEmpty || val.length < 2
                                      ? "Please Enter the Usename"
                                      : null;
                                },
                                controller: UsernameTexteditingController,
                                decoration: InputDecoration(
                                    labelText: "Username",
                                    border: new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(
                                          width: 50.0, color: Colors.red),
                                    )),
                                // controller: _titleController,
                              ),
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
                                      borderSide: BorderSide(
                                          width: 50.0, color: Colors.red),
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
                                      borderSide: BorderSide(
                                          width: 50.0, color: Colors.red),
                                    )),
                                //controller: _amountController,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 45,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (Formkey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                                email = EmailTexteditingController.text;
                                password = PasswordTexteditingController.text;
                                username = UsernameTexteditingController.text;
                              });
                              registeration();
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
                                'Sign Up',
                                style: simpleButtonstyle(),
                              )),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        GestureDetector(
                          onTap: () {
                            AuthMethods().signInwithGoogle(context);
                          },
                          child: Container(
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
                                'Sign Up with google',
                                style: simpleButtonstyle(),
                              )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
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
}

TextStyle simpleButtonstyle() {
  return TextStyle(
    color: Colors.white,
    fontSize: 16,
  );
}
