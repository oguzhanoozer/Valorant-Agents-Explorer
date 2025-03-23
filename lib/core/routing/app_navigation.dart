import 'package:agents_explorer/ui/screens/agent/agent_detail/agent_detail_screen_args.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

import 'app_router.dart';

abstract final class AppNavigation {
  static final AppRouter _router = AppRouter(navigatorKey: rootNavigatorKey);
  static final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
  static final GlobalKey<NavigatorState> movieNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'movie');
  static final GlobalKey<NavigatorState> agentNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'agent');
  static final GlobalKey<NavigatorState> tabSecondNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'tabSecond');
  static final GlobalKey<NavigatorState> tabThirdNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'tabThird');
  static final GlobalKey<NavigatorState> tabFourNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'tabFour');

  static RouterConfig<Object> get routerConfig => _router.routerConfig;

  static void unFocus([UnfocusDisposition disposition = UnfocusDisposition.scope]) {
    FocusManager.instance.primaryFocus?.unfocus(
      disposition: disposition,
    );
  }

  static Future<void> popRoute<T>(BuildContext? context, [T? result]) async {
    await context?.popRoute<T>(result);
  }

  static void goToSplashScreen(BuildContext? context) {
    (context ?? rootNavigatorKey.currentContext)?.router.replaceAll(
      <PageRouteInfo>[SplashScreenRoute()],
      updateExistingRoutes: false,
    );
  }

  static void goToMainScreen(BuildContext? context) {
    context?.router.replaceAll(<PageRouteInfo>[MainScreenRoute()]);
  }

  static void goToAgentDetail(BuildContext? context, {required AgentDetailScreenArgs args}) {
    context?.pushRoute(AgentDetailScreenRoute(args: args));
  }

  static void goToSettings(BuildContext? context) {
    context?.pushRoute(const SettingsScreenRoute());
  }
}
