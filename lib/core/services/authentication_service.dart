import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splitb/core/models/usermodel.dart';
import 'package:splitb/core/services/firestore_service.dart';
import 'package:splitb/providers.dart';

class AuthenticationService {
  final ProviderReference _providerRef;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirestoreServcie firestoreService;
  UserModel _currentUser;

  UserModel get currentUser => _currentUser;

  AuthenticationService(this._providerRef) {
    firestoreService = _providerRef.read(fireStoreService);
  }

// Check if user is logged in
  Future<bool> isUserLoggedIn() async {
    var user = await _auth.currentUser();
    await getUserDetails(user);
    return user != null;
  }

  Future<FirebaseUser> theCurrentUser() async {
    return _auth.currentUser();
  }

// Log User in with email and password
  Future logInUser({@required String email, @required String password}) async {
    try {
      var authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      var userId = authResult.user.uid;
      saveUid(userId);
      await getUserDetails(authResult.user);
      return authResult.user != null;
    } catch (e) {
      return e;
    }
  }

  // Create new User with email and password
  Future createUserWithEmailAndPassword(
      {@required String email, @required String password}) async {
    try {
      var authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      var uid = authResult.user.uid;
            var userId = authResult.user.uid;
      saveUid(userId);
      print("ID: $uid");

      await firestoreService.addUserToUserCollection(
        "Users",
        uid,
        email,
      );
      await getUserDetails(authResult.user);

      return authResult.user != null;
    } catch (e) {
      return e;
    }
  }

// get User details
  Future getUserDetails(FirebaseUser user) async {
    if (user != null) {
      _currentUser = await firestoreService.getUser(user.uid);
    }
  }

  Future saveUid(String uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString('userId');
    if(uid == null){
      prefs.setString('userId', uid);
    }
    
  }

  Future getUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }
}
