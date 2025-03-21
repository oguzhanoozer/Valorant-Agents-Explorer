import 'package:flutter/material.dart';

import '../../core/configs/constants/app_icons.dart';
import '../../core/configs/constants/app_size.dart';
import '../../core/configs/theme/app_colors.dart';
import '../../core/configs/theme/app_text_styles.dart';
import 'gesture_detector.dart';

const int _kMinColorLengthForGradient = 2;

final class CustomLabelButton extends StatelessWidget {
  const CustomLabelButton({
    super.key,
    required this.label,
    this.icon,
    this.onTap,
    this.isExpand = true,
    this.enabled = true,
    this.borderColor,
    List<Color>? backgroundColors,
    Color foregroundColor = AppColors.onPrimary,
  })  : backgroundColors = backgroundColors ??
            const <Color>[AppColors.primaryButtonStart, AppColors.primaryButtonEnd],
        foregroundColor = enabled ? foregroundColor : AppColors.disabledButtonForeground;

  factory CustomLabelButton.text({
    Key? key,
    required String label,
    final void Function()? onTap,
    Color foregroundColor = AppColors.primary,
  }) {
    return CustomLabelButton(
      key: key,
      label: label,
      onTap: onTap,
      isExpand: false,
      backgroundColors: const <Color>[],
      foregroundColor: foregroundColor,
    );
  }

  factory CustomLabelButton.cancel({
    Key? key,
    required String label,
    final void Function()? onTap,
    bool isExpand = true,
  }) {
    return CustomLabelButton(
      key: key,
      label: label,
      onTap: onTap,
      isExpand: isExpand,
      backgroundColors: const <Color>[
        AppColors.cancelButtonStart,
        AppColors.cancelButtonEnd,
      ],
    );
  }

  final String label;
  final AppIcons? icon;
  final void Function()? onTap;
  final bool isExpand;
  final bool enabled;
  final Color? borderColor;
  final List<Color> backgroundColors;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    final Decoration decoration = ShapeDecoration(
      shape: const StadiumBorder(),
      gradient: backgroundColors.length < _kMinColorLengthForGradient
          ? null
          : LinearGradient(colors: backgroundColors),
      color: backgroundColors.length < _kMinColorLengthForGradient
          ? backgroundColors.firstOrNull
          : null,
    );

    return CustomGestureDetector(
      onTap: switch (enabled) {
        true => switch (onTap) {
            final void Function() onTap => () {
                onTap();
              },
            _ => null,
          },
        false => null,
      },
      child: Material(
        color: Colors.transparent,
        elevation: backgroundColors.isEmpty ? 0 : AppSize.labelButtonElevation,
        shape: StadiumBorder(
          side: borderColor != null ? BorderSide(color: borderColor!) : BorderSide.none,
        ),
        child: Container(
          decoration: decoration,
          padding: AppSize.labelButtonPadding,
          constraints: const BoxConstraints(
            minWidth: AppSize.labelButtonMinSize,
            minHeight: AppSize.labelButtonMinSize,
          ),
          child: Row(
            mainAxisSize: isExpand ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (icon != null)
                Padding(
                  padding: AppSize.labelButtonWithIconPadding,
                  child: icon!(
                    size: AppSize.icon,
                    color: foregroundColor,
                  ),
                ),
              Flexible(
                child: Text(
                  label,
                  style: AppTextStyles.button(
                    color: foregroundColor,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: AppSize.labelButtonMaxLines,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
