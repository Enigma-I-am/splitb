import 'package:dot_tab_indicator/dot_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:splitb/constants.dart';
import 'package:splitb/providers.dart';
import 'package:splitb/utils/theme.dart';
import 'package:splitb/widgets/addwidget.dart';
import 'package:splitb/widgets/customtabbar.dart';
import 'package:splitb/widgets/group_friend_widget.dart';

class FriendGroupBottomSheetScreen extends HookWidget {
  final ScrollController scrollController;
  FriendGroupBottomSheetScreen({@required this.scrollController});

  final List<Tab> _tabs = <Tab>[
    // Tab(text: "friends"),
    Tab(text: "groups / activities"),
  ];

  // List<String> groupNames = ["Hike", "Travel", "Project", "Dinner"];

  @override
  Widget build(BuildContext context) {
    final _tabController = useTabController(initialLength: 1);
    final orientation = MediaQuery.of(context).orientation;
    final vm = useProvider(bottomSheetVM);

    final store = useMemoized(() => vm);
    // ignore: missing_return
    useEffect(() {
      print("effect");
      Future.microtask(() => store.listenTofriends());
      Future.microtask(() => store.listenToGroups());
    }, []);

    return Material(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(50),
        topRight: Radius.circular(50),
      ),
      child: DefaultTabController(
        length: 1,
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
                // GridView.builder(
                //         controller: scrollController,
                //         itemCount: (vm.friends.length + 1),
                //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //             crossAxisCount:
                //                 (orientation == Orientation.portrait) ? 3 : 3),
                //         itemBuilder: (context, index) {
                //           if (index == vm.friends.length) {
                //             return InkWell(
                //                 onTap: () {
                //                   homescreenVm
                //                       .read(context)
                //                       .navigateTocreateNewGroupOrFriendScreen(
                //                           CREATENEWDEBTORSCREEN);
                //                 },
                //                 child: Padding(
                //                   padding: const EdgeInsets.all(16.0),
                //                   child: AddWidget(),
                //                 ));
                //           }
                //           return GroupFriendWidget(
                //             title: vm.friends[index].friendName,
                //             navigateToDetails: () => homescreenVm
                //                 .read(context)
                //                 .navigateToFriendDebtDetail(
                //                     vm.friends[index]),
                //           );
                //         }),
                GridView.builder(
                    controller: scrollController,
                    itemCount: (vm.groups.length + 1),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            (orientation == Orientation.portrait) ? 3 : 3),
                    itemBuilder: (context, index) {
                      if (index == vm.groups.length) {
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
                        title: vm.groups[index].groupName,
                        navigateToDetails: () => homescreenVm
                            .read(context)
                            .navigateToGroupDebtDetail(vm.groups[index]),
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

