import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ExpenseModel {
  int totalExpense;
  int youROwed;
  String uid;

  final DocumentReference reference;

  ExpenseModel({
    @required this.totalExpense,
    @required this.youROwed,
     this.uid,
    this.reference,
  });

  ExpenseModel.fromMap(Map<dynamic, dynamic> map, {this.reference})
      : totalExpense = map["totalExpense"],
        youROwed = map["youROwed"],
        uid = map["uid"];

  ExpenseModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["totalExpense"] = totalExpense;
    data["youROwed"] = youROwed;
    data["uid"] = uid;
    return data;
  }
}
