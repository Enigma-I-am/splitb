import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:splitb/core/models/friendmodel.dart';
import 'package:splitb/core/models/group_model.dart';
import 'package:splitb/core/models/usermodel.dart';

class FirestoreServcie {
  final Firestore _db = Firestore.instance;
  CollectionReference _ref;

  Future addUserToUserCollection(String path, String uid, String email) async {
    try {
      _ref = _db.collection(path);
      await _ref
          .document(uid)
          .setData(UserModel(id: uid, email: email).toJson());
    } catch (e) {
      print(e.toString());
    }
  }

  // Future updateUserProfile(String id) {}
  Future getUser(String uid) async {
    try {
      _ref = _db.collection("Users");
      var userData = await _ref.document(uid).get();
      return UserModel.fromMap(userData.data);
    } catch (e) {
      print(e.toString());
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
      await _ref.add(groupModel.toJson());
    } catch (e) {
      print(e.toString());
      print(e.toString());
    }
  }
}
