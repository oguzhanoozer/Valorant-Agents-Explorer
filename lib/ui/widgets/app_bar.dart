
import 'package:flutter/material.dart';

import '../../core/configs/constants/app_icons.dart';
import '../../core/configs/constants/app_size.dart';
import '../../core/configs/theme/app_colors.dart';
import '../../core/configs/theme/app_text_styles.dart';
import 'app_name.dart';
import 'icon_button.dart';

final class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.leading,
    this.title,
    this.titleWidget,
    this.actions,
    this.bottomWidget = const SizedBox(),
    this.bottomWidgetHeight = 0,
    this.elevation = AppSize.appBarElevation,
    this.showLeading = true,
    this.backgroundColor = AppColors.background,
  });

  const CustomAppBar.empty({Key? key})
      : this(
          key: key,
          title: '',
          elevation: 0,
          backgroundColor: Colors.transparent,
        );

  final Widget? leading;
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final Widget bottomWidget;
  final double bottomWidgetHeight;
  final double elevation;
  final bool showLeading;
  final Color backgroundColor;

  @override
  Size get preferredSize => Size.fromHeight(AppSize.appBarHeight + bottomWidgetHeight);

  @override
  Widget build(BuildContext context) {
    final Widget? leading = switch (showLeading) {
      false => null,
      true => this.leading ??
          () {
            final ModalRoute<dynamic>? parent = ModalRoute.of(context);
            return switch (parent != null && !parent.isFirst && (parent.canPop || parent.impliesAppBarDismissal)) {
              false => null,
              true => CustomIconButton(
                  onTap: () => Navigator.maybePop(context),
                  icon: switch (parent is PageRoute<dynamic> && parent.fullscreenDialog) {
                    true => AppIcons.logo,
                    false => AppIcons.logo,
                  }(
                    size: AppSize.icon,
                    color: AppColors.onSurfaceHigh,
                  ),
                )
            };
          }()
    };

    return Material(
      elevation: elevation,
      color: Colors.transparent,
      child: AppBar(
        elevation: 0,
        toolbarHeight: AppSize.appBarHeight,
        backgroundColor: backgroundColor,
        automaticallyImplyLeading: false,
        leading: leading,
        centerTitle: false,
        titleSpacing: leading != null ? 0 : null,
        title: titleWidget ??
            switch (title) {
              final String title => Text(
                  title,
                  style: AppTextStyles.title(),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              _ => const AppName()
            },
        actions: actions,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(bottomWidgetHeight),
          child: bottomWidget,
        ),
      ),
    );
  }
}
