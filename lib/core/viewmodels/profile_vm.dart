import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:splitb/constants.dart';
import 'package:splitb/core/models/usermodel.dart';
import 'package:splitb/core/services/authentication_service.dart';
import 'package:splitb/core/services/firestore_service.dart';
import 'package:splitb/core/services/navigation_service.dart';
import 'package:splitb/core/viewmodels/basevm.dart';
import 'package:splitb/providers.dart';

class ProfileViewmodel extends BaseViewModel {
  UserModel _user;
  UserModel get user =>
      _user ??
      UserModel(
          id: " ",
          email: "email@example.com",
          firstName: "firstName",
          lastName: "LastName");

  final ProviderReference ref;
  NavigationService _navigationService;
  AuthenticationService _authenticationService;
  FirestoreServcie _firestoreServcie;
  ProfileViewmodel(this.ref) {
    _navigationService = ref.read(navService);
    _authenticationService = ref.read(authService);
    _firestoreServcie = ref.read(fireStoreService);
  }

  Future getUserDetails() async {
    setBusy(true);
    var uid = await _authenticationService.getUid();
    var thisUser = await _firestoreServcie.getUser(uid);
    _user = thisUser;
    setBusy(false);
  }

  UserModel currentUser() {
    return _authenticationService.currentUser;
  }

  void navigateToEditProfile(UserModel model) {
    _navigationService.navigateTo(EDITPROFILESCREEN, arguments: model);
  }

  Future updateUserDatails(String firsname, String lastname, String phoneNumber) async {
    setBusy(true);
    var uid = await _authenticationService.getUid();
    await _firestoreServcie.updateUserInUserCollection(
        path: "Users", uid: uid, firstname: firsname, lastname: lastname, phoneNumber:phoneNumber);
    _navigationService.navigateToReplacement(HOMESCREEN);
    setBusy(false);
  }
}
