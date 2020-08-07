import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:splitb/core/models/usermodel.dart';

class FirestoreServcie {
  
  final Firestore _db = Firestore.instance;
  CollectionReference _ref;
 

  Future addUserToUserCollection(String path, UserModel userModel) async {
    try {
      _ref = _db.collection(path);
      _ref.document(userModel.id).setData(userModel.toJson());
    } catch (e) {
      print(e.toString());
    }
  }

  Future updateUserProfile(String id) {}

  Future getUser(String uid) async {
    try {
      _ref = _db.collection("Users");
      var userData = await _ref.document(uid).get();
      return UserModel.fromMap(userData.data);
    } catch (e) {
      print(e.toString());
    }
  }
}
