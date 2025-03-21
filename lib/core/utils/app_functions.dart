import 'package:agents_explorer/core/models/agents/api/agent_model.dart';

abstract final class AppFunctions {
  static void Function()? refreshAgentList;
  static void Function(bool isFavorite, {FavoriteModel? favoriteModel})? refreshAgentDetail;
}
