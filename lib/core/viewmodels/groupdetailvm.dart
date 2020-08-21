import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:splitb/core/services/firestore_service.dart';
import 'package:splitb/core/services/navigation_service.dart';
import 'package:splitb/core/viewmodels/basevm.dart';
import 'package:splitb/providers.dart';

class GroupDetailVM extends BaseViewModel {
  final ProviderReference ref;
  NavigationService _navigationService;
  FirestoreServcie _firestoreServcie;

  GroupDetailVM(this.ref) {
    _navigationService = ref.read(navService);
    _firestoreServcie = ref.read(fireStoreService);
  }

  Future<void> deleteGroup(String reference) async {
    setBusy(true);
    await _firestoreServcie.removeGroup(reference);
    _navigationService.goBack();
    setBusy(false);
  }
}
