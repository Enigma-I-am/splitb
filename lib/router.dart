import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splitb/screens/homescreen.dart';
import 'package:splitb/screens/loginscreen.dart';
import 'package:splitb/screens/startupscreen.dart';
import 'package:splitb/screens/onboarding_screen.dart';
import 'package:splitb/screens/signupscreen.dart';
import 'package:splitb/screens/splashscreens.dart';
import 'constants.dart';


Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SPLASHSCREEN:
      return MaterialPageRoute(builder: (context) => (SplashScreen()));
    case LOGINSCREEN:
      return MaterialPageRoute(builder: (context) => (LoginScreen()));
    case GETSTARTEDSCREEN:
      return MaterialPageRoute(builder: (context) => (GetStartedScreen()));
    case SIGNUPSCREEN:
      return MaterialPageRoute(builder: (context) => SignUpScreen());
    case HOMESCREEN:
      return MaterialPageRoute(builder: (context) => HomeScreen());
    case ONBOARDINGSCREEN:
      return MaterialPageRoute(builder: (context) => Onboarding());

    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No path for ${settings.name}'),
          ),
        ),
      );
  }
}