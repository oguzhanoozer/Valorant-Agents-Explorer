import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../utils/app_logger.dart';
import '../base_service.dart';

enum LanguageCode {
  tr("tr-TR"),
  en("en-US");

  final String locale;
  const LanguageCode(this.locale);

  String getLocale() => locale;

  static LanguageCode fromString(String code) {
    return LanguageCode.values.firstWhere(
      (lang) => lang.name == code,
      orElse: () => LanguageCode.en,
    );
  }
}

const List<Locale> supportedLocales = <Locale>[
  Locale('tr'),
  Locale('en'),
];

Locale localeListResolutionCallback(List<Locale>? deviceLocales, Iterable<Locale> supportedLocales) {
  Locale locale = supportedLocales.first;
  for (final Locale deviceLocale in deviceLocales ?? <Locale>[]) {
    if (supportedLocales.any((Locale supportedLocale) => supportedLocale.languageCode == deviceLocale.languageCode)) {
      locale = deviceLocale;
      break;
    }
  }
  Intl.systemLocale = locale.toString();
  return locale;
}

final class LocalizationService extends BaseService<LocalizationService> {
  final String _defaultMissingValue = '???';
  final Map<String, dynamic> _strings = <String, dynamic>{};

  @override
  Future<LocalizationService> init() async {
    super.init();
    final String languageCode = Intl.shortLocale(Intl.getCurrentLocale());
    final String source = await rootBundle.loadString('assets/localizations/$languageCode.json');
    _strings.addAll(jsonDecode(source));
    return this;
  }

  String get(String key) {
    if (_strings.containsKey(key)) {
      return _strings[key];
    }
    AppLogger.warning('$key not found on string values.');
    return kReleaseMode ? _defaultMissingValue : key;
  }
}
