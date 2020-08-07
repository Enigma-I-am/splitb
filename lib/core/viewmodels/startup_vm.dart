import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:splitb/constants.dart';
import 'package:splitb/core/services/authentication_service.dart';
import 'package:splitb/core/services/navigation_service.dart';
import 'package:splitb/core/viewmodels/basevm.dart';
import 'package:splitb/providers.dart';

class AuthViewmodel extends BaseViewModel {
  final ProviderReference ref;
  NavigationService _navigationService;
  AuthenticationService _authenticationService;

  AuthViewmodel(this.ref) {
    _navigationService = ref.read(navService);
    _authenticationService = ref.read(authService);
  }

  Future logUserIn({@required String email, @required String password}) async {
    setBusy(true);
    var result = await _authenticationService.logInUser(
        email: email, password: password);
    setBusy(false);

    if (result is bool) {
      print(result);
      if (result) {
        _navigationService.navigateAndClearHistory(HOMESCREEN);
      }
    }
  }

  Future createUser({@required String email, @required String password}) async {
    setBusy(true);
    var result = await _authenticationService.createUserWithEmailAndPassword(
        email: email, password: password);
    setBusy(false);

    if (result is bool) {
      print(result);
      if (result) {
        _navigationService.navigateAndClearHistory(HOMESCREEN);
      }
    }
  }

  Future handleStartUplogic() async {
    var hasUserLoggedIn = await _authenticationService.isUserLoggedIn();
    if (hasUserLoggedIn) {
      _navigationService.navigateToReplacement(HOMESCREEN);
    } else {
      _navigationService.navigateToReplacement(GETSTARTEDSCREEN);
    }
  }

  void navigateToDestination(String destination) async {
    await _navigationService.navigateTo(destination);
  }
}
