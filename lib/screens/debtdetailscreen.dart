import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:splitb/utils/margin.dart';
import 'package:splitb/utils/theme.dart';
import 'package:splitb/widgets/debtoritem.dart';

class DebtDetailScreen extends HookWidget {
  final String title;
  DebtDetailScreen({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Persistent AppBar that never scrolls
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0.0,
        backgroundColor: HexColor.fromHex("#050A30"),
      ),
      body: NestedScrollView(
        // allows you to build a list of elements that would be scrolled away till the body reached the top
        headerSliverBuilder: (context, _) {
          return [
            SliverList(
              delegate: SliverChildListDelegate([
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    YMargin(40),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Total Expense",
                            style: TextStyle(
                                color: Colors.grey[300], fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "\$1274",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: 60),
                          ),
                        ],
                      ),
                    ),
                    YMargin(20),
                    CircularPercentIndicator(
                      radius: 200.0,
                      lineWidth: 15.0,
                      percent: 0.4,animation: true,
                      center: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("paid",style: TextStyle(color: Colors.white),),
                                Text(
                                  "\$2000",
                                  style: TextStyle(color: Colors.white,fontSize: 25),
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
                                Text("\$800",
                                    style: TextStyle(color: Colors.red,fontSize: 25),),
                                    Text("left",style: TextStyle(color: Colors.red),)
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
                  ],
                )
              ]),
            ),
          ];
        },
        // You tab view goes here
        body: Column(
          children: <Widget>[
            Expanded(
                child: ListView(
              // padding: EdgeInsets.zero,
              children: Colors.primaries.map((color) {
                return DebtorItem();
              }).toList(),
            )),
          ],
        ),
      ),
    );
  }
}
