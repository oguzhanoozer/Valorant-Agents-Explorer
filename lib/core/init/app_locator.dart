import 'package:agents_explorer/core/services/theme/theme_service.dart';
import 'package:agents_explorer/ui/screens/agent/agent/agent_screen_controller.dart';
import 'package:agents_explorer/ui/screens/agent/agent_detail/agent_detail_screen_args.dart';
import 'package:agents_explorer/ui/screens/agent/agent_detail/agent_detail_screen_controller.dart';
import 'package:agents_explorer/ui/screens/splash/splash_screen_screen_args.dart';
import 'package:get_it/get_it.dart';

import '../../ui/screens/base_screen_args.dart';
import '../../ui/screens/base_screen_controller.dart';
import '../../ui/screens/splash/splash_screen_controller.dart';
import '../services/api/api_service.dart';
import '../services/base_service.dart';
import '../services/local_storage/local_storage_service.dart';
import '../services/localization/localization_service.dart';

abstract final class AppLocator {
  static Future<void> initControllers() async {
    await ControllerLocator._init();
  }

  static Future<void> initServices() async {
    await ServiceLocator._init();
  }
}

abstract final class ControllerLocator {
  static final GetIt _locator = GetIt.asNewInstance();
  static final Map<String, dynamic> _controllers = <String, dynamic>{};

  static Future<void> _init() async {
    await _locator.reset(dispose: true);
    _controllers.clear();
    _register();
  }

  static void _register() {
    void registerController<C extends BaseScreenController<A>, A extends BaseScreenArgs>(
      C Function(A args) factoryFunc, {
      String? instanceName,
    }) {
      _locator.registerFactoryParam<C, A, void>(
        (A args, _) => factoryFunc(args),
        instanceName: instanceName,
      );
    }

    registerController<SplashScreenController, SplashScreenScreenArgs>(
      (_) => SplashScreenController(_),
    );

    registerController<AgentScreenController, DefaultScreenArgs>(
      (_) => AgentScreenController(
        _,
        () => ServiceLocator.get<ApiService>(),
        () => ServiceLocator.get<LocalStorageService>(),
      ),
    );

    registerController<AgentDetailScreenController, AgentDetailScreenArgs>(
      (_) => AgentDetailScreenController(
        _,
        () => ServiceLocator.get<ApiService>(),
      ),
    );
  }

  static String _getControllerKey<C extends BaseScreenController<BaseScreenArgs>>(int hashCode) {
    return '$hashCode-$C';
  }

  static C get<C extends BaseScreenController<BaseScreenArgs>>(int hashCode) {
    return _controllers[_getControllerKey<C>(hashCode)];
  }

  static C create<C extends BaseScreenController<A>, A extends BaseScreenArgs>(int hashCode, A args) {
    return _controllers.putIfAbsent(
      _getControllerKey<C>(hashCode),
      () => _locator.get<C>(
        param1: args,
      ),
    );
  }

  static void dispose<C extends BaseScreenController<BaseScreenArgs>>(int hashCode) {
    get<C>(hashCode).onDispose();
    _controllers.remove(_getControllerKey<C>(hashCode));
  }
}

abstract final class ServiceLocator {
  static final GetIt _locator = GetIt.asNewInstance();

  static Future<void> _init() async {
    await _locator.reset(dispose: true);
    _register();
    await _locator.allReady();
  }

  static void _register() {
    void registerService<S extends BaseService<S>>(
      S Function() getInstance, {
      String? instanceName,
      Iterable<Type>? dependsOn,
    }) {
      _locator.registerSingletonAsync<S>(
        () => getInstance().init(),
        instanceName: instanceName,
        dependsOn: dependsOn,
        dispose: (S instance) => instance.dispose(),
      );
    }

    registerService<LocalStorageService>(
      () => LocalStorageService(),
    );

    registerService<ApiService>(
      () => ApiService(),
    );
    registerService<LocalizationService>(
      () => LocalizationService(),
    );

    registerService<ThemeService>(
      () => ThemeService(),
      dependsOn: <Type>[LocalStorageService],
    );
  }

  static T get<T extends Object>() => _locator.get<T>();
}
