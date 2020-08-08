import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:splitb/core/models/group_friend_model.dart';
import 'package:splitb/core/models/group_model.dart';
import 'package:splitb/core/services/authentication_service.dart';
import 'package:splitb/core/services/firestore_service.dart';
import 'package:splitb/core/services/navigation_service.dart';
import 'package:splitb/core/viewmodels/basevm.dart';
import 'package:splitb/providers.dart';

class CreateNewDebtorGroupViewmodel extends BaseViewModel {
  final ProviderReference ref;
  NavigationService _navigationService;
  FirestoreServcie _firestoreServcie;
  AuthenticationService _authenticationService;
  CreateNewDebtorGroupViewmodel(this.ref) {
    _firestoreServcie = ref.read(fireStoreService);
    _navigationService = ref.read(navService);
    _authenticationService = ref.read(authService);
  }
  Future addGroup(List<FriendGroupModel> group, String groupName, int amount) async {
    setBusy(true);
    var userID = await _authenticationService.getUid();
    var model = GroupModel(group: group,
         userId: userID, groupName: groupName, amount: amount);
    await _firestoreServcie.addGroup(model);
    _navigationService.goBack();
    setBusy(false);
    // print(_friends[0].amountOwed);
  }
}
