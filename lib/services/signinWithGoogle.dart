import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_page/helperFunctions/sharedPreference%20Helper.dart';

import '../userMain.dart';
import 'Database.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;
  getCurrentUser() async {
    return await auth.currentUser;
  }

  signInwithGoogle(BuildContext context) async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? _googleSignInAccount =
        await _googleSignIn.signIn();

    final GoogleSignInAuthentication googleSignInAuthentication =
        await _googleSignInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    UserCredential result =
        await _firebaseAuth.signInWithCredential(credential);
    User? userdetails = result.user;

    if (result != null) {
      SharedPreferenceHelper().saveUserEmail(userdetails!.email);
      SharedPreferenceHelper().saveUserId(userdetails.uid);
      SharedPreferenceHelper().saveDisplayName(userdetails.displayName);
      SharedPreferenceHelper().saveUserProfileUrl(userdetails.photoURL);
      Map<String, dynamic> userInfoMap = {
        "email": userdetails.email,
        "username": userdetails.email!.replaceAll("@gmail.com", ""),
        "name": userdetails.displayName,
        "imageUrl": userdetails.photoURL,
      };

      DatabaseMethod()
          .addUserInfoToDB(userdetails.uid, userInfoMap)
          .then((value) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => userMain()));
      });
    }
  }
}
