import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../ui/dialogs/app_dialog.dart';
import '../../ui/widgets/text_field.dart';
import '../configs/constants/app_images.dart';
import '../configs/constants/app_strings.dart';
import '../configs/theme/app_colors.dart';

abstract final class DialogUtils {
  static Future<void> showFilterClearDialog(
    BuildContext? context, {
    void Function()? onApply,
  }) {
    return AppDialog(
      icon: AppImages.dialog_info(),
      message: AppStrings.login(),
      primaryButtonText: AppStrings.login(),
      cancelButtonText: AppStrings.login(),
      onTapPrimaryButton: onApply,
    ).show(context);
  }

  static Future<void> showFilterNotFoundDialog(BuildContext? context) {
    return AppDialog(
      icon: AppImages.dialog_warning(),
      message: AppStrings.login(),
      primaryButtonText: AppStrings.login(),
    ).show(context);
  }

  static Future<void> showCreateMovieCancelDialog(
    BuildContext? context, {
    void Function()? onApply,
  }) {
    return AppDialog(
      icon: AppImages.dialog_info(),
      message: AppStrings.login(),
      primaryButtonText: AppStrings.login(),
      cancelButtonText: AppStrings.login(),
      onTapPrimaryButton: onApply,
    ).show(context);
  }

  static Future<void> showCreateMovieApplyDialog(
    BuildContext? context, {
    required String classificationType,
    void Function()? onApply,
  }) {
    return AppDialog(
      icon: AppImages.dialog_info(),
      message: AppStrings.login(
        <String, dynamic>{
          '%classificationType': classificationType,
        },
      ),
      primaryButtonText: AppStrings.login(),
      cancelButtonText: AppStrings.login(),
      onTapPrimaryButton: onApply,
    ).show(context);
  }

  static Future<void> showCreateMovieSuccessDialog(BuildContext? context) {
    return AppDialog(
      icon: AppImages.dialog_success(),
      message: AppStrings.login(),
      primaryButtonText: AppStrings.login(),
    ).show(context);
  }

  static Future<void> showUpdateMovieCancelDialog(
    BuildContext? context, {
    void Function()? onApply,
  }) {
    return AppDialog(
      icon: AppImages.dialog_info(),
      message: AppStrings.login(),
      primaryButtonText: AppStrings.login(),
      cancelButtonText: AppStrings.login(),
      onTapPrimaryButton: onApply,
    ).show(context);
  }

  static Future<void> showUpdateMovieApplyDialog(
    BuildContext? context, {
    required String classificationType,
    void Function()? onApply,
  }) {
    return AppDialog(
      icon: AppImages.dialog_info(),
      message: AppStrings.login(
        <String, dynamic>{
          '%classificationType': classificationType,
        },
      ),
      primaryButtonText: AppStrings.login(),
      cancelButtonText: AppStrings.login(),
      onTapPrimaryButton: onApply,
    ).show(context);
  }

  static Future<void> showUpdateMovieSuccessDialog(BuildContext? context) {
    return AppDialog(
      icon: AppImages.dialog_success(),
      message: AppStrings.login(),
      primaryButtonText: AppStrings.login(),
    ).show(context);
  }

  static Future<void> showPermissionRequestDialog(BuildContext? context) {
    return AppDialog(
      icon: AppImages.dialog_info(),
      title: AppStrings.login(),
      message: AppStrings.login(),
      primaryButtonText: AppStrings.login(),
    ).show(context);
  }

  static Future<void> showPermissionFailDialog(BuildContext? context) {
    return AppDialog(
      icon: AppImages.dialog_warning(),
      title: AppStrings.login(),
      message: AppStrings.login(),
      primaryButtonText: AppStrings.login(),
    ).show(context);
  }

  static Future<void> showLocationServiceFailDialog(BuildContext? context) {
    return AppDialog(
      icon: AppImages.dialog_warning(),
      title: AppStrings.login(),
      message: AppStrings.login(),
      primaryButtonText: AppStrings.login(),
    ).show(context);
  }

  static Future<void> showLogoutDialog(
    BuildContext? context, {
    void Function()? onApply,
  }) {
    return AppDialog(
      icon: AppImages.dialog_warning(),
      message: AppStrings.login(),
      primaryButtonText: AppStrings.login(),
      cancelButtonText: AppStrings.login(),
      onTapPrimaryButton: onApply,
    ).show(context);
  }

  static Future<void> showSosDialog(
    BuildContext? context, {
    void Function()? onApply,
  }) {
    return AppDialog(
      icon: AppImages.dialog_sos(),
      message: AppStrings.login(),
      primaryButtonText: AppStrings.login(),
      cancelButtonText: AppStrings.login(),
      primaryButtonColors: const <Color>[
        AppColors.buttonStart,
        AppColors.buttonEnd,
      ],
      onTapPrimaryButton: onApply,
    ).show(context);
  }

  static Future<void> showDeleteFavoriteItemDialog(
    BuildContext? context, {
    required void Function() onApply,
  }) {
    return AppDialog(
      icon: AppImages.dialog_sos(),
      message: AppStrings.login(),
      primaryButtonText: AppStrings.delete(),
      cancelButtonText: AppStrings.cancel(),
      primaryButtonColors: const <Color>[
        AppColors.buttonStart,
        AppColors.buttonEnd,
      ],
      onTapPrimaryButton: onApply,
    ).show(context);
  }

  static Future<void> showSosCreatingDialog(
    BuildContext? context,
  ) {
    return AppDialog(
      icon: AppImages.dialog_info(),
      message: AppStrings.login(),
    ).show(context, false);
  }

  static Future<void> showUpdateOrDeleteDialog(
    BuildContext? context, {
    required AppStrings primaryButtonText,
    required AppStrings secondaryButtonText,
    required void Function() onPrimaryApply,
    required void Function() onSecondaryApply,
  }) {
    return AppDialog(
      icon: AppImages.dialog_warning(),
      title: AppStrings.login(),
      message: AppStrings.login(),
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
    AppStrings? primaryButtonText = AppStrings.login,
  }) {
    return AppDialog(
      icon: AppImages.dialog_warning(),
      message: message,
      primaryButtonText: primaryButtonText?.call(),
    ).show(context);
  }
}
