import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'secure_storage.dart';

class FSStorage extends SecureStorage {
  final _storage = FlutterSecureStorage();

  @override
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  @override
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }

  @override
  Future<String?> read(String key) async {
    final String? value = await _storage.read(key: key);
    return value;
  }

  @override
  Future<Map<String, dynamic>> readAll() async {
    return await _storage.readAll();
  }

  @override
  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }
}
