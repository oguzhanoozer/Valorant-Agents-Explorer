import 'package:flutter/material.dart';

import '../../../../core/configs/constants/app_size.dart';
import '../../../../core/configs/constants/app_strings.dart';
import '../../../../core/configs/theme/app_colors.dart';
import '../../../../core/configs/theme/app_text_styles.dart';
import '../../../widgets/gesture_detector.dart';

final class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.activeIndex,
    required this.setActiveIndex,
    required this.items,
  });

  final int activeIndex;
  final void Function(int index) setActiveIndex;
  final List<CustomBottomNavigationBarItem> items;

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

final class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  final ScrollController scrollController = ScrollController();
  bool isSosAnimationCompleted = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Widget navigationBar = SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widget.items.asMap().entries.map((MapEntry<int, CustomBottomNavigationBarItem> item) {
          return Expanded(
            child: CustomGestureDetector(
              onTap: () => widget.setActiveIndex(item.key),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        item.value.iconWidget(
                          size: AppSize.navigationBarIconSize,
                          color: switch (item.key == widget.activeIndex) {
                            true => AppColors.navigationBarItemSelected,
                            false => AppColors.navigationBarItemUnselected,
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSize.paddingLowest),
                  Text(
                    item.value.label(),
                    style: AppTextStyles.body1_medium(),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );

    return Container(
      height: AppSize.navigationBarHeight,
      decoration: const BoxDecoration(
        color: AppColors.navigationBarBackground,
        border: Border(
          top: BorderSide(
            width: AppSize.dividerThickness,
            color: AppColors.onSurfaceLow,
          ),
        ),
      ),
      child: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        physics: const PageScrollPhysics(),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            navigationBar,
          ],
        ),
      ),
    );
  }
}

final class CustomBottomNavigationBarItem {
  final IconData icon;
  final AppStrings label;

  const CustomBottomNavigationBarItem({
    required this.icon,
    required this.label,
  });

  Widget iconWidget({
    required double size,
    required Color color,
  }) {
    return Icon(
      icon,
      size: size,
      color: color,
    );
  }
}
