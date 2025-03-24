import 'package:agents_explorer/core/configs/constants/app_strings.dart';
import 'package:agents_explorer/ui/screens/splash/splash_screen_screen_args.dart';

import '../../../core/routing/app_navigation.dart';
import '../../../core/utils/dialog_utils.dart';
import '../base_screen_controller.dart';

final class SplashScreenController extends BaseScreenController<SplashScreenScreenArgs> {
  final Duration _minWaitDuration = const Duration(milliseconds: 2000);
  final String? loadingText;
  SplashScreenController(super.args) : loadingText = args.loadingText;

  @override
  Future<void> onInitState() async {
    super.onInitState();
    _handleInitialization();
  }

  void _handleInitialization() async {
    try {
      await Future.wait<void>(
        <Future<void>>[
          Future<void>.delayed(_minWaitDuration),

          /// TODO: Checking process will be handled here.
        ],
      );
      AppNavigation.goToMainScreen(context);
    } catch (e) {
      DialogUtils.showErrorDialog(context, message: AppStrings.errorOccured()).then((_) => pop());
      AppNavigation.goToSplashScreen(context, args: const SplashScreenScreenArgs());
    }
  }
}
