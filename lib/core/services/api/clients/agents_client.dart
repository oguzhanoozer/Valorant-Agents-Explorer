import 'package:agents_explorer/core/models/agents/api/agent_model.dart';
import 'package:agents_explorer/core/services/localization/localization_service.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;

import '../../../exceptions/api_exception.dart';
import '../../../models/result.dart';
import '../constants/api_paths.dart';

final class AgentsClient {
  final Dio _api;

  String? languageCode;

  AgentsClient(this._api) {
    final data = localeListResolutionCallback(null, supportedLocales);
    languageCode = data.languageCode;
  }

  Future<Result<List<AgentData>, ApiException>> getAgentsList() async {
    try {
      final requestLangCode = LanguageCode.fromString(languageCode ?? '').getLocale();
      return await _api.get('${ApiPaths.agents}?language=$requestLangCode').then(
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
      final requestLangCode = LanguageCode.fromString(languageCode ?? '').getLocale();

      return await _api.get('${ApiPaths.agentsDetail.replaceAll(':uuid', uuid)}?language=$requestLangCode').then(
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
