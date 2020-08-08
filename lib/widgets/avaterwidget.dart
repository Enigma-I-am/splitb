import 'package:flutter/material.dart';
import 'package:splitb/utils/margin.dart';


class AvaterWidget extends StatelessWidget {
  final String title;
  AvaterWidget({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      margin: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        borderOnForeground: true,
        child: Center(
          child: Column(
            children: <Widget>[
              Image.asset("assets/images/femaleavatar.png"),
              YMargin(5),
              Text(title,style: TextStyle(color: Colors.black),)
            ],
          )
        ),
      ),
    );
  }
}
