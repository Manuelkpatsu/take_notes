import 'package:get_it/get_it.dart';

import 'services/http.dart';
import 'storage/fs_storage.dart';
import 'storage/secure_storage.dart';

GetIt sl = GetIt.instance;

void setUpLocator() {
  sl.registerLazySingleton<SecureStorage>(() => FSStorage());
  sl.registerLazySingleton(() => HttpService());
}
