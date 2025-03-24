import 'package:flutter/widgets.dart';

import '../utils/app_logger.dart';

typedef Service<S> = S Function();

abstract base class BaseService<S> with WidgetsBindingObserver {
  const BaseService();

  /// if you use any services in the init() function,
  /// you must add these services to the dependsOn,
  /// parameter of this service when registering

  @mustCallSuper
  Future<S> init() async {
    AppLogger.debug('$runtimeType.init');
    WidgetsBinding.instance.addObserver(this);
    return this as S;
  }

  @mustCallSuper
  void dispose() {
    AppLogger.debug('$runtimeType.dispose');
    WidgetsBinding.instance.removeObserver(this);
  }
}
