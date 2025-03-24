import 'package:agents_explorer/ui/widgets/custom_widgets/create_adaptive_widgets.dart';
import 'package:flutter/material.dart';
import 'package:agents_explorer/core/configs/theme/app_colors.dart';

class CustomNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;
  final IconData fallbackIcon;
  final double fallbackIconSize;
  final Color fallbackIconColor;

  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.fallbackIcon = Icons.image_not_supported,
    this.fallbackIconSize = 100,
    this.fallbackIconColor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.trim().isEmpty) {
      return Icon(fallbackIcon, size: fallbackIconSize, color: fallbackIconColor);
    }

    return Image.network(
      imageUrl!,
      fit: fit,
      width: width,
      height: height,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CreateAdaptiveWidgets().adaptiveActivityIndicator(
            color: AppColors.primary,
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) => Icon(
        fallbackIcon,
        size: fallbackIconSize,
        color: fallbackIconColor,
      ),
    );
  }
}
