import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:splitb/providers.dart';
import 'package:splitb/utils/imageclipper.dart';
import 'package:splitb/utils/margin.dart';
import 'package:splitb/utils/theme.dart';

class ProfileScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final vm = useProvider(profileVM);
    final store = useMemoized(() => vm);
    // ignore: missing_return
    useEffect(() {
      print("effect");
      Future.microtask(() => store.getUserDetails());
      // Future.microtask(() => store.listenToGroups());
    }, []);

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
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Spacer(),
                    Icon(Icons.portrait),
                    XMargin(10),
                    Text(
                      "Nwagba Okechukwu",
                      style: TextStyle(color: Colors.white),
                    ),
                    Spacer(),
                  ],
                ),
                YMargin(MediaQuery.of(context).size.height * 0.05),
                Row(
                  children: <Widget>[
                    Spacer(),
                    Icon(Icons.mail_outline),
                    XMargin(10),
                    Text(
                      "nwagba001@gmail.com",
                      style: TextStyle(color: Colors.white),
                    ),
                    Spacer(),
                  ],
                ),
                YMargin(MediaQuery.of(context).size.height * 0.05),
                Row(
                  children: <Widget>[
                    Spacer(),
                    Icon(Icons.phone),
                    XMargin(10),
                    Text(
                      "07056322074",
                      style: TextStyle(color: Colors.white),
                    ),
                    Spacer()
                  ],
                ),
                YMargin(MediaQuery.of(context).size.height * 0.05),
              ],
            ),
          ),
          YMargin(MediaQuery.of(context).size.height * 0.03),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: FlatButton(
              color: Colors.green,
              onPressed: () {
                vm.navigateToEditProfile(vm.user);
              },
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
