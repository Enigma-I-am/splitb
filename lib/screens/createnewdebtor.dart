import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:splitb/providers.dart';
import 'package:splitb/utils/margin.dart';
import 'package:splitb/utils/theme.dart';

// ignore: must_be_immutable
class CreateNewDebtor extends HookWidget {
  final _formKey = GlobalKey<FormState>();
  String _name, _phoneNumber;
  int _amount;
  @override
  Widget build(BuildContext context) {
    final _viewmodel = useProvider(createDebtorVm);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: HexColor.fromHex("#050A30"),
        title: Text("Debtor"),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
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
                  if (value.isEmpty) {
                    return "please enter a name";
                  }
                  return null;
                },
                onSaved: (input) => _name = input,
                decoration: InputDecoration(
                  labelText: "name",
                  // suffix: suffix,
                ),
              ),
              YMargin(10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "please tell us how much";
                        }
                        return null;
                      },
                      onSaved: (input) => _amount = int.parse(input),
                      decoration: InputDecoration(
                        labelText: "amount",
                        // suffix: suffix,
                      ),
                    ),
                  ),
                  XMargin(10),
                  Flexible(
                    flex: 3,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "please tell us phone number";
                        }
                        return null;
                      },
                      onSaved: (input) => _phoneNumber = input,
                      decoration: InputDecoration(
                        labelText: "phone No.",
                        // suffix: suffix,
                      ),
                    ),
                  ),
                ],
              ),
              YMargin(30),
              FlatButton(
                color: Colors.green,
                onPressed: () {
                  var formState = _formKey.currentState;
                  if (formState.validate()) {
                    formState.save();
                    _viewmodel.addFriend(
                        name: _name,
                        amountOwed: _amount,
                        phoneNumber: _phoneNumber);
                  }
                },
                child: Text(
                  "Create",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
