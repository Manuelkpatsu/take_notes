import 'package:get_it/get_it.dart';

import 'services/auth_service.dart';
import 'services/http.dart';
import 'services/password_service.dart';
import 'services/pref_service.dart';
import 'services/registration_service.dart';
import 'services/api_service.dart';
import 'storage/fs_storage.dart';
import 'storage/secure_storage.dart';
import 'view_models/auth_vm.dart';
import 'view_models/password_vm.dart';
import 'view_models/registration_vm.dart';
import 'view_models/api_vm.dart';
import 'view_models/pref_vm.dart';

GetIt sl = GetIt.instance;

void setUpLocator() {
  sl.registerLazySingleton<SecureStorage>(() => FSStorage());
  sl.registerLazySingleton(() => HttpService());
  sl.registerLazySingleton(() => AuthService());
  sl.registerLazySingleton(() => RegistrationService());
  sl.registerLazySingleton(() => PasswordService());
  sl.registerLazySingleton(() => APIService());
  sl.registerLazySingleton(() => PrefService());
  sl.registerLazySingleton(() => RegistrationVM());
  sl.registerLazySingleton(() => AuthVM());
  sl.registerLazySingleton(() => PasswordVM());
  sl.registerLazySingleton(() => ApiVM());
  sl.registerLazySingleton(() => PrefVm());
}
