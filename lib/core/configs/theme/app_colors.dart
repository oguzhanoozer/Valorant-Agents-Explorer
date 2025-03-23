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

  static const Color sensorActive = Color.fromARGB(255, 53, 219, 47);
  static const Color sensorUnreachable = Color.fromARGB(255, 150, 150, 150);

  static const Color shimmerBase = Color.fromARGB(255, 224, 224, 224);
  static const Color shimmerHighlight = Color.fromARGB(255, 245, 245, 245);

  // Base colors
  static const Color backgroundDark = Color.fromARGB(255, 30, 29, 29);
  static const Color surfaceDark = Color.fromARGB(255, 30, 30, 30);
  static const Color primaryDark = Color.fromARGB(255, 30, 130, 160);
  static const Color onPrimaryDark = Color.fromARGB(255, 255, 255, 255);
  static const Color onSurfaceHighDark = Color.fromARGB(255, 255, 255, 255);
  static const Color onSurfaceMediumDark = Color.fromARGB(255, 180, 180, 180);
  static const Color onSurfaceLowDark = Color.fromARGB(255, 120, 120, 120);

// Gradient colors for buttons
  static const Color primaryButtonStartDark = Color.fromARGB(255, 15, 110, 130);
  static const Color primaryButtonEndDark = Color.fromARGB(255, 23, 70, 102);
  static const Color cancelButtonStartDark = Color.fromARGB(255, 115, 115, 115);
  static const Color cancelButtonEndDark = Color.fromARGB(255, 100, 100, 100);
  static const Color buttonStartDark = Color.fromARGB(255, 160, 40, 40);
  static const Color buttonEndDark = Color.fromARGB(255, 124, 39, 39);
  static const Color disabledButtonForegroundDark = Color.fromARGB(255, 100, 100, 100);

// Other colors
  static const Color navigationBarBackgroundDark = backgroundDark;
  static const Color navigationBarItemSelectedDark = primaryDark;
  static const Color navigationBarItemUnselectedDark = onSurfaceLowDark;
  static const Color hyperTextColorDark = Colors.blue;
  static const Color iconDark = onSurfaceMediumDark;
  static const Color badgeDark = Color.fromARGB(255, 148, 42, 130);
  static const Color markerMyLocationDark = Color.fromARGB(255, 51, 85, 150);

  static const Color sensorActiveDark = Color.fromARGB(255, 34, 139, 34);
  static const Color sensorUnreachableDark = Color.fromARGB(255, 95, 95, 95);

  static const Color shimmerBaseDark = Color.fromARGB(255, 50, 50, 50);
  static const Color shimmerHighlightDark = Color.fromARGB(255, 70, 70, 70);
}
