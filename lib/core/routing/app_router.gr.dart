// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AgentDetailScreenRoute.name: (routeData) {
      final args = routeData.argsAs<AgentDetailScreenRouteArgs>();
      return AutoRoutePage<void>(
        routeData: routeData,
        child: AgentDetailScreenView(
          key: args.key,
          args: args.args,
        ),
      );
    },
    AgentScreenListRoute.name: (routeData) {
      return AutoRoutePage<void>(
        routeData: routeData,
        child: const AgentScreenListView(),
      );
    },
    FavoritesScreenRoute.name: (routeData) {
      return AutoRoutePage<void>(
        routeData: routeData,
        child: const FavoritesScreenView(),
      );
    },
    MainScreenRoute.name: (routeData) {
      final args = routeData.argsAs<MainScreenRouteArgs>(
          orElse: () => const MainScreenRouteArgs());
      return AutoRoutePage<void>(
        routeData: routeData,
        child: MainScreenView(
          key: args.key,
          args: args.args,
        ),
      );
    },
    SettingsScreenRoute.name: (routeData) {
      return AutoRoutePage<void>(
        routeData: routeData,
        child: const SettingsScreenView(),
      );
    },
    SplashScreenRoute.name: (routeData) {
      final args = routeData.argsAs<SplashScreenRouteArgs>(
          orElse: () => const SplashScreenRouteArgs());
      return AutoRoutePage<void>(
        routeData: routeData,
        child: SplashScreenView(
          key: args.key,
          args: args.args,
        ),
      );
    },
  };
}

/// generated route for
/// [AgentDetailScreenView]
class AgentDetailScreenRoute extends PageRouteInfo<AgentDetailScreenRouteArgs> {
  AgentDetailScreenRoute({
    Key? key,
    required AgentDetailScreenArgs args,
    List<PageRouteInfo>? children,
  }) : super(
          AgentDetailScreenRoute.name,
          args: AgentDetailScreenRouteArgs(
            key: key,
            args: args,
          ),
          initialChildren: children,
        );

  static const String name = 'AgentDetailScreenRoute';

  static const PageInfo<AgentDetailScreenRouteArgs> page =
      PageInfo<AgentDetailScreenRouteArgs>(name);
}

class AgentDetailScreenRouteArgs {
  const AgentDetailScreenRouteArgs({
    this.key,
    required this.args,
  });

  final Key? key;

  final AgentDetailScreenArgs args;

  @override
  String toString() {
    return 'AgentDetailScreenRouteArgs{key: $key, args: $args}';
  }
}

/// generated route for
/// [AgentScreenListView]
class AgentScreenListRoute extends PageRouteInfo<void> {
  const AgentScreenListRoute({List<PageRouteInfo>? children})
      : super(
          AgentScreenListRoute.name,
          initialChildren: children,
        );

  static const String name = 'AgentScreenListRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [FavoritesScreenView]
class FavoritesScreenRoute extends PageRouteInfo<void> {
  const FavoritesScreenRoute({List<PageRouteInfo>? children})
      : super(
          FavoritesScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavoritesScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MainScreenView]
class MainScreenRoute extends PageRouteInfo<MainScreenRouteArgs> {
  MainScreenRoute({
    Key? key,
    DefaultScreenArgs args = const DefaultScreenArgs(),
    List<PageRouteInfo>? children,
  }) : super(
          MainScreenRoute.name,
          args: MainScreenRouteArgs(
            key: key,
            args: args,
          ),
          initialChildren: children,
        );

  static const String name = 'MainScreenRoute';

  static const PageInfo<MainScreenRouteArgs> page =
      PageInfo<MainScreenRouteArgs>(name);
}

class MainScreenRouteArgs {
  const MainScreenRouteArgs({
    this.key,
    this.args = const DefaultScreenArgs(),
  });

  final Key? key;

  final DefaultScreenArgs args;

  @override
  String toString() {
    return 'MainScreenRouteArgs{key: $key, args: $args}';
  }
}

/// generated route for
/// [SettingsScreenView]
class SettingsScreenRoute extends PageRouteInfo<void> {
  const SettingsScreenRoute({List<PageRouteInfo>? children})
      : super(
          SettingsScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SplashScreenView]
class SplashScreenRoute extends PageRouteInfo<SplashScreenRouteArgs> {
  SplashScreenRoute({
    Key? key,
    DefaultScreenArgs args = const DefaultScreenArgs(),
    List<PageRouteInfo>? children,
  }) : super(
          SplashScreenRoute.name,
          args: SplashScreenRouteArgs(
            key: key,
            args: args,
          ),
          initialChildren: children,
        );

  static const String name = 'SplashScreenRoute';

  static const PageInfo<SplashScreenRouteArgs> page =
      PageInfo<SplashScreenRouteArgs>(name);
}

class SplashScreenRouteArgs {
  const SplashScreenRouteArgs({
    this.key,
    this.args = const DefaultScreenArgs(),
  });

  final Key? key;

  final DefaultScreenArgs args;

  @override
  String toString() {
    return 'SplashScreenRouteArgs{key: $key, args: $args}';
  }
}
