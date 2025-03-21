import 'package:flutter/cupertino.dart';

import '../../core/configs/constants/app_icons.dart';
import '../../core/configs/constants/app_strings.dart';
import '../../core/configs/theme/app_text_styles.dart';
import 'gesture_detector.dart';

final class FilterItem extends StatelessWidget {
  const FilterItem({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
    required this.onClear,
  });

  final AppIcons icon;
  final AppStrings title;
  final String? value;
  final void Function() onTap;
  final void Function() onClear;

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      onTap: () => onTap(),
      leading: icon(),
      title: Text(
        title(),
        style: AppTextStyles.body2_high(fontWeight: FontWeight.normal),
      ),
      subtitle: switch (value) {
        final String value => Text(value, style: AppTextStyles.body2_high(fontWeight: FontWeight.bold)),
        null => null,
      },
      trailing: switch (value) {
        String _ => CustomGestureDetector(
            child: AppIcons.logo(),
            onTap: () => onClear(),
          ),
        null => AppIcons.logo()
      },
    );
  }
}
