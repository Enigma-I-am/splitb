import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:splitb/core/services/authentication_service.dart';
import 'package:splitb/core/services/firestore_service.dart';
import 'package:splitb/core/viewmodels/homescreenvm.dart';
import 'package:splitb/core/viewmodels/startup_vm.dart';
import 'core/services/navigation_service.dart';

final navService = Provider((ref) => NavigationService());
final authService = Provider((ref) => AuthenticationService(ref));
final fireStoreService = Provider((ref) => FirestoreServcie());


final startVm = ChangeNotifierProvider((ref) => AuthViewmodel(ref));
final homescreenVm = ChangeNotifierProvider((ref) => HomeScreenVM(ref));
