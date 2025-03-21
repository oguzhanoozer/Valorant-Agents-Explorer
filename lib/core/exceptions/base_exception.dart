import '../configs/constants/app_strings.dart';

abstract base class BaseException implements Exception {
  final String _code;
  final String? _messageKey;
  final String? _message;
  final dynamic _e;

  const BaseException({
    required String code,
    String? messageKey,
    String? message,
    dynamic e,
  })  : _code = 'exception_$code',
        _messageKey = messageKey != null ? 'exception_$messageKey' : null,
        _message = message,
        _e = e;

  factory BaseException.from(dynamic e) {
    return e is BaseException ? e : UnKnownException(e: e);
  }

  String get message => _message ?? AppStrings.get(_messageKey ?? _code);

  @override
  String toString() {
    return <String, dynamic>{
      'code': _code,
      'message': _message,
      'messageKey': _messageKey,
      'e': '$_e',
    }.toString();
  }
}

final class UnKnownException extends BaseException {
  const UnKnownException({super.e}) : super(code: 'unknown');
}
