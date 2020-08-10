import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:splitb/core/models/friendmodel.dart';
import 'package:splitb/utils/margin.dart';
import 'package:splitb/utils/theme.dart';
import 'package:intent/intent.dart' as android_intent;
import 'package:intent/extra.dart' as android_extra;
import 'package:intent/typedExtra.dart' as android_typedExtra;
import 'package:intent/action.dart' as android_action;

class FriendDebtDetailScreen extends HookWidget {
  final FriendModel model;
  FriendDebtDetailScreen({@required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Persistent AppBar that never scrolls
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          model.friendName,
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0.0,
        backgroundColor: HexColor.fromHex("#050A30"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            YMargin(40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Total Expense",
                        style: TextStyle(color: Colors.grey[300], fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "#${model.amountOwed}",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 60),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            YMargin(20),
            CircularPercentIndicator(
              radius: 300.0,
              lineWidth: 20.0,
              percent: 0.4,
              animation: true,
              center: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "paid",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "\$2000",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ],
                    ),
                    YMargin(5),
                    Divider(
                      color: Colors.grey[700],
                      height: 20,
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    YMargin(5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "\$800",
                          style: TextStyle(color: Colors.red, fontSize: 25),
                        ),
                        Text(
                          "left",
                          style: TextStyle(color: Colors.red),
                        )
                      ],
                    )
                  ]),
              progressColor: Colors.green,
              animateFromLastPercent: true,
              backgroundColor: Colors.grey[600],
              animationDuration: 1200,
              circularStrokeCap: CircularStrokeCap.round,
            ),
            YMargin(40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Ink(
                      color: Colors.green,
                      child: InkWell(
                        splashColor: Colors.grey,
                        onTap: () {
                          android_intent.Intent()
                            ..setAction(android_action.Action.ACTION_SEND)
                            ..setType('text/plain')
                            ..putExtra(android_extra.Extra.EXTRA_TEXT,
                                'Hey ${model.friendName}, I am send this text to remind you of that ${model.amountOwed} you owe me ')
                            ..startActivity().catchError((e) => print(e));
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.add_alert),
                                XMargin(5),
                                Text(
                                  "remind",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Ink(
                      color: Colors.blue,
                      child: InkWell(
                        splashColor: Colors.grey,
                        onTap: () {},
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.check),
                                XMargin(5),
                                Text(
                                  "paid",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
