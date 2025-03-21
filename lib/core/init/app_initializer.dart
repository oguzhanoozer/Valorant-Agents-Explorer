import 'app_locator.dart';

abstract final class AppInitializer {
  static Future<void> init() async {
    await AppLocator.initControllers();
  }
}
