
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:splitb/providers.dart';

import 'package:splitb/utils/theme.dart';

class SplashScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var _viewmodel = useProvider(splashVM);

    // ignore: missing_return
    useEffect(() {
      // _viewmodel.listenToExpenses();
      Future.microtask(() => _viewmodel.handleStartUpLogic());
    }, []);

    return Scaffold(
      backgroundColor: HexColor.fromHex("#050A30"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SplitB",
              style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w800,
                  fontSize: 70),

            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:40.0, vertical: 8.0),
              child: LinearProgressIndicator(backgroundColor: Colors.green,),
            ),
          ],
        ),
      ),
    );

    // return FutureBuilder<FirebaseUser>(
    //     future: FirebaseAuth.instance.currentUser(),
    //     builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
    //       if (snapshot.hasData) {
    //         FirebaseUser user = snapshot.data;
    //         print(user.uid);
    //         saveUid(user.uid);
    //         // authService.readOwner(this).
    //         return HomeScreen();
    //       }
    //       return Onboarding();
    //     });
  }
}
