import 'package:agents_explorer/core/configs/theme/app_theme.dart';
import 'package:agents_explorer/core/init/app_locator.dart';
import 'package:agents_explorer/core/services/base_service.dart';
import 'package:agents_explorer/core/services/local_storage/local_storage_service.dart';
import 'package:agents_explorer/core/services/localization/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

final class ThemeService extends BaseService<ThemeService> with ReactiveServiceMixin {
  final ReactiveValue<bool> _isDarkMode = ReactiveValue<bool>(false);
  final ReactiveValue<String> _localization = ReactiveValue<String>("en");

  ThemeService() {
    listenToReactiveValues([_isDarkMode]);
    listenToReactiveValues([_localization]);
    _loadTheme();
    _loadLocalization();
  }

  bool get isDarkMode => _isDarkMode.value;
  String get localization => _localization.value;

  ThemeMode get currentTheme => _isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  Future<void> toggleTheme() async {
    _isDarkMode.value = !_isDarkMode.value;
    await ServiceLocator.get<LocalStorageService>().write(Keys.isDarkMode, _isDarkMode.value.toString());
  }

  Future<void> _loadTheme() async {
    String? theme = await ServiceLocator.get<LocalStorageService>().read(Keys.isDarkMode);
    _isDarkMode.value = theme != null && theme == 'true';
  }

  Future<void> toggleLocalization(String localKey) async {
    _localization.value = localKey;
    await ServiceLocator.get<LocalStorageService>().write(Keys.localization, localKey);
    await callSetStrings();
  }

  Future<void> _loadLocalization() async {
    _localization.value = await ServiceLocator.get<LocalStorageService>().read(Keys.localization) ?? 'en';
    await callSetStrings();
  }

  Future<void> callSetStrings() async {
    await ServiceLocator.get<LocalizationService>().addString(localization);
  }

  ThemeData get currentThemeData => isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;
}
