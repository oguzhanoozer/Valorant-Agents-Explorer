import 'package:agents_explorer/ui/screens/agent/agent/agent_screen_list_view.dart';
import 'package:agents_explorer/ui/screens/agent/agent_detail/agent_detail_screen_args.dart';
import 'package:agents_explorer/ui/screens/agent/agent_detail/agent_detail_screen_view.dart';
import 'package:agents_explorer/ui/screens/favorites/favorites_screen_view.dart';
import 'package:agents_explorer/ui/screens/settings/settings_screen_view.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../ui/screens/base_screen_args.dart';
import '../../ui/screens/main/main_screen_view.dart';
import '../../ui/screens/splash/splash_screen_view.dart';
import 'app_navigation.dart';
import 'guards/auth_guards.dart';
import 'observers/navigation_observer.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
final class AppRouter extends _$AppRouter implements AutoRouteGuard {
  AppRouter({
    required super.navigatorKey,
  });

  @override
  List<AutoRoute> routes = <AutoRoute>[
    RedirectRoute(path: '/', redirectTo: '/splash'),
    AutoRoute(
      path: '/splash',
      page: SplashScreenRoute.page,
      fullscreenDialog: true,
      type: const RouteType.custom(
        transitionsBuilder: TransitionsBuilders.noTransition,
      ),
    ),
    AutoRoute(
      path: '/main',
      page: MainScreenRoute.page,
      fullscreenDialog: true,
      guards: <AutoRouteGuard>[
        AuthGuard(),
      ],
      children: <AutoRoute>[
        RedirectRoute(path: '', redirectTo: 'agent-list'),
        AutoRoute(path: 'agent-list', page: AgentScreenListRoute.page),
        AutoRoute(path: 'favorites', page: FavoritesScreenRoute.page),
      ],
    ),
    AutoRoute(path: '/settings', page: SettingsScreenRoute.page),
    AutoRoute(path: '/agent-detail', page: AgentDetailScreenRoute.page),
    RedirectRoute(path: '*', redirectTo: '/unknown'),
  ];

  @override
  RouteType get defaultRouteType => const RouteType.cupertino();

  RouterConfig<UrlState> get routerConfig {
    return super.config(
      deepLinkBuilder: (PlatformDeepLink deepLink) {
        return DeepLink.defaultPath;
      },
      navigatorObservers: () {
        return <NavigatorObserver>[
          NavigationObserver(),
        ];
      },
    );
  }

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    AppNavigation.unFocus();
    resolver.next();
  }
}
