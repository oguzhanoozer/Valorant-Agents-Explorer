import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../theme/app_colors.dart';
import 'app_size.dart';

enum AppIcons {
  logo(),
  map(),
  user();

  String get _path => 'assets/icons/$name.svg';

  Widget call({
    double size = AppSize.icon,
    Color color = AppColors.icon,
    bool applyColorFilter = true,
  }) {
    return SizedBox(
      width: size,
      height: size,
      child: SvgPicture.asset(
        _path,
        fit: BoxFit.contain,
        colorFilter: switch (applyColorFilter) {
          true => ColorFilter.mode(color, BlendMode.srcIn),
          false => null,
        },
      ),
    );
  }
}
