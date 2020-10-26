import 'package:get_it/get_it.dart';
import 'package:locally_flutter_app/repositories/admin_repository.dart';
import 'package:locally_flutter_app/repositories/auth_repository.dart';
import 'package:locally_flutter_app/repositories/home_repository.dart';
import 'package:locally_flutter_app/services/admin_services.dart';
import 'package:locally_flutter_app/services/authentication_services.dart';
import 'package:locally_flutter_app/services/home_services.dart';

final sl = GetIt.instance;

void setUpLocator() {
  sl.registerLazySingleton(() => AuthenticationServices());
  sl.registerLazySingleton(() => AuthRepository());

  sl.registerLazySingleton(() => HomeServices());
  sl.registerLazySingleton(() => HomeRepository());

  sl.registerLazySingleton(() => AdminServices());
  sl.registerLazySingleton(() => AdminRepository());
}