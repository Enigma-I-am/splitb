import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:splitb/core/services/navigation_service.dart';
import 'package:splitb/core/viewmodels/basevm.dart';
import 'package:splitb/providers.dart';

class AuthViewmodel extends BaseViewModel {
  final ProviderReference ref;
  NavigationService _navigationService;

  AuthViewmodel(this.ref) {
    _navigationService = ref.read(navService);
  }

  void navigateToDestination(String destination) async {
    await _navigationService.navigateTo(destination);
  }

  void navigateReplacmentToDestination(String destination) async {
    await _navigationService.navigateToReplacement(destination);
  }

  void navigateAndClear(String destination) async {
    await _navigationService.navigateAndClearHistory(destination);
  }
}
