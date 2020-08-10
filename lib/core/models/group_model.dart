import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:splitb/core/models/group_friend_model.dart';

class GroupModel {
  List<FriendGroupModel> group;
  String userId;
  String groupName;
  int amountPerPerson;
  int totalAmount;
  final DocumentReference reference;

  GroupModel({
    @required this.group,
    @required this.userId,
    @required this.groupName,
    @required this.amountPerPerson,
    @required this.totalAmount,
    this.reference,
  });

  GroupModel.fromMap(Map<dynamic, dynamic> map, {this.reference})
      : group = [...map["group"].map((i) => FriendGroupModel.fromMap(i))],
        userId = map["userId"],
        groupName = map["groupName"],
        amountPerPerson = map["amountPerPerson"],
        totalAmount = map["totalAmount"];

  GroupModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data["group"] = group.map((i) => i.toJson()).toList();
    data["userId"] = userId;
    data["amountPerPerson"] = amountPerPerson;
    data["totalAmount"] = totalAmount;
    data["groupName"] = groupName;
    return data;
  }
}
