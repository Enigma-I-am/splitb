import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:splitb/core/models/group_friend_model.dart';

import 'package:splitb/utils/imageclipper.dart';
import 'package:splitb/utils/margin.dart';

class DebtorItem extends HookWidget {
  final FriendGroupModel model;
  final String amountOwed;
  final String totalExpense;
  DebtorItem({@required this.model, @required this.amountOwed, @required this.totalExpense});
  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        height: 130,
        margin: EdgeInsets.all(16.0),
        padding: EdgeInsets.only(left: 16.0, right: 16),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipOval(
              clipper: ImageClipper(),
              child: Image.network(
                "https://pbs.twimg.com/profile_images/1257072406092546048/UG-tTGNJ_400x400.jpg",
                width: MediaQuery.of(context).size.width * 0.15,
                height: MediaQuery.of(context).size.height * 0.15,
                fit: BoxFit.contain,
              ),
            ),
            XMargin(MediaQuery.of(context).size.width * 0.03),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${model.friendName}",
                  style: TextStyle(
                      color: Colors.grey[50], fontWeight: FontWeight.w200),
                ),
                Text(
                  "#$amountOwed",
                  style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Spacer(),
            Text(
              "swipe left",
              style: TextStyle(color: Colors.green),
            ),
          ],
        ),
        // height: MediaQuery.of(context).size.height * 0.17,
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'remind',
          color: Colors.blue,
          icon: Icons.notification_important,
          // onTap: () => _showSnackBar('More'),
        ),
        IconSlideAction(
          caption: 'mark as paid',
          color: Colors.green,
          icon: Icons.check,
          // onTap: () => _showSnackBar('Delete'),
        ),
      ],
    );
  }
}
