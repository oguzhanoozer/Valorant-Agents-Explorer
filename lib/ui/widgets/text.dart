import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../core/configs/theme/app_colors.dart';
import '../../core/configs/theme/app_text_styles.dart';

const String _splitValue = '](';
final RegExp _regExp = RegExp(r'\[([\w\s\dğĞçÇ$$ü0ö0@£]+)\]\((https?:\/\/[\w\d./?=#]+)\)', caseSensitive: false);

class CustomText extends StatefulWidget {
  const CustomText(
    this.text, {
    super.key,
    this.textStyle = AppTextStyles.body2_high,
    this.textAlign = TextAlign.start,
  });

  final String text;
  final AppTextStyles textStyle;
  final TextAlign textAlign;

  @override
  State<CustomText> createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: linkify(widget.text),
      ),
      style: widget.textStyle(),
      textAlign: widget.textAlign,
    );
  }

  List<InlineSpan> linkify(String text) {
    final List<InlineSpan> list = <InlineSpan>[];

    final RegExpMatch? match = _regExp.firstMatch(text);
    if (match == null) {
      return list..add(basicText(text));
    }
    if (match.start > 0) {
      list.add(basicText(text.substring(0, match.start)));
    }
    final String? textAndLink = match.group(0);
    if (textAndLink != null && textAndLink.contains(_regExp)) {
      final List<String> splittedTextLink = textAndLink.substring(1, textAndLink.length - 1).split(_splitValue);
      list.add(linkText(splittedTextLink[0], splittedTextLink[1]));
    }
    return list..addAll(linkify(text.substring(match.end)));
  }

  TextSpan basicText(String text) {
    return TextSpan(text: text);
  }

  TextSpan linkText(String text, String link) {
    return TextSpan(
      text: text,
      style: const TextStyle(color: AppColors.hyperTextColor),
      recognizer: TapGestureRecognizer()..onTap = () async {},
    );
  }
}
