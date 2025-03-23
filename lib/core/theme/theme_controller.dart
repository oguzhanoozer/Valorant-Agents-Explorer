import 'package:agents_explorer/core/configs/theme/app_theme.dart';
import 'package:agents_explorer/core/init/app_locator.dart';
import 'package:agents_explorer/core/services/theme/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

final class ThemeController extends ReactiveViewModel {
  final ThemeService _themeService = ServiceLocator.get<ThemeService>();

  bool get isDarkMode => _themeService.isDarkMode;
  //String get localization => _themeService.localization;
  ThemeMode get themeMode => _themeService.currentTheme;
  ThemeData get lightTheme => AppTheme.lightTheme;
  ThemeData get darkTheme => AppTheme.darkTheme;
  ThemeData get currentThemeData => _themeService.currentThemeData;

  Future<void> toggleTheme() async {
    await _themeService.toggleTheme();
    rebuildUi();
  }

  // Future<void> toggleLocalization(String localKey, BuildContext? context) async {
  //   await _themeService.toggleLocalization(localKey);
  //   rebuildUi();
  // }

  List<ReactiveServiceMixin> get reactiveServices => [_themeService];
}
