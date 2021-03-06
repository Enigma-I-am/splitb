import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:splitb/providers.dart';
import 'package:splitb/utils/margin.dart';

// ignore: must_be_immutable
class SignUpScreen extends HookWidget {
  static final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String email, password, confirmPassword, _firstName, _lastName, _phoneNumber;
    
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
              YMargin(MediaQuery.of(context).size.height * 0.05),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Create an account now and start",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                  Text(
                    "tracking your debtors",
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
                  if (value.isEmpty) {
                    return "please enter your first name";
                  }
                  return null;
                },
                onSaved: (input) => _firstName = input,
                decoration: InputDecoration(
                  labelText: "firstname",
                  // suffix: suffix,
                ),
              ),
              TextFormField(
                style: TextStyle(color: Colors.white),
                validator: (value) {
                  if (value.isEmpty) {
                    return "please enter your last name";
                  }
                  return null;
                },
                onSaved: (input) => _lastName = input,
                decoration: InputDecoration(
                  labelText: "lastname",
                  // suffix: suffix,
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white),
                validator: (value) {
                  if (value.isEmpty) {
                    return "please enter your phone number";
                  }
                  return null;
                },
                onSaved: (input) => _phoneNumber = input,
                decoration: InputDecoration(
                  labelText: "phone number",
                  // suffix: suffix,
                ),
              ),
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
              YMargin(10),
              TextFormField(
                style: TextStyle(color: Colors.white),
                validator: (value) {
                  if (value.isEmpty || value.length < 6) {
                    return "Please enter a valid password";
                  }
                  return null;
                },
                onSaved: (input) => confirmPassword = input,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "confirm password",
                ),
              ),
              YMargin(30),
             _viewmodel.busy == true?SpinKitPulse(color: Colors.green,): FlatButton(
                onPressed: () async{
                  var formState = _formKey.currentState;
                  if (formState.validate()) {
                    final snackBar =
                        SnackBar(content: Text('Incorrect password!'));
                    formState.save();
                    if (password == confirmPassword) {
                      await _viewmodel.createUser(email: email, password: password,firstname: _firstName,lastname: _lastName,phoneNumber:_phoneNumber);
                    } else {
                      Scaffold.of(context).showSnackBar(snackBar);
                    }
                  }
                },
                child: Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.green,
              ),
              YMargin(20),
              InkWell(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "Already have an account? ",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        Text(
                          "Log in",
                          style: TextStyle(color: Colors.blue, fontSize: 15),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
