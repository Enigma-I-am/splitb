import 'package:dot_tab_indicator/dot_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:splitb/providers.dart';
import 'package:splitb/utils/theme.dart';
import 'package:splitb/widgets/customtabbar.dart';
import 'package:splitb/widgets/group_friend_widget.dart';

class FriendGroupBottomSheetScreen extends StatefulWidget {
  final ScrollController scrollController;
  FriendGroupBottomSheetScreen({@required this.scrollController});

  @override
  _FriendGroupBottomSheetScreenState createState() =>
      _FriendGroupBottomSheetScreenState();
}

class _FriendGroupBottomSheetScreenState
    extends State<FriendGroupBottomSheetScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  List<Tab> _tabs = <Tab>[
    Tab(text: "friends"),
    Tab(text: "groups"),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _tabs.length);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(50),
        topRight: Radius.circular(50),
      ),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: CustomAppBar(
            addIcon: InkWell(
              onTap: () {
                homescreenVm
                    .read(context)
                    .navigateTocreateNewGroupOrFriendScreen();
              },
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: HexColor.fromHex("#050A30"),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    color: HexColor.fromHex("#050A30"),
                  ),
                ),
                child: Text(
                  "Add group / friend",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            child: TabBar(
              // labelPadding: EdgeInsets.only(left: 8, right: 8),
              // indicatorPadding:EdgeInsets.only(left: 16, right: 16) ,
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Colors.white,
              isScrollable: true,
              indicator: DotTabIndicator(
                indicatorColor: HexColor.fromHex("#050A30"),
                radius: kDefaultDotIndicatorRadius,
              ),
              indicatorWeight: kDefaultDotIndicatorRadius,
              // labelPadding: EdgeInsets.only(left: 10, right: 10),
              tabs: _tabs.map((label) => label).toList(),
              controller: _tabController,
            ),
            height: MediaQuery.of(context).size.height * 0.12,
          ),
          backgroundColor: Colors.green,
          body: Stack(
            children: <Widget>[
              TabBarView(controller: _tabController, children: <Widget>[
                GridView.count(
                  controller: widget.scrollController,
                  crossAxisCount: 3,
                  children: List.generate(
                      4,
                      (index) => GroupFriendWidget(
                            title: "Chisom $index",
                            navigateToDetails: () =>
                              homescreenVm.read(context).navigateToDebtDetail("Chisom $index")
                            ,
                          )),
                ),
                GridView.count(
                  controller: widget.scrollController,
                  crossAxisCount: 3,
                  children: List.generate(
                      4,
                      (index) => GroupFriendWidget(
                            title: "Flatmate $index",
                            navigateToDetails: ()=> homescreenVm.read(context).navigateToDebtDetail("Flatmate $index"),
                          )),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
