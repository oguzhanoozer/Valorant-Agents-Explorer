import 'package:flutter/material.dart';

abstract final class AppColors {
  // Base colors
  static const Color background = Color.fromARGB(255, 255, 255, 255);
  static const Color surface = Color.fromARGB(255, 242, 242, 242);
  static const Color primary = Color.fromARGB(255, 47, 172, 219);
  static const Color onPrimary = Color.fromARGB(255, 255, 255, 255);
  static const Color onSurfaceHigh = Color.fromARGB(255, 13, 13, 13);
  static const Color onSurfaceMedium = Color.fromARGB(255, 89, 89, 89);
  static const Color onSurfaceLow = Color.fromARGB(255, 128, 128, 128);

  // Gradient colors for buttons
  static const Color primaryButtonStart = Color.fromARGB(255, 24, 176, 206);
  static const Color primaryButtonEnd = Color.fromARGB(255, 36, 112, 162);
  static const Color cancelButtonStart = Color.fromARGB(255, 185, 185, 185);
  static const Color cancelButtonEnd = Color.fromARGB(255, 160, 160, 160);
  static const Color buttonStart = Color.fromARGB(255, 255, 64, 64);
  static const Color buttonEnd = Color.fromARGB(255, 196, 61, 61);
  static const Color disabledButtonForeground = Color.fromARGB(255, 170, 170, 170);

  // Other colors
  static const Color navigationBarBackground = background;
  static const Color navigationBarItemSelected = primary;
  static const Color navigationBarItemUnselected = onSurfaceLow;
  static const Color hyperTextColor = Colors.blue;
  static const Color icon = onSurfaceMedium;
  static const Color badge = Color.fromARGB(255, 234, 67, 206);
  static const Color markerMyLocation = Color.fromARGB(255, 81, 134, 236);

  static const Color taskPriorityLow = Color.fromRGBO(230, 236, 71, 1);
  static const Color taskPriorityMedium = Color.fromRGBO(236, 186, 84, 1);
  static const Color taskPriorityHigh = Color.fromRGBO(212, 98, 95, 1);
  static const Color taskExpiredOrCloseToDeadline = badge;
  static const Color taskStepperActive = Color.fromARGB(255, 133, 168, 181);
  static const Color taskStepperPassive = Color.fromARGB(255, 224, 224, 224);

  static const Color sensorActive = Color.fromARGB(255, 53, 219, 47);
  static const Color sensorUnreachable = Color.fromARGB(255, 150, 150, 150);

  static const Color shimmerBase = Color.fromARGB(255, 224, 224, 224);
  static const Color shimmerHighlight = Color.fromARGB(255, 245, 245, 245);
}
