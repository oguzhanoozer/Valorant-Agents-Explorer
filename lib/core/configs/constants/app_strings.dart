import '../../init/app_locator.dart';
import '../../services/localization/localization_service.dart';

enum AppStrings {
  ok(),
  delete(),
  cancel(),
  save(),
  edit(),
  appTitle(),
  favoriteAgentsTitle(),
  addFavoriteAgentTitle(),
  editFavoriteAgentTitle(),
  deleteAgentMessage(),
  selectProcess(),
  errorOccured(),
  errorOccuredWhenFavAgentsLoading(),
  deleteAgentSuccessfulTitle(),
  editAgentSuccessfulTitle(),
  enterTitleAndDescription(),
  favoriteAgentNotSaved(),
  titleNotSameBeforeTitle(),
  list(),
  favorite(),
  emptyList(),
  emptyFavoriteList(),
  agents(),
  favAgents(),
  abilities(),
  description(),
  developer(),
  releaseDate(),
  displayName(),
  role(),
  enterDescription(),
  enterTitle(),
  turkish(),
  english(),
  darkTheme(),
  lightTheme(),
  settings(),
  loadingData(),
  languageChangesApplying();

  String call([Map<String, dynamic> replaceMap = const <String, dynamic>{}]) {
    String result = get(name);
    replaceMap.forEach((String key, dynamic value) {
      result = result.replaceAll(key, '$value');
    });
    return result;
  }

  static String get(String key) => ServiceLocator.get<LocalizationService>().get(key);
}
