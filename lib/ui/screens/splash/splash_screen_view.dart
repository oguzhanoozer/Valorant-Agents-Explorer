import 'package:agents_explorer/core/configs/constants/app_images.dart';
import 'package:agents_explorer/core/configs/constants/app_size.dart';
import 'package:agents_explorer/core/configs/constants/app_strings.dart';
import 'package:agents_explorer/core/configs/theme/app_colors.dart';
import 'package:agents_explorer/core/configs/theme/app_text_styles.dart';
import 'package:agents_explorer/ui/screens/splash/splash_screen_screen_args.dart';
import 'package:agents_explorer/ui/widgets/custom_widgets/create_adaptive_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../widgets/scaffold.dart';
import '../base_screen_view.dart';
import 'splash_screen_controller.dart';

@RoutePage<void>()
final class SplashScreenView extends BaseScreenView<SplashScreenController, SplashScreenScreenArgs> {
  const SplashScreenView({
    super.key,
    super.args = const SplashScreenScreenArgs(),
  }) : super(
          safeArea: const ScaffoldSafeArea(bottom: false),
        );

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

final class _SplashScreenViewState extends BaseScreenViewState<SplashScreenView, SplashScreenController, SplashScreenScreenArgs> {
  @override
  CustomScaffold builder(BuildContext context, SplashScreenController controller) {
    return CustomScaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          SizedBox.expand(
            child: AppImages.splash_background(fit: BoxFit.cover),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CreateAdaptiveWidgets().adaptiveActivityIndicator(
                  color: AppColors.primary,
                ),
                const SizedBox(
                  height: AppSize.paddingHigh,
                ),
                Text(
                  controller.loadingText ?? AppStrings.loadingData(),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.title(color: AppColors.onSurfaceMedium),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
