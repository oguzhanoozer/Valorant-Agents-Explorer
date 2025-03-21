import 'dart:async';
import 'dart:convert' show jsonDecode, jsonEncode;

import 'package:agents_explorer/core/configs/constants/app_strings.dart';
import 'package:agents_explorer/core/models/agents/api/agent_model.dart';
import 'package:agents_explorer/core/models/rx.dart';
import 'package:agents_explorer/core/routing/app_navigation.dart';
import 'package:agents_explorer/core/routing/app_router.dart';
import 'package:agents_explorer/core/services/local_storage/local_storage_service.dart';
import 'package:agents_explorer/core/utils/dialog_utils.dart';
import 'package:agents_explorer/ui/screens/agent/agent_detail/agent_detail_screen_args.dart';
import 'package:agents_explorer/ui/screens/base_screen_args.dart';
import 'package:agents_explorer/ui/screens/base_screen_controller.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../core/exceptions/api_exception.dart';
import '../../../../../core/models/result.dart';
import '../../../../../core/services/api/api_service.dart';
import '../../../../../core/services/base_service.dart';
import '../../../../../core/utils/app_functions.dart';

const int _requestPageSize = 10;

final class PageItem {
  final PageRouteInfo page;
  final IconData icon;
  final AppStrings label;

  PageItem({
    required this.page,
    required this.icon,
    required this.label,
  });
}

final class AgentScreenController extends BaseScreenController<DefaultScreenArgs> {
  final Service<ApiService> _apiService;
  final Service<LocalStorageService> _localStorageService;
  final GlobalKey<ScaffoldState> mapScaffoldKey = GlobalKey<ScaffoldState>();
  List<AgentData> agentList = [];
  List<AgentData> _visibleAgents = [];

  List<AgentData> favoriteAgentList = [];
  final Rx<void> fetchNotifier = Rx<void>(null);
  final List<PageItem> pages;

  int get pageSize => _requestPageSize;

  AgentScreenController(
    super.args,
    this._apiService,
    this._localStorageService,
  ) : pages = <PageItem>[
          PageItem(
            page: AgentScreenListRoute(),
            icon: Icons.list,
            label: AppStrings.login,
          ),
          PageItem(
            page: FavoritesScreenRoute(),
            icon: Icons.favorite,
            label: AppStrings.login,
          ),
        ];

  @override
  Future<void> onInitState() async {
    super.onInitState();
  }

  @override
  void onDispose() {
    _disposeAppFunctions();
    super.onDispose();
  }

  Future<List<AgentData>> loadFavorites(int page) async {
    try {
      final String? favoritesJson = await _localStorageService().read(Keys.favoriteAgents);
      if (favoritesJson != null) {
        final List<dynamic> favoritesList = jsonDecode(favoritesJson);
        List<AgentData> tempList = [];

        tempList = favoritesList.map((json) => AgentData.fromJson(json).copyWith(isFavorite: true)).toList();
        favoriteAgentList = tempList;
      }
      notifyListeners();
      return favoriteAgentList;
    } catch (e) {
      rethrow;
    }
  }

  bool isFavorite(AgentData agent) {
    return favoriteAgentList.any((favorite) => favorite.uuid == agent.uuid);
  }

  Future<void> addFavorite(AgentData agent) async {
    if (!isFavorite(agent)) {
      favoriteAgentList.add(agent);
      await _saveFavorites();
    } else {
      final index = favoriteAgentList.indexWhere((favorite) => favorite.uuid == agent.uuid);
      favoriteAgentList[index] = agent;
    }
    await _saveFavorites();

    notifyListeners();
  }

  Future<void> deleteFavorite(AgentData agent, {bool isForFavorite = false}) async {
    if (isFavorite(agent)) {
      favoriteAgentList.removeWhere((favorite) => favorite.uuid == agent.uuid);
      final updatedAgent = agent.copyWith(isFavorite: false);

      updateAgent(updatedAgent, isFavorite: false);
      await _saveFavorites();
      if (isForFavorite) {
        AppFunctions.refreshAgentDetail?.call(false);
      }
    }
    fetchNotifier.refresh();

    notifyListeners();
  }

  void updateAgent(AgentData updatedAgent, {required bool isFavorite, FavoriteModel? favoriteModel}) {
    final int index = _visibleAgents.indexWhere((agent) => agent.uuid == updatedAgent.uuid);
    if (index != -1) {
//      agentList[index].copyWith(isFavorite: false, favoriteModel: null);
      _visibleAgents[index] = updatedAgent;
    }
    fetchNotifier.refresh();
    notifyListeners();
  }

  int currentIndex(String uuid) => _visibleAgents.indexWhere((agent) => agent.uuid == uuid);

  Future<void> showFavoriteDialog(AgentData agent, {bool isForFavorite = false}) async {
    String? option;

    if (agent.isFavorite) {
      await DialogUtils.showUpdateOrDeleteDialog(
        context,
        primaryButtonText: AppStrings.edit,
        secondaryButtonText: AppStrings.delete,
        onPrimaryApply: () => option = "update",
        onSecondaryApply: () async => option = "delete",
      );

      if (option != null) {
        if (option == "update") {
          await showUpdatePopUp(agent, isForFavorite: isForFavorite);
        } else if (option == "delete") {
          await showDeleteDialog(agent, isForFavorite: isForFavorite);
        }
      }
    } else {
      await showUpdatePopUp(agent, isForFavorite: isForFavorite);
    }
  }

  Future<void> showDeleteDialog(AgentData agent, {bool isForFavorite = false}) async {
    DialogUtils.showDeleteFavoriteItemDialog(
      context,
      onApply: () => deleteFavorite(agent, isForFavorite: isForFavorite),
    );
  }

  Future<void> showUpdatePopUp(AgentData agent, {bool isForFavorite = false}) async {
    final currentFavModel = favoriteAgentList.where((agentVal) => agentVal.uuid == agent.uuid).firstOrNull?.favoriteModel;

    await DialogUtils.showTextInputDialog(
      context,
      message: 'Enter Favorite Title and Description',
      initialTitleValue: currentFavModel?.title,
      initialDescriptionValue: currentFavModel?.description,
      onApply: (title, description) async {
        FavoriteModel? favoriteModel = FavoriteModel(title: title, description: description);
        await toggleFavoriteUpdate(agent, isForFavorite: isForFavorite, favoriteModel: favoriteModel);
      },
    );
  }

  Future<void> toggleFavoriteUpdate(AgentData agent, {bool isForFavorite = false, FavoriteModel? favoriteModel}) async {
    if (favoriteModel != null) {
      final updatedAgent = agent.copyWith(isFavorite: true, favoriteModel: favoriteModel);

      await addFavorite(updatedAgent);
      updateAgent(updatedAgent, favoriteModel: favoriteModel, isFavorite: true);
      fetchNotifier.refresh();

      notifyListeners();

      if (isForFavorite) {
        AppFunctions.refreshAgentDetail?.call(true, favoriteModel: favoriteModel);
      }
    }
  }

  Future<void> _saveFavorites() async {
    final List<Map<String, dynamic>> favoritesJson = favoriteAgentList.map((agent) => agent.toMap()).toList();
    await _localStorageService().write(Keys.favoriteAgents, jsonEncode(favoritesJson));
  }

  void onTapListItem(AgentData agentItem) {
    AppNavigation.goToAgentDetail(
      context,
      args: AgentDetailScreenArgs(
          movieId: agentItem.uuid ?? '',
          isFavorite: agentItem.isFavorite,
          onUpdateList: () async {
            int index = currentIndex(agentItem.uuid ?? '');
            await showFavoriteDialog(agentList[index], isForFavorite: true);
          }),
    );
  }

  void _disposeAppFunctions() => AppFunctions.refreshAgentDetail = null;

  Future<List<AgentData>> fetch(int page) async {
    await loadFavorites(0);
    int _page = page + 1;

    if (agentList.isNotEmpty) {
      _loadMoreAgents(_page);
      return _visibleAgents;
    }

    return await _apiService().agent.getAgentsList().then(
      (Result<List<AgentData>, ApiException> result) {
        return result.on(
          success: (List<AgentData> data) {
            agentList = data
                .map((agent) => agent.copyWith(
                      isFavorite: favoriteAgentList.any((fav) => fav.uuid == agent.uuid),
                    ))
                .toList();
            _loadMoreAgents(_page == 0 ? 1 : _page);
            return _visibleAgents;
          },
          failure: (ApiException e) => throw e,
        );
      },
    );
  }

  void _loadMoreAgents(int pageNumber) {
    if (pageNumber >= 1) {
      _visibleAgents.clear();
      final List<AgentData> nextItems = agentList.skip((pageNumber - 1) * pageSize).take(pageSize).toList();
      _visibleAgents = nextItems;
      notifyListeners();
    }
  }
}
