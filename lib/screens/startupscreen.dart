import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:splitb/constants.dart';
import 'package:splitb/providers.dart';
import 'package:splitb/utils/margin.dart';

class GetStartedScreen extends HookWidget {
  
  @override
  Widget build(BuildContext context) {
    final _viewmodel = useProvider(startVm);
    return Scaffold(
        backgroundColor: Colors.blue,
        body: ListView(
          children: <Widget>[
            YMargin(150),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Let's get started!",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                      color: Colors.white),
                ),
              ],
            ),
            Image.asset(
              'assets/images/login.png',
              fit: BoxFit.cover,
            ),
            YMargin(40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: FlatButton(
                onPressed: ()=> _viewmodel.navigateToDestination(SIGNUPSCREEN),
                color: Colors.green,
                child: Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            YMargin(20),
            InkWell(
              onTap: ()=>_viewmodel.navigateToDestination(LOGINSCREEN),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Already have an account? Log in",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
