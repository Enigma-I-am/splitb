import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:splitb/constants.dart';
import 'package:splitb/core/services/authentication_service.dart';
import 'package:splitb/core/services/navigation_service.dart';
import 'package:splitb/core/viewmodels/basevm.dart';
import 'package:splitb/providers.dart';

class SpalshScreenVM extends BaseViewModel {
  final ProviderReference ref;
   AuthenticationService _authenticationService;
   NavigationService _navigationService;

  SpalshScreenVM(this.ref) {
    _navigationService = ref.read(navService);
    _authenticationService = ref.read(authService);
  }


    Future handleStartUpLogic() async {
    var hasLoggedInUser = await _authenticationService.isUserLoggedIn();
    if (hasLoggedInUser) {
      _navigationService.navigateTo(HOMESCREEN);
    }else{
_navigationService.navigateTo(ONBOARDINGSCREEN);
    }
      
    
  }
}
