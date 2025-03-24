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
  List<AgentData> visibleAgents = [];
  String? errorMessage;

  List<AgentData> favoriteAgentList = [];
  final Rx<void> fetchNotifier = Rx<void>(null);
  final Rxn<Map<String, dynamic>>? updateAgentNotifier = Rxn<Map<String, dynamic>>(null);
  final List<PageItem> pages;

  int get pageSize => _requestPageSize;

  AgentScreenController(
    super.args,
    this._apiService,
    this._localStorageService,
  ) : pages = <PageItem>[
          PageItem(
            page: const AgentScreenListRoute(),
            icon: Icons.list,
            label: AppStrings.list,
          ),
          PageItem(
            page: const FavoritesScreenRoute(),
            icon: Icons.favorite,
            label: AppStrings.favorite,
          ),
        ];

  @override
  void onDispose() {
    _disposeAppFunctions();
    super.onDispose();
  }

  Future<void> loadFavorites([int page = 0]) async {
    try {
      final String? favoritesJson = await _localStorageService().read(Keys.favoriteAgents);
      if (favoritesJson != null) {
        final List<dynamic> favoritesList = jsonDecode(favoritesJson);
        List<AgentData> tempList = [];

        tempList = favoritesList.map((json) => AgentData.fromJson(json).copyWith(isFavorite: true)).toList();
        favoriteAgentList = tempList;
      }
      notifyListeners();
    } catch (e) {
      DialogUtils.showErrorDialog(context, message: AppStrings.errorOccuredWhenFavAgentsLoading());
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

      updateAgent(updatedAgent, isFavorite: false, isDelete: true);
      await _saveFavorites();
      if (isForFavorite) {
        AppFunctions.refreshAgentDetail?.call(false, favoriteModel: null);
      }
    }
    fetchNotifier.refresh();

    notifyListeners();
  }

  void notifyUpdate(int index, AgentData updatedAgent) {
    visibleAgents[index] = updatedAgent;
    Map<String, dynamic> updateMap = {"index": index, "agent": updatedAgent};
    updateAgentNotifier?.call(set: () => updateMap);
    updateAgentNotifier?.refresh();
  }

  void updateAgent(AgentData updatedAgent, {required bool isFavorite, FavoriteModel? favoriteModel, bool isDelete = false}) {
    final int index = visibleAgents.indexWhere((agent) => agent.uuid == updatedAgent.uuid);
    updateAgentNotifier?.value = null;

    if (index != -1) {
      visibleAgents[index] = updatedAgent;
      notifyUpdate(index, updatedAgent);
    }
    fetchNotifier.refresh();
    notifyListeners();

    DialogUtils.showCreateFavoriteSuccessDialog(context, message: isDelete ? AppStrings.deleteAgentSuccessfulTitle() : AppStrings.editAgentSuccessfulTitle());
  }

  int currentIndex(String uuid) => visibleAgents.indexWhere((agent) => agent.uuid == uuid);

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
      message: AppStrings.enterTitleAndDescription(),
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
    try {
      final List<Map<String, dynamic>> favoritesJson = favoriteAgentList.map((agent) => agent.toMap()).toList();
      await _localStorageService().write(Keys.favoriteAgents, jsonEncode(favoritesJson));
    } catch (e) {
      DialogUtils.showErrorDialog(context, message: AppStrings.favoriteAgentNotSaved());
    }
  }

  void onTapListItem(AgentData agentItem) {
    AppNavigation.goToAgentDetail(
      context,
      args: AgentDetailScreenArgs(
          agentId: agentItem.uuid ?? '',
          isFavorite: agentItem.isFavorite,
          onUpdateList: (agentData) async {
            await showFavoriteDialog(agentData, isForFavorite: true);
          }),
    );
  }

  void _disposeAppFunctions() => AppFunctions.refreshAgentDetail = null;

  Future<void> fetch([int page = 0]) async {
    setBusy(true);
    await loadFavorites();
    await _apiService().agent.getAgentsList().then(
      (Result<List<AgentData>, ApiException> result) {
        result.on(success: (List<AgentData> data) async {
          agentList = data.map((agent) {
            return agent.copyWith(
              isFavorite: favoriteAgentList.any((fav) => fav.uuid == agent.uuid),
            );
          }).toList();
          await _loadMoreAgents(page);
          setBusy(false);
        }, failure: (ApiException e) {
          errorMessage = AppStrings.errorOccured();
          DialogUtils.showErrorDialog(context, message: AppStrings.errorOccured());
          setBusy(false);
        });
      },
    );
  }

  Future<void> _loadMoreAgents(int pageNumber) async {
    final startIndex = pageNumber * pageSize;
    if (startIndex < agentList.length) {
      final List<AgentData> nextItems = agentList.skip(startIndex).take(pageSize).toList();
      visibleAgents.addAll(nextItems);
      notifyListeners();
    }
  }
}
