import 'dart:io';

import 'package:dio/dio.dart';

import 'base_exception.dart';

abstract base class ApiException extends BaseException {
  const ApiException({
    required String code,
    String? messageKey,
    super.e,
  }) : super(
          code: 'api_$code',
          messageKey: messageKey != null ? 'api_$messageKey' : null,
        );

  factory ApiException.from(dynamic e) {
    ApiException handleDioException(DioException e) {
      switch (e.type) {
        case DioExceptionType.cancel:
          return RequestCancelException(e: e);
        case DioExceptionType.badCertificate:
          return BadCertificateException(e: e);
        case DioExceptionType.connectionError:
          return ConnectionException(e: e);
        case DioExceptionType.sendTimeout || DioExceptionType.receiveTimeout:
          return TimeoutException(e: e);
        case DioExceptionType.connectionTimeout:
          return ConnectionTimeoutException(e: e);
        case DioExceptionType.badResponse:
          switch (e.response?.statusCode) {
            case 400 || 401 || 403:
              return UnauthorizedException(e: e);
            case 404:
              return NotFoundException(e: e);
            case 408:
              return TimeoutException(e: e);
            case 409:
              return ConflictException(e: e);
            case 500:
              return InternalServerException(e: e);
            case 503:
              return ServiceUnavailableException(e: e);
          }
        case DioExceptionType.unknown:
          if (e.error is SocketException) {
            return NoInternetConnectionException(e: e);
          }
      }
      return UnknownException(e: e);
    }

    return switch (e) {
      ApiException _ => e,
      DioException _ => handleDioException(e),
      _ => UnknownException(e: e),
    };
  }
}

final class BadCertificateException extends ApiException {
  const BadCertificateException({super.e})
      : super(
          code: 'bad_certificate',
          messageKey: 'unknown',
        );
}

final class ConflictException extends ApiException {
  const ConflictException({super.e})
      : super(
          code: 'conflict',
          messageKey: 'unknown',
        );
}

final class ConnectionException extends ApiException {
  const ConnectionException({super.e}) : super(code: 'connection');
}

final class InternalServerException extends ApiException {
  const InternalServerException({super.e})
      : super(
          code: 'internal_server_error',
          messageKey: 'unknown',
        );
}

final class NoInternetConnectionException extends ApiException {
  const NoInternetConnectionException({super.e}) : super(code: 'no_internet_connection');
}

final class NotFoundException extends ApiException {
  const NotFoundException({super.e})
      : super(
          code: 'not_found',
          messageKey: 'unknown',
        );
}

final class RequestCancelException extends ApiException {
  const RequestCancelException({super.e})
      : super(
          code: 'request_cancel',
          messageKey: 'unknown',
        );
}

final class ServiceUnavailableException extends ApiException {
  const ServiceUnavailableException({super.e})
      : super(
          code: 'service_unavailable',
          messageKey: 'unknown',
        );
}

final class TimeoutException extends ApiException {
  const TimeoutException({super.e}) : super(code: 'timeout');
}

final class ConnectionTimeoutException extends ApiException {
  const ConnectionTimeoutException({super.e}) : super(code: 'connection_timeout');
}

final class UnauthorizedException extends ApiException {
  const UnauthorizedException({super.e}) : super(code: 'unauthorized');
}

final class UnknownException extends ApiException {
  const UnknownException({super.e})
      : super(
          code: 'unknown',
          messageKey: 'unknown',
        );
}
