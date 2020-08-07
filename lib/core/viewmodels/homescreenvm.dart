import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:splitb/constants.dart';
import 'package:splitb/core/services/navigation_service.dart';
import 'package:splitb/core/viewmodels/basevm.dart';
import 'package:splitb/providers.dart';

class HomeScreenVM extends BaseViewModel {
  final ProviderReference ref;
  NavigationService _navigationService;

  HomeScreenVM(this.ref) {
    _navigationService = ref.read(navService);
  }

  void navigateToProfileScreen() async {
    await _navigationService.navigateTo(PROFILESCREEN);
  }

  void navigateTocreateNewGroupOrFriendScreen() async {
    await _navigationService.navigateTo(CREATENEWDEBTORSCREEN);
  }

  void navigateToDebtDetail(String title) async {
    await _navigationService.navigateTo(DEBTDETAILSCREEN,arguments: title);
  }
}
