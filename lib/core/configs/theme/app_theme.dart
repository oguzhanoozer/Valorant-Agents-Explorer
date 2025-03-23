import 'package:flutter/material.dart';

import '../constants/app_size.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

abstract final class AppTheme {
  static const ThemeMode themeMode = ThemeMode.light;

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    platform: TargetPlatform.android,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    hintColor: AppColors.onSurfaceLow,
    fontFamily: fontFamily,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.onSurfaceHigh,
      selectionColor: AppColors.primary,
      selectionHandleColor: AppColors.primary,
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: AppColors.surface,
      elevation: 8,
      enableFeedback: true,
      textStyle: AppTextStyles.body2_high(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    dialogBackgroundColor: AppColors.surface,
    dialogTheme: const DialogTheme(
      backgroundColor: AppColors.surface,
    ),
    colorScheme: const ColorScheme.dark(
      brightness: Brightness.light,
      surface: AppColors.surface,
      primary: AppColors.primary,
      onSurface: AppColors.background,
      onPrimary: AppColors.onSurfaceHigh,
      onSurfaceVariant: AppColors.onSurfaceMedium,
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.background,
      surfaceTintColor: AppColors.background,
      iconTheme: IconThemeData(size: 24, opacity: 1, color: AppColors.onSurfaceHigh),
      actionsIconTheme: IconThemeData(size: 24, opacity: 1, color: AppColors.onSurfaceHigh),
    ),
    iconTheme: const IconThemeData(size: 24, opacity: 1, color: AppColors.onSurfaceHigh),
    dividerTheme: const DividerThemeData(
      thickness: AppSize.dividerThickness,
      space: 0,
      color: AppColors.onSurfaceLow,
    ),
    badgeTheme: const BadgeThemeData(
      backgroundColor: AppColors.badge,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      elevation: 0,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    platform: TargetPlatform.android,
    primaryColor: AppColors.primaryDark,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    hintColor: AppColors.onSurfaceLowDark,
    fontFamily: fontFamily,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.onSurfaceHighDark,
      selectionColor: AppColors.primaryDark,
      selectionHandleColor: AppColors.primaryDark,
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: AppColors.surfaceDark,
      elevation: 8,
      enableFeedback: true,
      textStyle: AppTextStyles.body2_high(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    dialogBackgroundColor: AppColors.surfaceDark,
    dialogTheme: const DialogTheme(
      backgroundColor: AppColors.surfaceDark,
    ),
    colorScheme: ColorScheme.dark(
      brightness: Brightness.dark,
      surface: AppColors.primary,
      primary: AppColors.primaryDark,
      onSurface: AppColors.backgroundDark,
      onPrimary: AppColors.onPrimaryDark,
      onSurfaceVariant: AppColors.onPrimary,
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.backgroundDark,
      surfaceTintColor: AppColors.backgroundDark,
      iconTheme: IconThemeData(size: 24, opacity: 1, color: AppColors.onSurfaceHighDark),
      actionsIconTheme: IconThemeData(size: 24, opacity: 1, color: AppColors.onSurfaceHighDark),
    ),
    iconTheme: IconThemeData(size: 24, opacity: 1, color: AppColors.onSurfaceHighDark),
    dividerTheme: DividerThemeData(
      thickness: AppSize.dividerThickness,
      space: 0,
      color: AppColors.onSurfaceLowDark,
    ),
    badgeTheme: BadgeThemeData(
      backgroundColor: AppColors.badgeDark,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      elevation: 0,
    ),
  );
}
