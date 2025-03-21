import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../base_service.dart';

enum Keys {
  accessToken,
  refreshToken,
  baseUrl,
  userModel,
  userRights,
  notificationType,
}

final class LocalStorageService extends BaseService<LocalStorageService> {
  final FlutterSecureStorage _storage;

  LocalStorageService()
      : _storage = const FlutterSecureStorage(
          aOptions: AndroidOptions(
            encryptedSharedPreferences: true,
          ),
          iOptions: IOSOptions.defaultOptions,
        );

  Future<String?> read(Keys key) async {
    return await _storage.read(key: key.name);
  }

  Future<Map<String, dynamic>?> readMap(Keys key) async {
    final String? value = await read(key);
    return value != null ? jsonDecode(value) : null;
  }

  Future<void> write(Keys key, String value) async {
    await _storage.write(key: key.name, value: value);
  }

  Future<void> writeMap(Keys key, Map<String, dynamic> value) async {
    await write(key, jsonEncode(value));
  }

  Future<void> delete(Keys key) async {
    await _storage.delete(key: key.name);
  }

  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}
