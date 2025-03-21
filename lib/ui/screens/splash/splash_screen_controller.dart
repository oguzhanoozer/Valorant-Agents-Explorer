import '../../../core/exceptions/base_exception.dart';
import '../../../core/init/app_locator.dart';
import '../../../core/routing/app_navigation.dart';
import '../../../core/utils/dialog_utils.dart';
import '../base_screen_args.dart';
import '../base_screen_controller.dart';

final class SplashScreenController extends BaseScreenController<DefaultScreenArgs> {
  final Duration _minWaitDuration = const Duration(milliseconds: 2000);

  SplashScreenController(super.args);

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
          AppLocator.initServices(),
        ],
      );
      AppNavigation.goToMainScreen(context);
    } catch (e) {
      print(BaseException.from(e));
      await DialogUtils.showErrorDialog(context, message: BaseException.from(e).message);
      AppNavigation.goToSplashScreen(context);
    }
  }
}
