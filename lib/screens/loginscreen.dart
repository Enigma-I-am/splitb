import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:splitb/providers.dart';
import 'package:splitb/utils/margin.dart';

// ignore: must_be_immutable
class LoginScreen extends HookWidget {
  String password, email;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _viewmodel = useProvider(startVm);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: ListView(
            children: <Widget>[
              YMargin(130),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Log in and continue keeping",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                  Text(
                    "track of your debtors",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                ],
              ),
              YMargin(20),
              TextFormField(
                style: TextStyle(color: Colors.white),
                validator: (value) {
                  if (!value.contains("@")) {
                    return "please enter a valid email";
                  }
                  return null;
                },
                onSaved: (input) => email = input,
                decoration: InputDecoration(
                  labelText: "email",
                  // suffix: suffix,
                ),
              ),
              YMargin(10),
              TextFormField(
                style: TextStyle(color: Colors.white),
                validator: (value) {
                  if (value.isEmpty || value.length < 6) {
                    return "Please enter a valid password";
                  }
                  return null;
                },
                onSaved: (input) => password = input,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "password",
                ),
              ),
              YMargin(30),
             _viewmodel.busy == true? SpinKitPulse(color: Colors.green,): FlatButton(
                onPressed: () {
                  var formState = _formKey.currentState;
                  if (formState.validate()) {
                    // final snackBar =
                    //     SnackBar(content: Text('Incorrect password!'));
                    formState.save();
                    
                     _viewmodel.logUserIn(email: email, password: password);
               
                      // Scaffold.of(context).showSnackBar(snackBar);
            
                  }
                },
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.green,
              ),
              YMargin(20),

            ],
          ),
        ),
      ),
    );
  }
}
