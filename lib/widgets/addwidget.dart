import 'package:flutter/material.dart';


class AddWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: Colors.white)),
      width: MediaQuery.of(context).size.width * 0.08,
      height: MediaQuery.of(context).size.height * 0.04,
      margin: const EdgeInsets.all(8.0),
      child: Center(
        child: Icon(Icons.add,color: Colors.white,)
      ),
    );
  }
}
