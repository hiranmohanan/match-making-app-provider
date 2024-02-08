import 'package:get_it/get_it.dart';
import 'package:match_making_test/services/services_getit.dart';

final getIt = GetIt.instance;

Future<void> serviceLocator() async {
  getIt.registerSingleton<AppServices>(AppServices());
}
