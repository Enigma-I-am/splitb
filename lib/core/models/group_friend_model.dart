import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FriendGroupModel {
  String friendName;
  String phoneNumber;
  final DocumentReference reference;
  FriendGroupModel({
    @required this.friendName,
    @required this.phoneNumber,
    this.reference,
  });

  FriendGroupModel.fromMap(Map<dynamic, dynamic> map, {this.reference})
      : friendName = map["friendName"],
        phoneNumber = map["phhoneNumber"];

  FriendGroupModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["friendName"] = friendName;
    data["phoneNumber"] = phoneNumber;
    return data;
  }
}
