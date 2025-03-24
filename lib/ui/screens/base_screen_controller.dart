import 'package:flutter/widgets.dart';

import '../../core/utils/app_logger.dart';
import 'base_screen_args.dart';
import 'package:stacked/stacked.dart';

import 'package:flutter/material.dart';

abstract base class BaseScreenController<A extends BaseScreenArgs> extends BaseViewModel with WidgetsBindingObserver {
  final ViewState viewState = ViewState();
  BuildContext? _context;

  BaseScreenController(A args);

  BuildContext? get context => _context;

  void setContext(BuildContext context) {
    _context = context;
    notifyListeners();
  }

  @mustCallSuper
  Future<void> onInitState() async {
    AppLogger.debug(runtimeType);
  }

  @mustCallSuper
  void onDispose() {
    AppLogger.debug(runtimeType);
  }

  void pop([void Function()? f]) {
    if (_context != null) {
      Navigator.of(_context!).pop();
      f?.call();
    }
  }

  @mustCallSuper
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}
}

final class ViewState extends BaseViewModel {
  bool _loading = false;

  bool get isLoading => _loading;

  void setBusy(bool status) {
    setBusy(status);
    notifyListeners();
  }

  void setLoading(bool status) {
    _loading = status;
    notifyListeners();
  }
}
