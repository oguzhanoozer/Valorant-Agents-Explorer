import 'dart:convert';
import 'package:agents_explorer/core/exceptions/api_exception.dart';
import 'package:agents_explorer/core/init/app_initializer.dart';
import 'package:agents_explorer/core/init/app_locator.dart';
import 'package:agents_explorer/core/models/agents/api/agent_model.dart';
import 'package:agents_explorer/core/models/result.dart';
import 'package:agents_explorer/core/services/api/constants/api_paths.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'agent_client_test.mocks.dart';
import 'mock_client.dart';

@GenerateMocks([Dio])
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppInitializer.init();
  AppLocator.initServices();

  late MockDio mockDio;
  late MockClient agentsClient;

  setUp(() {
    mockDio = MockDio();
    agentsClient = MockClient(mockDio);
  });

  Future<String> loadJson(String path) async {
    return await rootBundle.loadString(path);
  }

  group('AgentsClient Tests', () {
    test('getAgentsList returns success with data from JSON', () async {
      final jsonResponse = await loadJson('assets/test/agent_list.json');
      final mockResponse = json.decode(jsonResponse);

      when(mockDio.get(ApiPaths.agents)).thenAnswer(
        (_) async => Response(
          data: mockResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: ApiPaths.agents),
        ),
      );

      final result = await agentsClient.getAgentsList();

      expect(result, isA<Success<List<AgentData>, void>>());
      final data = (result as Success<List<AgentData>, void>).success;
      expect(data.length, 4);
      expect(data[0].uuid, 'e370fa57-4757-3604-3648-499e1f642d3f');
      expect(data[0].displayName, 'Gekko');
    });

    test('getAgentsList returns failure when Dio throws an error', () async {
      when(mockDio.get(ApiPaths.agents)).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ApiPaths.agents),
          error: "Network Error",
        ),
      );

      final result = await agentsClient.getAgentsList();

      expect(result, isA<Failure<List<AgentData>, ApiException>>());
    });

    test('getAgentDetail returns success with data from JSON', () async {
      final jsonResponse = await loadJson('assets/test/agent_detail.json');
      final mockResponse = json.decode(jsonResponse);

      const uuid = 'f94c3b30-42be-e959-889c-5aa313dba261';

      when(mockDio.get(ApiPaths.agentsDetail.replaceAll(":uuid", uuid))).thenAnswer((_) async => Response(
            data: mockResponse,
            statusCode: 200,
            requestOptions: RequestOptions(path: ApiPaths.agentsDetail),
          ));

      final result = await agentsClient.getAgentDetail(uuid);
      expect(result, isA<Success<AgentData, void>>());
      final data = (result as Success<AgentData, void>).success;
      expect(data.uuid, uuid);
      expect(data.displayName, 'Raze');
    });

    test('getAgentDetail returns failure when Dio throws an error', () async {
      when(mockDio.get('${ApiPaths.agentsDetail.replaceAll(":uuid", "123")}?language=en')).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ApiPaths.agentsDetail),
          error: "Network Error",
        ),
      );

      final result = await agentsClient.getAgentDetail("123");

      expect(result, isA<Failure<AgentData, ApiException>>());
    });
  });
}
