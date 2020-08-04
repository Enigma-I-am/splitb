import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:splitb/core/viewmodels/startup_vm.dart';
import 'core/services/navigation_service.dart';

final navService = Provider((ref) => NavigationService());
final startVm = ChangeNotifierProvider((ref)=> AuthViewmodel(ref));
