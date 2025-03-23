import 'package:flutter/material.dart';

import '../../core/configs/constants/app_size.dart';
import '../../core/configs/theme/app_colors.dart';
import '../../core/configs/theme/app_text_styles.dart';

enum TextFieldType {
  roundedSingle(false, AppSize.textFieldRadius, 1),
  rectangleSingle(false, 4, 1),
  rectangleMulti(true, 4, null);

  final bool _expands;
  final double _radius;
  final int? _lines;

  const TextFieldType(this._expands, this._radius, this._lines);
}

final class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    this.type = TextFieldType.roundedSingle,
    this.hintText,
    String? initialValue,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.obscureText = false,
    this.autoFocus = false,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.controller,
  }) {
    controller ?? TextEditingController(text: initialValue);
  }

  final TextFieldType type;
  final String? hintText;
  final void Function(String value)? onChanged;
  final void Function(String value)? onSubmitted;
  final void Function()? onTap;
  final bool obscureText;
  final bool autoFocus;
  final bool readOnly;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    final double textFieldHeight = type == TextFieldType.rectangleMulti ? AppSize.textFieldHeight * 2 : AppSize.textFieldHeight;

    return SizedBox(
      height: textFieldHeight,
      child: TextField(
        maxLines: type._lines,
        minLines: type._lines,
        expands: type._expands,
        controller: controller,
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.top,
        showCursor: true,
        obscureText: obscureText,
        autofocus: autoFocus,
        readOnly: readOnly,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        cursorWidth: 1,
        cursorColor: AppColors.onSurfaceHigh,
        style: AppTextStyles.body3_high(color: Theme.of(context).colorScheme.onPrimary),
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          labelText: hintText,
          hintStyle: AppTextStyles.body3_high(
            color: AppColors.onSurfaceHigh,
          ),
          alignLabelWithHint: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: AppSize.textFieldPaddingVertical,
            horizontal: AppSize.textFieldPaddingHorizontal,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.cancelButtonEnd),
            borderRadius: BorderRadius.all(
              Radius.circular(type._radius),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.primary),
            borderRadius: BorderRadius.all(
              Radius.circular(type._radius),
            ),
          ),
        ),
      ),
    );
  }
}
