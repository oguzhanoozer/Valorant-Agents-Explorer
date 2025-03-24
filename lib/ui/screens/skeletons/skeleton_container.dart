import 'package:flutter/material.dart';

import '../../../core/configs/theme/app_colors.dart';

final class SkeletonContainer extends StatelessWidget {
  const SkeletonContainer({
    super.key,
    this.width,
    this.height = 12,
    this.widthFactor,
  }) : decoration = const ShapeDecoration(
          shape: StadiumBorder(),
          color: AppColors.shimmerBase,
        );

  const SkeletonContainer.rectangle({
    super.key,
    this.width,
    this.height = 12,
    this.widthFactor,
  }) : decoration = const BoxDecoration(
          color: AppColors.shimmerBase,
        );

  final double? width;
  final double? height;
  final double? widthFactor;
  final Decoration? decoration;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: widthFactor,
      child: Container(
        width: width,
        height: height,
        decoration: decoration,
      ),
    );
  }
}
