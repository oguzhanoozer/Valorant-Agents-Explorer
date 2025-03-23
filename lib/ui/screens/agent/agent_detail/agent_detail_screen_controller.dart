import 'dart:async';

import 'package:agents_explorer/core/configs/constants/app_strings.dart';
import 'package:agents_explorer/core/models/agents/api/agent_model.dart';
import 'package:agents_explorer/core/utils/app_functions.dart';

import '../../../../core/exceptions/api_exception.dart';
import '../../../../core/models/result.dart';
import '../../../../core/services/api/api_service.dart';
import '../../../../core/services/base_service.dart';
import '../../../../core/utils/dialog_utils.dart';
import '../../base_screen_controller.dart';
import 'agent_detail_screen_args.dart';

final class AgentDetailScreenController extends BaseScreenController<AgentDetailScreenArgs> {
  final Service<ApiService> _apiService;
  final String _movieId;
  final bool _isFavorite;
  AgentData? agentDetail;
  final void Function(AgentData)? onUpdateList;

  AgentDetailScreenController(
    super.args,
    this._apiService,
  )   : _movieId = args.movieId,
        _isFavorite = args.isFavorite,
        onUpdateList = args.onUpdateList;

  @override
  Future<void> onInitState() async {
    super.onInitState();
    _getAgentDetail(_movieId);
  }

  void fetchData() {
    _getAgentDetail(_movieId);
  }

  Future<void> saveFavorites() async {
    if (agentDetail == null) return;
    onUpdateList?.call(agentDetail!);
    AppFunctions.refreshAgentDetail = (bool isFavorite, {FavoriteModel? favoriteModel}) {
      agentDetail = agentDetail?.copyWith(isFavorite: isFavorite, favoriteModel: favoriteModel);
      notifyListeners();
    };
  }

  Future<void> _getAgentDetail(String id) async {
    setBusy(true);

    await _apiService().agent.getAgentDetail(id).then(
      (Result<AgentData, ApiException> result) {
        result.on(
          success: (AgentData data) {
            agentDetail = data;
            agentDetail = agentDetail?.copyWith(isFavorite: _isFavorite);
            setBusy(false);
          },
          failure: (ApiException e) {
            setBusy(false);

            DialogUtils.showErrorDialog(context, message: AppStrings.errorOccured()).then((_) => pop());
          },
        );
      },
    );
    notifyListeners();
  }
}
