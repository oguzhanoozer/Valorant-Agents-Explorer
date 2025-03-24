import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../base_service.dart';

enum Keys { favoriteAgents, cacheAgents, isDarkMode, localization }

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

  Future<void> write(Keys key, String value) async {
    await _storage.write(key: key.name, value: value);
  }

  Future<void> delete(Keys key) async {
    await _storage.delete(key: key.name);
  }
}
