import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splitb/screens/homescreen.dart';
import 'package:splitb/screens/onboarding_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseUser>(
        future: FirebaseAuth.instance.currentUser(),
        builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
          if (snapshot.hasData) {
            FirebaseUser user = snapshot.data;
            print(user.uid);
            saveUid(user.uid);
            // authService.readOwner(this).
            return HomeScreen();
          }
          return Onboarding();
        });
  }

  Future saveUid(String uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', uid);
  }
}
