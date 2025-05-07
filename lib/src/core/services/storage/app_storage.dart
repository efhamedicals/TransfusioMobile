import 'dart:convert';

import 'package:get_storage/get_storage.dart';

class AppStorage {
  static GetStorage? _getStorage;
  AppStorage._();

  static final AppStorage instance = AppStorage._();

  Future<GetStorage> get storage async {
    if (_getStorage != null) {
      return _getStorage!;
    } else {
      await GetStorage.init();
      return _getStorage = GetStorage();
    }
  }

  static GetStorage get _storage => _getStorage!;

  bool exist(String key) => _storage.hasData(key);

  Future<void> setBool({required String key, required bool value}) async {
    await _storage.write(key, value);
  }

  Future<void> setNum({required String key, required num value}) async {
    await _storage.write(key, value);
  }

  Future<void> setString({required String key, required String value}) async {
    await _storage.write(key, value);
  }

  Future<void> setInstance({required String key, required var value}) async {
    await _storage.write(key, jsonEncode(value));
  }

  getDataStorage(String key) async {
    return _storage.read(key);
  }

  delOnlyDataStorage(String key) async {
    return _storage.remove(key);
  }

  num getNum(String key) => _storage.read(key) ?? 0;

  String getString(String key) => _storage.read(key) ?? '';

  bool getBool(String key) => _storage.read(key) ?? false;

  Future<void> deleteDataLocal() async {
    await _storage.erase();
  }
}
