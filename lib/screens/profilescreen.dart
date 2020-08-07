import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:splitb/utils/imageclipper.dart';
import 'package:splitb/utils/margin.dart';
import 'package:splitb/utils/theme.dart';

class ProfileScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: HexColor.fromHex("#050A30"),
        title: Text("Profile"),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: <Widget>[
          YMargin(MediaQuery.of(context).size.height * 0.05),
          Hero(
            tag: "img",
            child: ClipOval(
              clipper: ImageClipper(),
              child: Image.network(
                "https://pbs.twimg.com/profile_images/1257072406092546048/UG-tTGNJ_400x400.jpg",
                width: MediaQuery.of(context).size.width * 0.27,
                height: MediaQuery.of(context).size.height * 0.27,
                fit: BoxFit.contain,
              ),
            ),
          ),
          YMargin(MediaQuery.of(context).size.height * 0.05),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:16.0),
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
              
                height: MediaQuery.of(context).size.height * 0.35,
                width: MediaQuery.of(context).size.width ,
              ),
            ),
          ),
          YMargin(MediaQuery.of(context).size.height * 0.03),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: FlatButton(
              color: Colors.green,
              onPressed: () {},
              child: Text(
                "Update",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
