import 'dart:async';

import 'package:agents_explorer/core/models/agents/api/agent_model.dart';
import 'package:agents_explorer/core/utils/app_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final void Function()? onUpdateList;

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

  bool _loading = false;

  bool get isLoading => _loading;

  void setLoading(bool status) {
    _loading = status;
    notifyListeners();
  }

  Future<void> saveFavorites() async {
    //agentDetail = agentDetail?.copyWith(isFavorite: !(agentDetail?.isFavorite ?? false));
    onUpdateList?.call();
    AppFunctions.refreshAgentDetail = (bool isFavorite, {FavoriteModel? favoriteModel}) {
      agentDetail = agentDetail?.copyWith(isFavorite: isFavorite, favoriteModel: favoriteModel);
      notifyListeners();
    };
  }

  Future<void> _getAgentDetail(String id) async {
    setLoading(true);
    notifyListeners();

    await _apiService().agent.getAgentDetail(id).then(
      (Result<AgentData, ApiException> result) {
        result.on(
          success: (AgentData data) {
            agentDetail = data;
            agentDetail = agentDetail?.copyWith(isFavorite: _isFavorite);
          },
          failure: (ApiException e) {
            DialogUtils.showErrorDialog(context, message: e.message).then((_) => pop());
          },
        );
      },
    );
    setLoading(false);
    notifyListeners();
  }
}
