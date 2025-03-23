import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../ui/dialogs/app_dialog.dart';
import '../configs/constants/app_images.dart';
import '../configs/constants/app_strings.dart';
import '../configs/theme/app_colors.dart';

abstract final class DialogUtils {
  static Future<void> showCreateFavoriteSuccessDialog(
    BuildContext? context, {
    required String message,
  }) {
    return AppDialog(
      icon: AppImages.dialog_success(),
      message: message,
      primaryButtonText: AppStrings.ok(),
    ).show(context);
  }

  static Future<void> showDeleteFavoriteItemDialog(
    BuildContext? context, {
    required void Function() onApply,
  }) {
    return AppDialog(
      icon: AppImages.dialog_warning(),
      message: AppStrings.deleteAgentMessage(),
      primaryButtonText: AppStrings.delete(),
      cancelButtonText: AppStrings.cancel(),
      primaryButtonColors: const <Color>[
        AppColors.buttonStart,
        AppColors.buttonEnd,
      ],
      onTapPrimaryButton: onApply,
    ).show(context);
  }

  static Future<void> showUpdateOrDeleteDialog(
    BuildContext? context, {
    required AppStrings primaryButtonText,
    required AppStrings secondaryButtonText,
    required void Function() onPrimaryApply,
    required void Function() onSecondaryApply,
  }) {
    return AppDialog(
      icon: AppImages.dialog_info(),
      message: AppStrings.selectProcess(),
      primaryButtonText: primaryButtonText(),
      secondaryButtonText: secondaryButtonText(),
      onTapPrimaryButton: onPrimaryApply,
      onTapSecondaryButton: onSecondaryApply,
      secondaryButtonColors: const <Color>[
        AppColors.buttonStart,
        AppColors.buttonEnd,
      ],
    ).show(context);
  }

  static Future<void> showTextInputDialog(
    BuildContext? context, {
    Widget? icon,
    required String message,
    String? initialTitleValue,
    String? initialDescriptionValue,
    void Function(String? title, String? description)? onApply,
  }) {
    final titleController = TextEditingController(text: initialTitleValue);
    final descriptionController = TextEditingController(text: initialDescriptionValue);

    return AppDialog(
      initialTitleValue: initialTitleValue,
      initialDescriptionValue: initialDescriptionValue,
      message: message,
      messageShowWidget: true,
      primaryButtonText: AppStrings.save(),
      cancelButtonText: AppStrings.cancel(),
      titleTextFieldController: titleController,
      descriptionTextFieldController: descriptionController,
      onTapPrimaryButton: () => onApply?.call(titleController.text, descriptionController.text),
    ).show(context);
  }

  static Future<void> showErrorDialog(
    BuildContext? context, {
    required String message,
    AppStrings? primaryButtonText = AppStrings.ok,
  }) {
    return AppDialog(
      icon: AppImages.dialog_warning(),
      message: message,
      primaryButtonText: primaryButtonText?.call(),
    ).show(context);
  }
}
