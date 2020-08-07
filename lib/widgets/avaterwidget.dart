import 'package:flutter/material.dart';


class AvaterWidget extends StatelessWidget {
  final String title;
  AvaterWidget({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      height: MediaQuery.of(context).size.height * 0.2,
      margin: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        borderOnForeground: true,
        child: Center(
          child: Image.asset("assets/images/femaleavatar.png")
        ),
      ),
    );
  }
}
