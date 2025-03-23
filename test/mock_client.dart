import 'package:agents_explorer/core/exceptions/api_exception.dart';
import 'package:agents_explorer/core/models/agents/api/agent_model.dart';
import 'package:agents_explorer/core/models/result.dart';
import 'package:agents_explorer/core/services/api/constants/api_paths.dart';
import 'package:agents_explorer/core/services/localization/localization_service.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;

final class MockClient {
  final Dio _api;

  MockClient(this._api);

  Future<Result<List<AgentData>, ApiException>> getAgentsList() async {
    try {
      final requestLangCode = LanguageCode.fromString("en").getLocale();
      return await _api.get(ApiPaths.agents).then(
        (dio.Response<dynamic> response) {
          return Success(AgentModel.fromJson(response.data).data ?? []);
        },
      );
    } catch (e) {
      return Failure(ApiException.from(e));
    }
  }

  Future<Result<AgentData, ApiException>> getAgentDetail(String uuid) async {
    try {
      final requestLangCode = LanguageCode.fromString("en").getLocale();
      return await _api.get(ApiPaths.agentsDetail.replaceAll(':uuid', uuid)).then(
        (dio.Response<dynamic> response) {
          final data = response.data['data'];
          return Success(AgentData.fromJson(data));
        },
      );
    } catch (e) {
      return Failure(ApiException.from(e));
    }
  }
}
