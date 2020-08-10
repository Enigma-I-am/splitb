import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:splitb/core/models/friendmodel.dart';
import 'package:splitb/core/models/group_model.dart';
import 'package:splitb/core/services/firestore_service.dart';
import 'package:splitb/core/viewmodels/basevm.dart';
import 'package:splitb/providers.dart';

class BottomSheetVM extends BaseViewModel {
  List<FriendModel> _friends;
  List<GroupModel> _groups;

  List<GroupModel> get groups => _groups ?? [];
  List<FriendModel> get friends => _friends ?? [];

  final ProviderReference ref;

  FirestoreServcie _firestoreServcie;

  BottomSheetVM(this.ref) {
    _firestoreServcie = ref.read(fireStoreService);
  }

  void listenToGroups()async {
    setBusy(true);
    var uid = await  _firestoreServcie.getUid();
    _firestoreServcie.listenToGroupsRealTime(uid).listen((groupsData) {
      List<GroupModel> updatedGroups = groupsData;
      if (updatedGroups != null && updatedGroups.length > 0) {
        _groups = updatedGroups;
        notifyListeners();
      }
      setBusy(false);
    });
  }

  void listenTofriends() async {
    setBusy(true);
    var uid = await  _firestoreServcie.getUid();
    _firestoreServcie.listenToFriendsRealTime(uid).listen((friendsData) {
      List<FriendModel> updatedFriends = friendsData;
      if (updatedFriends != null && updatedFriends.length > 0) {
        _friends = updatedFriends;
        notifyListeners();
      }
      setBusy(false);
    });
  }

  Future fetchfriends() async {
    setBusy(true);

    var postsResults = await _firestoreServcie.getFriendsOnceOff();
    setBusy(false);

    if (postsResults is List<FriendModel>) {
      _friends = postsResults;
      notifyListeners();
    } else {
      print(" is happening here");
    }
  }
}
