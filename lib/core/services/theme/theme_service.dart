import 'package:agents_explorer/core/configs/theme/app_theme.dart';
import 'package:agents_explorer/core/init/app_locator.dart';
import 'package:agents_explorer/core/services/base_service.dart';
import 'package:agents_explorer/core/services/localization/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

final class ThemeService extends BaseService<ThemeService> with ReactiveServiceMixin {
  static const String _themeKey = "isDarkMode";
  static const String _localKey = "localization";
  final ReactiveValue<bool> _isDarkMode = ReactiveValue<bool>(false);
  final ReactiveValue<String> _localization = ReactiveValue<String>("en");

  ThemeService() {
    listenToReactiveValues([_isDarkMode]);
    listenToReactiveValues([_localization]);
    _loadTheme();
    //_loadLocalization();
  }

  bool get isDarkMode => _isDarkMode.value;
  String get localization => _localization.value;

  ThemeMode get currentTheme => _isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  Future<void> toggleTheme() async {
    _isDarkMode.value = !_isDarkMode.value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, _isDarkMode.value);
  }

  Future<void> _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode.value = prefs.getBool(_themeKey) ?? false;
  }

  // Future<void> toggleLocalization(String localKey) async {
  //   _localization.value = localKey;
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString(_localKey, localKey);
  //   await callSetStrings();
  // }

  // Future<void> _loadLocalization() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   _localization.value = prefs.getString(_localKey) ?? 'en';
  //   await callSetStrings();
  // }

  // Future<void> callSetStrings() async {
  //   await ServiceLocator.get<LocalizationService>().addString(localization);
  // }

  ThemeData get currentThemeData => isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;
}
