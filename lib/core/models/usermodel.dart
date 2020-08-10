import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModel {
  String id;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  final DocumentReference reference;

  UserModel({
    @required this.id,
     this.email,
    @required this.firstName,
    @required this.lastName,
    this.phoneNumber,
    this.reference,
  });

  // fromMap Map<dynamic, dynamic> map, {this.reference}
  UserModel.fromMap(Map<dynamic, dynamic> map, {this.reference})
      : id = map["id"],
        firstName = map["firstName"],
        lastName = map["lastName"],
        email = map["email"],
        phoneNumber = map["phoneNumber"];

  // fromSnapshot DocumentSnapshot snapshot
  UserModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  // Map<String, dynamic> toJson()
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["firstName"] = firstName;
    data["lastName"] = lastName;
    data["email"] = email;
    data["phoneNumber"] = phoneNumber;
    return data;
  }
}
