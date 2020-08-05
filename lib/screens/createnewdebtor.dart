import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:splitb/utils/margin.dart';
import 'package:splitb/utils/theme.dart';

class CreateNewDebtor extends HookWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: HexColor.fromHex("#050A30"),
        title: Text("Debtor"),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              YMargin(MediaQuery.of(context).size.height * 0.05),
              Image.asset(
                "assets/images/reciept.png",
                fit: BoxFit.contain,
                height: MediaQuery.of(context).size.height * 0.33,
                width: MediaQuery.of(context).size.width * 0.33,
              ),
              YMargin(10),
              TextFormField(
                style: TextStyle(color: Colors.white),
                validator: (value) {
                  if (!value.contains("@")) {
                    return "please enter a valid email";
                  }
                  return null;
                },
                // onSaved: (input) => email = input,
                decoration: InputDecoration(
                  labelText: "email",
                  // suffix: suffix,
                ),
              ),
              YMargin(10),
              TextFormField(
                style: TextStyle(color: Colors.white),
                validator: (value) {
                  if (!value.contains("@")) {
                    return "please enter a valid email";
                  }
                  return null;
                },
                // onSaved: (input) => email = input,
                decoration: InputDecoration(
                  labelText: "email",
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
                // onSaved: (input) => email = input,
                decoration: InputDecoration(
                  labelText: "email",
                  // suffix: suffix,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
