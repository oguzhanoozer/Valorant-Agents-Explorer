import 'package:flutter/material.dart';

abstract final class AppSize {
  static const double padding = 16;
  static const double paddingLow = 8;
  static const double paddingLowest = 4;
  static const double paddingHigh = 24;

  static const double icon = 24;
  static const double iconHigh = 30;

  static const double navigationBarHeight = 96;
  static const double navigationBarIconSize = 30;

  static const double floatingActionButtonSize = 56;

  static const double appBarHeight = 56;
  static const double appBarElevation = 1;

  static const double dividerThickness = 0.33;

  static const double tabBarHeight = 46;
  static const double tabBarIndicatorWeight = 2;

  static const double textFieldHeight = 48;
  static const double textFieldPaddingVertical = 8;
  static const double textFieldPaddingHorizontal = 20;
  static const double textFieldRadius = textFieldHeight / 2;

  static const double iconButtonSize = 40;
  static const double iconButtonElevation = 4;

  static const double avatarSize = 30;

  static const double labelButtonMinSize = 48;
  static const double labelButtonElevation = 4;
  static const int labelButtonMaxLines = 2;
  static const EdgeInsets labelButtonPadding = EdgeInsets.symmetric(horizontal: paddingHigh, vertical: paddingLow);
  static const EdgeInsets labelButtonWithIconPadding = EdgeInsets.only(right: paddingLow);

  static const double cupertinoActivityIndicatorRadius = 16;
  static const double materialActivityIndicatorStrokeWidth = 3;
}
