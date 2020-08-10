import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:splitb/core/models/usermodel.dart';
import 'package:splitb/providers.dart';
import 'package:splitb/utils/margin.dart';

class EditProfile extends HookWidget {
  final UserModel model;
  EditProfile({@required this.model});
  @override
  Widget build(BuildContext context) {
    String _firstName, _lastName;
    final _formKey = GlobalKey<FormState>();
    final _viewmodel = useProvider(profileVM);

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
                initialValue: model.firstName,
                style: TextStyle(color: Colors.white),
                validator: (value) {
                  if (value.isEmpty) {
                    return "please enter your first name";
                  }
                  return null;
                },
                onSaved: (input) => _firstName = input,
                decoration: InputDecoration(
                  labelText: "firstName",
                  // suffix: suffix,
                ),
              ),
              TextFormField(
                initialValue: model.lastName,
                style: TextStyle(color: Colors.white),
                validator: (value) {
                  if (value.isEmpty) {
                    return "please enter your last name";
                  }
                  return null;
                },
                onSaved: (input) => _lastName = input,
                decoration: InputDecoration(
                  labelText: "lastName",
                  // suffix: suffix,
                ),
              ),
              YMargin(30),
              FlatButton(
                onPressed: () {
                  var formState = _formKey.currentState;
                  if (formState.validate()) {
                    formState.save();
                    _viewmodel.updateUserDatails(_firstName, _lastName);
                  }
                },
                child: Text(
                  "Update",
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
