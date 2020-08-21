import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:splitb/core/services/authentication_service.dart';
import 'package:splitb/core/services/firestore_service.dart';
import 'package:splitb/core/viewmodels/bottomsheet_vm.dart';
import 'package:splitb/core/viewmodels/createnewdebtorgroup_vm.dart';
import 'package:splitb/core/viewmodels/homescreenvm.dart';
import 'package:splitb/core/viewmodels/auth_vm.dart';
import 'package:splitb/core/viewmodels/splashscreenvm.dart';
import 'core/services/navigation_service.dart';
import 'core/viewmodels/createnewdebtor_vm.dart';
import 'core/viewmodels/profile_vm.dart';

final navService = Provider((ref) => NavigationService());
final fireStoreService = Provider((ref) => FirestoreServcie());
final authService = Provider((ref) => AuthenticationService(ref));

final splashVM = ChangeNotifierProvider((ref) => SpalshScreenVM(ref));
final startVm = ChangeNotifierProvider((ref) => AuthViewmodel(ref));
final homescreenVm = ChangeNotifierProvider((ref) => HomeScreenVM(ref));
final createDebtorVm =
    ChangeNotifierProvider((ref) => CreateDebtorViewmodel(ref));
final createDebtorGroupVm =
    ChangeNotifierProvider((ref) => CreateNewDebtorGroupViewmodel(ref));

final bottomSheetVM = ChangeNotifierProvider((ref) => BottomSheetVM(ref));
final profileVM = ChangeNotifierProvider((ref) => ProfileViewmodel(ref));
