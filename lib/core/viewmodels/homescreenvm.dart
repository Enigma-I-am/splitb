import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:splitb/constants.dart';
import 'package:splitb/core/models/expensemodel.dart';
import 'package:splitb/core/models/friendmodel.dart';
import 'package:splitb/core/models/group_model.dart';
import 'package:splitb/core/services/authentication_service.dart';
import 'package:splitb/core/services/firestore_service.dart';
import 'package:splitb/core/services/navigation_service.dart';
import 'package:splitb/core/viewmodels/basevm.dart';
import 'package:splitb/providers.dart';

class HomeScreenVM extends BaseViewModel {
  ExpenseModel _expense;
  ExpenseModel get expense =>
      _expense ?? ExpenseModel(totalExpense: 0, youROwed: 0);
  final ProviderReference ref;
  NavigationService _navigationService;
  FirestoreServcie _firestoreServcie;
  AuthenticationService _authenticationService;

  HomeScreenVM(this.ref) {
    _navigationService = ref.read(navService);
    _firestoreServcie = ref.read(fireStoreService);
    _authenticationService = ref.read(authService);
  }

  void listenToGroups() async {
    setBusy(true);
    var uid = await _firestoreServcie.getUid();
    _firestoreServcie.listenToGroupsRealTime(uid).listen((groupsData) {
      List<GroupModel> updatedGroups = groupsData;
      if (updatedGroups != null && updatedGroups.length > 0) {
        notifyListeners();
      }
      setBusy(false);
    });
  }

  Stream listenToExpenses(String uid) {
    return _firestoreServcie.getExpenseAsStream(uid);
  }

  currentUser() {
    return _authenticationService.currentUser.id;
  }

  loadUserDetails() async {
    var uid = await _firestoreServcie.getUid();
    return uid;
  }

  void _onExpenseUpdated(ExpenseModel expense) {
    setBusy(true);
    _expense = expense; // Set the stats for the UI
    notifyListeners();
    setBusy(false);
  }

  Future loadExpense() async {
    _expense = await _firestoreServcie.getExpense();
  }

  void navigateToProfileScreen() async {
    await _navigationService.navigateTo(PROFILESCREEN);
  }

  void navigateTocreateNewGroupOrFriendScreen(String route) async {
    await _navigationService.navigateTo(route);
  }

  void navigateToGroupDebtDetail(GroupModel title) async {
    await _navigationService.navigateTo(GROUPDEBTDETAILSCREEN,
        arguments: title);
  }

  void navigateToFriendDebtDetail(FriendModel title) async {
    await _navigationService.navigateTo(FRIENDDEBTDETAILSCREEN,
        arguments: title);
  }

  Future getUid() async {
    var uid = await _firestoreServcie.getUid();
    return uid;
  }
}
