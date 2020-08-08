import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:splitb/core/models/friendmodel.dart';
import 'package:splitb/core/services/authentication_service.dart';
import 'package:splitb/core/services/firestore_service.dart';
import 'package:splitb/core/services/navigation_service.dart';
import 'package:splitb/core/viewmodels/basevm.dart';
import 'package:splitb/providers.dart';

class CreateDebtorViewmodel extends BaseViewModel {
  final ProviderReference ref;
  NavigationService _navigationService;
  FirestoreServcie _firestoreServcie;
  AuthenticationService _authenticationService;



  CreateDebtorViewmodel(this.ref) {
    _firestoreServcie = ref.read(fireStoreService);
    _navigationService = ref.read(navService);
    _authenticationService = ref.read(authService);
  }

  Future addFriend(
      {@required String name,
      @required int amountOwed,
      @required String phoneNumber}) async {
    setBusy(true);
    var userID = await _authenticationService.getUid();
    await _firestoreServcie.addFriend(FriendModel(
        friendName: name,
        amountOwed: amountOwed,
        phoneNumber: phoneNumber,
        userId: userID));
    _navigationService.goBack();
    setBusy(false);
  }


}
