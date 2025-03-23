import 'package:flutter/material.dart';

import 'app_colors.dart';

const String fontFamily = 'EurostileT';

enum AppTextStyles {
  body1_medium(fontSize: 12, color: AppColors.onSurfaceMedium),

  body2_low(fontSize: 14, color: AppColors.onSurfaceLow),
  body2_medium(fontSize: 14, color: AppColors.onSurfaceMedium),
  body2_high(fontSize: 14, color: AppColors.onSurfaceHigh),

  body3_high(fontSize: 16, color: AppColors.onSurfaceHigh, fontWeight: FontWeight.w500),

  button(fontSize: 16, color: AppColors.primary, fontWeight: FontWeight.w500),
  title(fontSize: 14, color: AppColors.onSurfaceHigh, fontWeight: FontWeight.w500);

  final int fontSize;
  final Color color;
  final FontWeight fontWeight;

  const AppTextStyles({
    required this.fontSize,
    this.color = AppColors.onSurfaceMedium,
    this.fontWeight = FontWeight.normal,
  });

  TextStyle call({
    Color? color,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize.toDouble(),
      color: color ?? this.color,
      fontWeight: fontWeight ?? this.fontWeight,
      fontStyle: fontStyle,
    );
  }
}
