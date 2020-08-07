import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:splitb/core/models/usermodel.dart';
import 'package:splitb/core/services/firestore_service.dart';
import 'package:splitb/providers.dart';

class AuthenticationService {
  final ProviderReference _providerRef;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirestoreServcie firestoreService;
  UserModel _currentUser;

  UserModel get currentUser => _currentUser;

  AuthenticationService(this._providerRef){
    firestoreService = _providerRef.read(fireStoreService);
  }
  
// Check if user is logged in
  Future<bool> isUserLoggedIn() async {
    var user = await _auth.currentUser();
    await getUserDetails(user);
    return user != null;
  }

// Create a User with email and password
  Future createUser({
    @required String email,
    @required String password,
    @required String path,
  }) async {
    try {
      var authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _currentUser = UserModel(
        id: authResult.user.uid,
        email: email,
      );
      await firestoreService.addUserToUserCollection(path, _currentUser);
      await getUserDetails(authResult.user);
      return authResult.user != null;
    } catch (error) {
      print(error.toString());
      return error.toString();
    }
  }

// Log User in with email and password
  Future logInUser({@required String email, @required String password}) async {
    try {
      var authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      await getUserDetails(authResult.user);
      return authResult.user != null;
    } catch (e) {
      return e;
    }
  }

  // Log User in with email and password
  Future createUserWithEmailAndPassword(
      {@required String email, @required String password}) async {
    try {
      var authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

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
}
