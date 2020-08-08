import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:splitb/core/models/group_friend_model.dart';

class GroupModel {
  List<FriendGroupModel> group;
  String userId;
  String groupName;
  int amount;
  final DocumentReference reference;

  GroupModel(
      {@required this.group,
      @required this.userId,
      @required this.groupName,
      @required this.amount,
      this.reference});

  GroupModel.fromMap(Map<dynamic, dynamic> map, {this.reference})
      : group = map["group"],
        userId = map["userId"],
        groupName = map["groupName"],
        amount = map["amount"];

  GroupModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data["group"] = group.map((i) => i.toJson()).toList();
    data["userId"] = userId;
    data["amount"] = amount;
    data["groupName"] = groupName;
    return data;
  }
}
