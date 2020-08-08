import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FriendModel {
  String friendName;
  String phoneNumber;
  int amountOwed;
  String userId;
  final DocumentReference reference;

  FriendModel({
    @required this.friendName,
    @required this.phoneNumber,
    this.amountOwed,
    this.userId,
    this.reference,
  });

  FriendModel.fromMap(Map<dynamic, dynamic> map, {this.reference})
      : friendName = map["friendName"],
        amountOwed = map["amountOwed"],
        phoneNumber = map["phhoneNumber"],
        userId = map["userId"];

  FriendModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["friendName"] = friendName;
    data["amountOwed"] = amountOwed;
    data["phoneNumber"] = phoneNumber;
    data["userId"] = userId;
    return data;
  }
}
