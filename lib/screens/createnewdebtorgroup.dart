import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:splitb/core/models/friendmodel.dart';
import 'package:splitb/core/models/group_friend_model.dart';
import 'package:splitb/providers.dart';
import 'package:splitb/utils/margin.dart';
import 'package:splitb/utils/theme.dart';
import 'package:splitb/widgets/addwidget.dart';
import 'package:splitb/widgets/avaterwidget.dart';

class CreateNewDebtorGroup extends StatefulWidget {
  @override
  _CreateNewDebtorGroupState createState() => _CreateNewDebtorGroupState();
}

class _CreateNewDebtorGroupState extends State<CreateNewDebtorGroup> {
  final _formKey = GlobalKey<FormState>();
  List<FriendGroupModel> friends = [];
  int _amount;
  String _name;
  @override
  Widget build(BuildContext context) {
    // final _viewmodel = useProvider(createDebtorGroupVm);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: HexColor.fromHex("#050A30"),
        title: Text("Debtor Group"),
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
                "assets/images/family.png",
                fit: BoxFit.contain,
                height: MediaQuery.of(context).size.height * 0.33,
                width: MediaQuery.of(context).size.width * 0.33,
              ),
              YMargin(10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    flex: 2,
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
                        labelText: "total amount spent",
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
                        if (value.isEmpty) {
                          return "please give group/activity a name";
                        }
                        return null;
                      },
                      onSaved: (input) => _name = input,
                      decoration: InputDecoration(
                        labelText: "group name",
                        // suffix: suffix,
                      ),
                    ),
                  ),
                ],
              ),
              YMargin(30),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    onTap: () async {
                      var model = await createDialog(context);
                      print(model.friendName);
                      friends.add(model);
                      print(friends.length);
                      setState(() {
                        
                      });
                      // await _viewmodel.addFriendToList(model);
                    },
                    child: AddWidget(),
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.19,
                child: friends.isNotEmpty
                    ? ListView.builder(
                        itemCount: friends.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          print(friends[index].friendName);
                          return AvaterWidget(title: friends[index].friendName);
                        },
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("click + to add a friend to the group",
                                style: TextStyle(color: Colors.white)),
                            YMargin(10),
                            Text("bill will be split equally",
                                style: TextStyle(color: Colors.white))
                          ],
                        ),
                      ),
              ),
              YMargin(20),
              Consumer((context, watch) {
                final viewmodel = watch(createDebtorGroupVm);
                return FlatButton(
                  color: Colors.green,
                  onPressed: () async {
                    var formState = _formKey.currentState;
                    if (formState.validate()) {
                      formState.save();

                      var amountOwedPrePerson = _amount / friends.length;
                      print(friends[0].friendName);
                      
                      await viewmodel.addGroup(
                          friends, _name, amountOwedPrePerson.toInt());
                    }
                  },
                  child: Text(
                    "Create",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  Future<FriendGroupModel> createDialog(BuildContext context) {
    final _dialogFormKey = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (context) {
          String _name, _phoneNumber;
          return ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 20.0),
            child: AlertDialog(
              backgroundColor: HexColor.fromHex("#050A30"),
              title: Text(
                "Add Friend",
                style: TextStyle(color: Colors.white),
              ),
              content: Form(
                key: _dialogFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "please tell us the name";
                        }
                        return null;
                      },
                      onSaved: (input) => _name = input,
                      decoration: InputDecoration(
                        labelText: "name",
                        // suffix: suffix,
                      ),
                    ),
                    TextFormField(
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
                  ],
                ),
              ),
              actions: <Widget>[
                MaterialButton(
                  onPressed: () {
                    var formState = _dialogFormKey.currentState;
                    if (formState.validate()) {
                      formState.save();
                      // addstuff.call();
                      // addstuff();
                      Navigator.pop(
                          context,
                          FriendGroupModel(
                              friendName: _name, phoneNumber: _phoneNumber));
                    }
                  },
                  elevation: 3.0,
                  child: Text("add"),
                )
              ],
            ),
          );
        });
  }
}
