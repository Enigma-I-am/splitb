import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:splitb/utils/imageclipper.dart';
import 'package:splitb/utils/margin.dart';
import 'package:splitb/utils/theme.dart';
import 'package:splitb/widgets/groups_friends_bottomsheet.dart';

import '../providers.dart';

class HomeScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _viewmodel = useProvider(homescreenVm);

    // ignore: missing_return
    useEffect(() {
      // _viewmodel.listenToExpenses();
      Future.microtask(() => _viewmodel.getUid());
    }, []);
    return Scaffold(
        backgroundColor: HexColor.fromHex("#050A30"),
        body: Stack(
          children: <Widget>[
            StreamBuilder(
                stream: _viewmodel.listenToExpenses(_viewmodel.currentUser()),
                builder: (context, snapshot) {
                  var theDocumanet = snapshot.data;
                  if (!snapshot.hasData) {
                    return ListView(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        )
                      ],
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ListView(
                        children: <Widget>[
                          YMargin(MediaQuery.of(context).size.height * 0.04),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "SplitB.",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.green,
                                    fontSize: 25),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  _viewmodel.navigateToProfileScreen();
                                },
                                child: Column(
                                  children: <Widget>[
                                    Hero(
                                      tag: "img",
                                      child: ClipOval(
                                        clipper: ImageClipper(),
                                        child: Image.asset(
                                          'assets/images/login.png',
                                          fit: BoxFit.cover,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                        ),
                                      ),
                                    ),
                                    YMargin(5),
                                    Text(
                                      "profile",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          YMargin(MediaQuery.of(context).size.height * 0.05),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Total Expense",
                                style: TextStyle(color: Colors.grey[300]),
                              ),
                              Text(
                                theDocumanet["totalExpense"].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 40),
                              ),
                            ],
                          ),
                          YMargin(MediaQuery.of(context).size.height * 0.06),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "You're owed",
                                    style: TextStyle(color: Colors.grey[300]),
                                  ),
                                  Text(
                                    theDocumanet["youROwed"].toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontSize: 20),
                                  )
                                ],
                              ),
                              Spacer(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "You owe",
                                    style: TextStyle(color: Colors.grey[300]),
                                  ),
                                  Text(
                                    "#3000",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontSize: 20),
                                  )
                                ],
                              ),
                              Spacer(),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                }),
            DraggableScrollableSheet(
              initialChildSize: 0.5,
              minChildSize: 0.5,
              maxChildSize: 0.825,
              builder: (BuildContext context, myscrollController) {
                return Container(
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(39),
                            topLeft: Radius.circular(39)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(.05),
                              spreadRadius: 5,
                              blurRadius: 15)
                        ]),
                    child: FriendGroupBottomSheetScreen(
                      scrollController: myscrollController,
                    ));
              },
            )
          ],
        ));
  }
}
