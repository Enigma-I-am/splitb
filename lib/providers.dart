import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:splitb/core/services/authentication_service.dart';
import 'package:splitb/core/services/firestore_service.dart';
import 'package:splitb/core/viewmodels/homescreenvm.dart';
import 'package:splitb/core/viewmodels/auth_vm.dart';
import 'core/services/navigation_service.dart';

final navService = Provider((ref) => NavigationService());
final fireStoreService = Provider((ref) => FirestoreServcie());
final authService = Provider((ref) => AuthenticationService(ref));

final startVm = ChangeNotifierProvider((ref) => AuthViewmodel(ref));
final homescreenVm = ChangeNotifierProvider((ref) => HomeScreenVM(ref));
