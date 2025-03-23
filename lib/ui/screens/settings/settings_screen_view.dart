import 'package:agents_explorer/core/configs/constants/app_images.dart';
import 'package:agents_explorer/core/configs/constants/app_size.dart';
import 'package:agents_explorer/core/configs/constants/app_strings.dart';
import 'package:agents_explorer/core/configs/theme/app_colors.dart';
import 'package:agents_explorer/core/configs/theme/app_text_styles.dart';
import 'package:agents_explorer/core/routing/app_navigation.dart';
import 'package:agents_explorer/core/theme/theme_controller.dart';
import 'package:agents_explorer/ui/widgets/app_bar.dart';
import 'package:agents_explorer/ui/widgets/scaffold.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

@RoutePage<void>()
class SettingsScreenView extends StatefulWidget {
  const SettingsScreenView({super.key});

  @override
  State<SettingsScreenView> createState() => _SettingsScreenViewState();
}

class _SettingsScreenViewState extends State<SettingsScreenView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ThemeController>.reactive(
      viewModelBuilder: () => ThemeController(),
      builder: (context, model, child) {
        return CustomScaffold(
          appBar: CustomAppBar(
            title: AppStrings.settings(),
            showLeading: true,
            leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColors.primary,
                  size: AppSize.icon,
                ),
                onPressed: () => AppNavigation.popRoute(context)),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(AppSize.padding),
              child: Column(
                children: [
                  subItemView(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            model.isDarkMode ? AppStrings.darkTheme() : AppStrings.lightTheme(),
                            style: AppTextStyles.body3_high(color: AppColors.primary),
                          ),
                        ),
                        Expanded(
                          child: Switch(
                            value: model.isDarkMode,
                            activeColor: AppColors.primary,
                            onChanged: (value) => model.toggleTheme(),
                            inactiveTrackColor: AppColors.onSurfaceMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSize.paddingHigh),
                  subItemView(
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          model.localization == "en" ? AppStrings.english() : AppStrings.turkish(),
                          style: AppTextStyles.body3_high(color: AppColors.primary),
                        )),
                        localizationView(
                          title: "Tr",
                          icon: AppImages.tr(),
                          isSelected: model.localization == "tr",
                          onPressed: () => model.toggleLocalization("tr", context),
                        ),
                        const SizedBox(width: AppSize.padding),
                        localizationView(
                          title: "Eng",
                          icon: AppImages.en(),
                          isSelected: model.localization == "en",
                          onPressed: () => model.toggleLocalization("en", context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget localizationView({
    required String title,
    required Widget icon,
    required bool isSelected,
    required Function() onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.paddingLow),
        border: isSelected ? Border.all(color: AppColors.primary) : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSize.paddingLow),
        child: Row(
          children: [
            Text(
              title,
              style: AppTextStyles.body3_high(color: AppColors.primary),
            ),
            IconButton(
              onPressed: () => onPressed(),
              icon: icon,
            )
          ],
        ),
      ),
    );
  }

  Widget subItemView({required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.paddingHigh, vertical: AppSize.paddingLow),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppSize.paddingLow),
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
      ),
      child: child,
    );
  }
}
