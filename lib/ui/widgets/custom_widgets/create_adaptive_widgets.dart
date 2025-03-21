import 'dart:io' show Platform;

import 'package:flutter/material.dart';

import 'cupertino_widgets.dart';
import 'custom_base_widgets.dart';
import 'material_widgets.dart';

final class CreateAdaptiveWidgets {
  static late CustomBaseWidgets _customBaseWidgets;

  factory CreateAdaptiveWidgets() {
    return _instance;
  }

  CreateAdaptiveWidgets._() {
    if (Platform.isAndroid) {
      _customBaseWidgets = MaterialWidgets();
    } else if (Platform.isIOS) {
      _customBaseWidgets = CupertinoWidgets();
    }
  }

  static final CreateAdaptiveWidgets _instance = CreateAdaptiveWidgets._();

  Widget adaptiveActivityIndicator({Color? color}) => _customBaseWidgets.createActivityIndicator().render(color);
}
