import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splitb/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstTime = prefs.getBool('first_time');
    if (firstTime != null && !firstTime) {
      // Not first time
      Navigator.of(context).pushReplacementNamed(GETSTARTEDSCREEN);
    } else {
      // First time
      prefs.setBool('first_time', false);
      Navigator.of(context).pushReplacementNamed(ONBOARDINGSCREEN);
    }
  }

  @override
  void initState() {
    startTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: Text(" "),);
  }
}
