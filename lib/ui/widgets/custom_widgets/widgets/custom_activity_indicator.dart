import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/configs/constants/app_size.dart';
import '../../../../core/configs/theme/app_colors.dart';

abstract interface class CustomActivityIndicator {
  Widget render(Color? color);
}

class MaterialActivityIndicator extends CustomActivityIndicator {
  @override
  Widget render(Color? color) {
    return CircularProgressIndicator(
      color: color ?? AppColors.primary,
      strokeWidth: AppSize.materialActivityIndicatorStrokeWidth,
    );
  }
}

class IOSActivityIndicator extends CustomActivityIndicator {
  @override
  Widget render(Color? color) {
    return CupertinoActivityIndicator(
      color: color ?? AppColors.primary,
      radius: AppSize.cupertinoActivityIndicatorRadius,
    );
  }
}
