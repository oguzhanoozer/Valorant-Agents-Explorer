import 'package:flutter/foundation.dart';

final class Rx<T> extends RxBase<T> {
  Rx(super.value);
}

final class Rxn<T> extends RxBase<T?> {
  Rxn([super.value]);
}

@optionalTypeArgs
abstract final class RxBase<T> extends ValueNotifier<T> {
  RxBase(super.value);

  void refresh() {
    notifyListeners();
  }

  T call({T Function()? set}) {
    if (set != null) {
      value = set();
    }
    return value;
  }
}
