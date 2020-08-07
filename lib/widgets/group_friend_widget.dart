import 'package:flutter/material.dart';
import 'package:splitb/utils/theme.dart';

class GroupFriendWidget extends StatelessWidget {
  final String title;
  final Function() navigateToDetails;
  GroupFriendWidget({@required this.title,@required this.navigateToDetails});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: Colors.green)),
      width: MediaQuery.of(context).size.width * 0.2,
      height: MediaQuery.of(context).size.height * 0.2,
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: navigateToDetails,
              child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          borderOnForeground: true,
          child: Center(
              child: Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.w600, color: HexColor.fromHex("#050A30"),fontSize: 12),
          )),
        ),
      ),
    );
  }
}
