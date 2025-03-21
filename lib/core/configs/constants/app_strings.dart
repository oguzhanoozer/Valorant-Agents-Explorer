import '../../init/app_locator.dart';
import '../../services/localization/localization_service.dart';

enum AppStrings {
  login(),
  ok(),
  delete(),
  cancel(),
  save(),
  edit();

  String call([Map<String, dynamic> replaceMap = const <String, dynamic>{}]) {
    String result = get(name);
    replaceMap.forEach((String key, dynamic value) {
      result = result.replaceAll(key, '$value');
    });
    return result;
  }

  static String get(String key) => ServiceLocator.get<LocalizationService>().get(key);
}
