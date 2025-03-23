import 'package:agents_explorer/core/configs/constants/app_strings.dart';
import 'package:agents_explorer/ui/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../core/configs/constants/app_size.dart';
import '../../core/configs/theme/app_colors.dart';
import '../../core/configs/theme/app_text_styles.dart';
import '../widgets/label_button.dart';
import 'base_dialog.dart';

const double _kIconWidthFactor = 0.30;
const double _kIconVisibleRatio = 0.50;

final class AppDialog extends BaseDialog {
  AppDialog({
    this.initialTitleValue,
    this.initialDescriptionValue,
    super.key,
    super.routeName,
    this.icon,
    this.title,
    this.showError,
    required this.message,
    this.messageShowWidget,
    this.primaryButtonText,
    this.secondaryButtonText,
    this.cancelButtonText,
    this.primaryButtonColors,
    this.secondaryButtonColors,
    this.onTapPrimaryButton,
    this.onTapSecondaryButton,
    this.titleTextFieldController,
    this.descriptionTextFieldController,
  });

  final Widget? icon;
  final String? title;
  final bool? showError;
  final String message;

  String? initialTitleValue;
  String? initialDescriptionValue;
  final TextFieldType textFieldType = TextFieldType.rectangleSingle;
  final TextInputType keyboardType = TextInputType.text;
  final bool? messageShowWidget;
  final String? primaryButtonText;
  final String? secondaryButtonText;
  final String? cancelButtonText;

  final TextEditingController? titleTextFieldController;
  final TextEditingController? descriptionTextFieldController;

  final List<Color>? primaryButtonColors;
  final List<Color>? secondaryButtonColors;
  final void Function()? onTapPrimaryButton;
  final void Function()? onTapSecondaryButton;

  @override
  Widget builder(BuildContext context) {
    const EdgeInsets messagePadding = EdgeInsets.only(
      left: AppSize.paddingLow,
      right: AppSize.paddingLow,
      bottom: AppSize.paddingLow,
    );

    final Widget title = switch (this.title) {
      final String title => Padding(
          padding: messagePadding,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.title(),
          ),
        ),
      _ => const SizedBox(),
    };

    final String initTitle = initialTitleValue ?? '';

    final Widget descriptionTextField = CustomTextField(
      controller: descriptionTextFieldController,
      initialValue: descriptionTextFieldController?.text,
      type: TextFieldType.rectangleMulti,
      keyboardType: keyboardType,
      autoFocus: false,
      hintText: AppStrings.enterDescription(),
    );

    final Widget titleTextField = CustomTextField(
      controller: titleTextFieldController,
      initialValue: initialTitleValue,
      type: textFieldType,
      keyboardType: keyboardType,
      autoFocus: false,
      hintText: AppStrings.enterTitle(),
    );

    final Widget message = Padding(
      padding: messagePadding,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              this.message,
              textAlign: TextAlign.center,
              style: AppTextStyles.body3_high(
                fontWeight: FontWeight.normal,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            if (messageShowWidget != null && messageShowWidget!)
              Padding(
                padding: const EdgeInsets.only(
                  top: AppSize.padding,
                ),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 10),
                    switch (textFieldType) {
                      TextFieldType.rectangleMulti => AspectRatio(
                          aspectRatio: 4,
                          child: titleTextField,
                        ),
                      _ => titleTextField,
                    },
                    const SizedBox(height: 10),
                    switch (textFieldType) {
                      TextFieldType.rectangleMulti => AspectRatio(
                          aspectRatio: 4,
                          child: descriptionTextField,
                        ),
                      _ => descriptionTextField,
                    },
                    const SizedBox(height: 10),
                  ],
                ),
              ),
          ],
        ),
      ),
    );

    final double width = MediaQuery.sizeOf(context).width;
    final double iconSize = icon == null ? 0 : width * _kIconWidthFactor;

    Widget buttons(DialogViewModel viewModel) {
      return Wrap(
        runSpacing: AppSize.paddingLow,
        children: <Widget>[
          if (primaryButtonText != null)
            CustomLabelButton(
              label: primaryButtonText!,
              backgroundColors: primaryButtonColors,
              onTap: () {
                if (titleTextFieldController != null) {
                  if (initTitle.toLowerCase() == titleTextFieldController?.text.toLowerCase()) {
                    viewModel.toggleBool();
                  } else {
                    pop(context, () => onTapPrimaryButton?.call());
                  }
                } else {
                  pop(context, () => onTapPrimaryButton?.call());
                }
              },
            ),
          if (secondaryButtonText != null)
            CustomLabelButton(
              label: secondaryButtonText!,
              backgroundColors: secondaryButtonColors,
              onTap: () => pop(context, () => onTapSecondaryButton?.call()),
            ),
          if (cancelButtonText != null)
            CustomLabelButton(
              backgroundColors: const [AppColors.cancelButtonStart, AppColors.cancelButtonStart],
              label: cancelButtonText!,
              onTap: () => pop(context),
            ),
        ],
      );
    }

    return ViewModelBuilder<DialogViewModel>.reactive(
        viewModelBuilder: () => DialogViewModel(),
        builder: (context, viewModel, child) {
          if (showError != null && showError!) {
            viewModel.toggleBool();
          }
          return Stack(
            children: <Widget>[
              Container(
                width: width,
                padding: EdgeInsets.only(
                  left: AppSize.padding,
                  top: (icon == null ? AppSize.padding : AppSize.paddingLow) + (iconSize * _kIconVisibleRatio),
                  right: AppSize.padding,
                  bottom: AppSize.padding,
                ),
                margin: EdgeInsets.only(
                  top: iconSize * (1 - _kIconVisibleRatio),
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Theme.of(context).colorScheme.onSurface,
                  borderRadius: BorderRadius.circular(super.radius),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    title,
                    Flexible(
                      child: message,
                    ),
                    if (primaryButtonText != null || cancelButtonText != null)
                      const SizedBox(
                        height: AppSize.paddingLow,
                      ),
                    if (viewModel.isErrorEnabled) ...[
                      Text(
                        AppStrings.titleNotSameBeforeTitle(),
                        textAlign: TextAlign.center,
                        style: AppTextStyles.body3_high(
                          color: AppColors.buttonStart,
                        ),
                      ),
                      const SizedBox(
                        height: AppSize.paddingLow,
                      ),
                    ],
                    buttons(viewModel),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                child: SizedBox(
                  width: iconSize,
                  height: iconSize,
                  child: icon,
                ),
              ),
            ],
          );
        });
  }
}
