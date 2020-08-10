import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splitb/core/models/expensemodel.dart';
import 'package:splitb/core/models/friendmodel.dart';
import 'package:splitb/core/models/group_model.dart';
import 'package:splitb/core/models/usermodel.dart';

class FirestoreServcie {
  final Firestore _db = Firestore.instance;
  CollectionReference _ref;

  final StreamController<List<GroupModel>> _groupsController =
      StreamController<List<GroupModel>>.broadcast();

  final StreamController<List<FriendModel>> _friendsController =
      StreamController<List<FriendModel>>.broadcast();

  final StreamController<ExpenseModel> _expenseController =
      StreamController<ExpenseModel>();

  Stream<ExpenseModel> get expenseStats => _expenseController.stream;

  // final StreamController<ExpenseModel> _expenseController =
  //     StreamController<ExpenseModel>.broadcast();

  void getExpenseRealtime(String uid) {
    _db
        .collection("Expense")
        .document(uid)
        .snapshots()
        .listen(_expensesUpdated);
    // Return the stream underlying our _postsController.
    // return _friendsController.stream;
  }

  void _expensesUpdated(DocumentSnapshot snapshot) {
    print("${snapshot.data.keys}, ${snapshot.data.values}");
    _expenseController.add(ExpenseModel.fromSnapshot(snapshot));
  }

  Future addUserToUserCollection(String path, String uid, String email,
      String firstname, String lastname, String phoneNumber) async {
    try {
      _ref = _db.collection(path);
      await _ref.document(uid).setData(UserModel(
              id: uid,
              email: email,
              firstName: firstname,
              lastName: lastname,
              phoneNumber: phoneNumber)
          .toJson());

      await createExpenseCollection(uid);
    } catch (e) {
      print(e.toString());
    }
  }

  Future updateUserInUserCollection({
    @required String path,
    @required String uid,
    @required String firstname,
    @required String lastname,
  }) async {
    try {
      _ref = _db.collection(path);
      await _ref.document(uid).updateData(
          UserModel(id: uid, firstName: firstname, lastName: lastname)
              .toJson());
    } catch (e) {
      print(e.toString());
    }
  }

  // Future updateUserProfile(String id) {}
  Future<UserModel> getUser(String uid) async {
    try {
      _ref = _db.collection("Users");
      var userData = await _ref.document(uid).get();
      return UserModel.fromMap(userData.data);
    } catch (e) {
      print(e.toString());
      return e;
    }
  }

  Future addFriend(FriendModel model) async {
    try {
      _ref = _db.collection("Friends");
      await _ref.add(model.toJson());
    } catch (e) {
      print(e.toString());
    }
  }

  Future addGroup(GroupModel groupModel) async {
    try {
      _ref = _db.collection("Groups");
      getExpenseRealtime(groupModel.userId);
      await _ref.add(groupModel.toJson());
    } catch (e) {
      print(e.toString());
      print(e.toString());
    }
  }

  Future getGroupsOnceOff() async {
    try {
      var groupDocumentSnapshot = await _db.collection("Groups").getDocuments();
      if (groupDocumentSnapshot.documents.isNotEmpty) {
        return groupDocumentSnapshot.documents
            .map((snapshot) => GroupModel.fromMap(snapshot.data,
                reference: snapshot.reference))
            .where((mappedItem) => mappedItem.groupName != null)
            .toList();
      }
    } catch (e) {
      if (e is PlatformException) {
        print(e.message);
      }

      print(e.toString());
    }
  }

  Stream listenToGroupsRealTime(String uid) {
    // Register the handler for when the posts data changes
    _db.collection("Groups").snapshots().listen((postsSnapshot) {
      if (postsSnapshot.documents.isNotEmpty) {
        var posts = postsSnapshot.documents
            .map((snapshot) => GroupModel.fromMap(snapshot.data))
            .where((mappedItem) => mappedItem.userId == uid)
            .toList();

        // Add the posts onto the controller
        _groupsController.add(posts);
      }
    });

    // Return the stream underlying our _postsController.
    return _groupsController.stream;
  }

  Stream listenToFriendsRealTime(String uid) {
    // Register the handler for when the posts data changes
    _db.collection("Friends").snapshots().listen((postsSnapshot) {
      if (postsSnapshot.documents.isNotEmpty) {
        var posts = postsSnapshot.documents
            .map((snapshot) => FriendModel.fromMap(snapshot.data))
            .where((mappedItem) => mappedItem.userId == uid)
            .toList();

        // Add the posts onto the controller
        _friendsController.add(posts);
      }
    });

    // Return the stream underlying our _postsController.
    return _friendsController.stream;
  }

  Future getFriendsOnceOff() async {
    try {
      var groupDocumentSnapshot =
          await _db.collection("Friends").getDocuments();
      if (groupDocumentSnapshot.documents.isNotEmpty) {
        return groupDocumentSnapshot.documents
            .map((snapshot) => FriendModel.fromMap(snapshot.data,
                reference: snapshot.reference))
            .where((mappedItem) => mappedItem.friendName != null)
            .toList();
      }
    } catch (e) {
      if (e is PlatformException) {
        print(e.message);
      }

      print(e.toString());
    }
  }

  Future<ExpenseModel> getExpense() async {
    var uid = await getUid();
    print(uid);
    ExpenseModel model =
        await _db.collection("Expense").document(uid).get().then((value) {
      return ExpenseModel.fromMap(value.data);
    });

    return model;
  }

  Future createExpenseCollection(String uid) async {
    await _db
        .collection("Users")
        .document(uid)
        .collection("Expense")
        .document("Userexpense")
        .setData(ExpenseModel(totalExpense: 0, youROwed: 0).toJson());
  }

  Future postExpense(ExpenseModel model) async {
    var uid = await getUid();
    _db.runTransaction((transaction) async {
      DocumentSnapshot freshSnapshot = await transaction.get(_db
          .collection("Users")
          .document(uid)
          .collection("Expense")
          .document("Userexpense"));
      await transaction.update(freshSnapshot.reference, {
        'totalExpense': (freshSnapshot['totalExpense'] + model.totalExpense),
        'youROwed': model.youROwed
      }).catchError((e) {
        print(e.toString());
      }).whenComplete(() {});
    });

    await _db.collection("Expense").document(uid).updateData(model.toJson());
  }

  Future<String> getUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }
}
