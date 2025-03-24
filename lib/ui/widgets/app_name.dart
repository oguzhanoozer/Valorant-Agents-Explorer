import 'package:flutter/widgets.dart';

import '../../core/configs/theme/app_colors.dart';

const String _kAppName = 'Agents Explorer';

final class AppName extends StatelessWidget {
  const AppName({
    super.key,
    this.color = AppColors.onSurfaceHigh,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Text(
        _kAppName,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          fontFamily: 'eurostileT',
        ),
      ),
    );
  }
}
