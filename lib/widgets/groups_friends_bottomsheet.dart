import 'package:dot_tab_indicator/dot_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:splitb/constants.dart';
import 'package:splitb/providers.dart';
import 'package:splitb/utils/theme.dart';
import 'package:splitb/widgets/addwidget.dart';
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

  List<String> names = ["Chisom", "Odera", "Mum", "KeKe"];
  List<String> groupNames = ["Hike", "Travel", "Project", "Dinner"];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _tabs.length);
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
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
            height: MediaQuery.of(context).size.height * 0.15,
          ),
          backgroundColor: Colors.green,
          body: Stack(
            children: <Widget>[
              TabBarView(controller: _tabController, children: <Widget>[
                GridView.builder(
                  controller: widget.scrollController,
                    itemCount: names.length + 1,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            (orientation == Orientation.portrait) ? 3 : 3),
                    itemBuilder: (context, index) {
                      if (index == names.length) {
                        return InkWell(
                            onTap: () {
                              homescreenVm
                                  .read(context)
                                  .navigateTocreateNewGroupOrFriendScreen(
                                      CREATENEWDEBTORSCREEN);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: AddWidget(),
                            ));
                      }
                      return GroupFriendWidget(
                        title: names[index],
                        navigateToDetails: () => homescreenVm
                            .read(context)
                            .navigateToDebtDetail(names[index]),
                      );
                    }),
                GridView.builder(
                  controller: widget.scrollController,
                    itemCount: groupNames.length + 1,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            (orientation == Orientation.portrait) ? 3 : 3),
                    itemBuilder: (context, index) {
                      if (index == groupNames.length) {
                        return InkWell(
                            onTap: () {
                              homescreenVm
                                  .read(context)
                                  .navigateTocreateNewGroupOrFriendScreen(
                                      CREATENEWDEBTORGROUPSCREEN);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: AddWidget(),
                            ));
                      }
                      return GroupFriendWidget(
                        title: groupNames[index],
                        navigateToDetails: () => homescreenVm
                            .read(context)
                            .navigateToDebtDetail(groupNames[index]),
                      );
                    }),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
