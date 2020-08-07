import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:splitb/utils/margin.dart';
import 'package:splitb/utils/theme.dart';
import 'package:splitb/widgets/addwidget.dart';
import 'package:splitb/widgets/avaterwidget.dart';

class CreateNewDebtor extends HookWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
                  if (!value.contains("@")) {
                    return "please enter a valid email";
                  }
                  return null;
                },
                // onSaved: (input) => email = input,
                decoration: InputDecoration(
                  labelText: "friend/group name",
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
                      initialValue: 2.toString(),
                      style: TextStyle(color: Colors.white),
                      validator: (value) {
                        if (!value.contains("@")) {
                          return "please enter a valid email";
                        }
                        return null;
                      },
                      // onSaved: (input) => email = input,
                      decoration: InputDecoration(
                        labelText: "split No.",
                        // suffix: suffix,
                      ),
                    ),
                  ),
                  XMargin(10),
                  Flexible(
                    flex: 3,
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      validator: (value) {
                        if (!value.contains("@")) {
                          return "please enter a valid email";
                        }
                        return null;
                      },
                      // onSaved: (input) => email = input,
                      decoration: InputDecoration(
                        labelText: "amount",
                        // suffix: suffix,
                      ),
                    ),
                  ),
                ],
              ),
              YMargin(30),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  AddWidget(),
                ],
              ),
              
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                      4,
                      (index) => AvaterWidget(
                            title: "",
                          )),
                ),
              ),
              YMargin(20),
              FlatButton(
                color: Colors.green,
                onPressed: () {},
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
