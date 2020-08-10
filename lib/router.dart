import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splitb/core/models/friendmodel.dart';
import 'package:splitb/core/models/group_model.dart';
import 'package:splitb/core/models/usermodel.dart';
import 'package:splitb/screens/createnewdebtor.dart';
import 'package:splitb/screens/createnewdebtorgroup.dart';
import 'package:splitb/screens/editprofile.dart';
import 'package:splitb/screens/groupdebtdetailscreen.dart';
import 'package:splitb/screens/frienddebtdetailscreen.dart';
import 'package:splitb/screens/homescreen.dart';
import 'package:splitb/screens/loginscreen.dart';
import 'package:splitb/screens/profilescreen.dart';
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
    case PROFILESCREEN:
      return MaterialPageRoute(builder: (context) => ProfileScreen());
    case CREATENEWDEBTORSCREEN:
      return MaterialPageRoute(builder: (context) => CreateNewDebtor());
    case CREATENEWDEBTORGROUPSCREEN:
      return MaterialPageRoute(builder: (context) => CreateNewDebtorGroup());
    case FRIENDDEBTDETAILSCREEN:
      var friendModel = settings.arguments as FriendModel;
      return MaterialPageRoute(
          builder: (context) => FriendDebtDetailScreen(
                model: friendModel,
              ));
    case GROUPDEBTDETAILSCREEN:
      var title = settings.arguments as GroupModel;
      return MaterialPageRoute(
          builder: (context) => GroupDebtDetailScreen(
                model: title,
              ));

    case EDITPROFILESCREEN:
      var profileModel = settings.arguments as UserModel;
      return MaterialPageRoute(
          builder: (context) => EditProfile(
                model: profileModel,
              ));
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
