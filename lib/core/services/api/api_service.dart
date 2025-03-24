import 'dart:io';

import 'package:agents_explorer/core/services/api/clients/agents_client.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../base_service.dart';
import 'constants/api_paths.dart';
import 'interceptors/cache_interceptor.dart';
import 'interceptors/logging_interceptor.dart';

final class ApiService extends BaseService<ApiService> {
  final dio.Dio _api;

  late final AgentsClient agent;

  ApiService()
      : _api = dio.Dio(
          dio.BaseOptions(
            baseUrl: ApiPaths.servicePath,
            connectTimeout: const Duration(seconds: 15),
            receiveTimeout: const Duration(seconds: 15),
            sendTimeout: const Duration(seconds: 60),
            headers: <String, dynamic>{
              HttpHeaders.contentTypeHeader: ContentType.json.value,
              HttpHeaders.acceptLanguageHeader: Intl.shortLocale(Intl.getCurrentLocale()),
            },
          ),
        ) {
    // _api.interceptors.addAll(
    //   <dio.Interceptor>[
    //     CacheInterceptor(),
    //     if (kDebugMode) LoggingInterceptor(),
    //   ],
    // );
    agent = AgentsClient(_api);
  }

  set baseUrl(String baseUrl) => _api.options.baseUrl = baseUrl;
}

final class CancelToken extends dio.CancelToken {}
