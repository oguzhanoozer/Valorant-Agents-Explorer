import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:path_provider/path_provider.dart';

final class CacheInterceptor extends Interceptor {
  final CacheOptions _cacheOptions;

  CacheInterceptor()
      : _cacheOptions = CacheOptions(
          store: MemCacheStore(),
          policy: CachePolicy.request,
          maxStale: const Duration(hours: 1),
          priority: CachePriority.high,
          hitCacheOnErrorExcept: [401, 403],
        );

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.extra['cacheOptions'] = _cacheOptions;
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  Future<CacheStore> getDiskCacheStore() async {
    final cacheDir = await getTemporaryDirectory();
    return HiveCacheStore(
      cacheDir.path,
    );
  }
}
