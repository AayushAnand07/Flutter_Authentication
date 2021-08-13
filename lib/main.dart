import 'package:flutter/material.dart';
import 'package:login_page/signup.dart';
import 'package:firebase_core/firebase_core.dart';

import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          // Check for Errors
          if (snapshot.hasError) {
            print("Something Went Wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return MaterialApp(
            title: 'Flutter Firebase EMail Password Auth',
            theme: ThemeData(
              scaffoldBackgroundColor: Color(0xff002366),
            ),
            debugShowCheckedModeBanner: false,
            home: LoginPage(),
          );
          // return MaterialApp(
          //   title: 'Flutter Demo',
          //   theme: ThemeData(
          //     // This is the theme of your application.
          //     //
          //     // Try running your application with "flutter run". You'll see the
          //     // application has a blue toolbar. Then, without quitting the app, try
          //     // changing the primarySwatch below to Colors.green and then invoke
          //     // "hot reload" (press "r" in the console where you ran "flutter run",
          //     // or simply save your changes to "hot reload" in a Flutter IDE).
          //     // Notice that the counter didn't reset back to zero; the application
          //     // is not restarted.

          //     scaffoldBackgroundColor: Color(0xff002366),

          //     // primarySwatch: Colors.blue,
          //   ),
          //   debugShowCheckedModeBanner: false,
          //   home: ,
        });
  }
}
