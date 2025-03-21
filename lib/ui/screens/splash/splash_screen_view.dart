import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../core/configs/constants/app_size.dart';
import '../../widgets/app_name.dart';
import '../../widgets/scaffold.dart';
import '../base_screen_args.dart';
import '../base_screen_view.dart';
import 'splash_screen_controller.dart';

const Color _kLogoColor = Colors.white;

@RoutePage<void>()
final class SplashScreenView extends BaseScreenView<SplashScreenController, DefaultScreenArgs> {
  const SplashScreenView({
    super.key,
    super.args = const DefaultScreenArgs(),
  }) : super(
          safeArea: const ScaffoldSafeArea(bottom: false),
        );

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

final class _SplashScreenViewState extends BaseScreenViewState<SplashScreenView, SplashScreenController, DefaultScreenArgs> {
  @override
  CustomScaffold builder(BuildContext context, SplashScreenController controller) {
    return CustomScaffold(
      body: Center(
        child: Text("Splash"),
      ),
    );
  }

  Widget _buildLogo({
    required Alignment alignment,
    required double aspectRatio,
    required double widthFactor,
    required Widget logo,
  }) {
    return SafeArea(
      child: Align(
        alignment: alignment,
        child: AspectRatio(
          aspectRatio: aspectRatio,
          child: FractionallySizedBox(
            widthFactor: widthFactor,
            child: logo,
          ),
        ),
      ),
    );
  }
}
