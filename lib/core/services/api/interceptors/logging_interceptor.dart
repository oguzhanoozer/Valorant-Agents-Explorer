import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final class LoggingInterceptor extends PrettyDioLogger {
  LoggingInterceptor()
      : super(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
          error: true,
          compact: true,
        );
}
