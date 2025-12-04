import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;

  static const supportedLanguages = ['en', 'ar'];

  late final Map<String, String> _localizedStrings;

  AppLocalizations(this.locale);

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations)!;

  Future<void> load() async {
    final String path = 'assets/lang/${locale.languageCode}.json';

    String jsonString;
    try {
      jsonString = await rootBundle.loadString(path);
    } catch (_) {
      // fallback إلى اللغة الإنجليزية
      jsonString = await rootBundle.loadString('assets/lang/en.json');
    }

    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map((key, value) => MapEntry(key, value.toString()));
  }

  /// Translate key
  String tr(String key) {
    if (!_localizedStrings.containsKey(key)) {
      // Logging في الديبج فقط
      debugPrint('⚠️ Missing localization key: $key');
    }
    return _localizedStrings[key] ?? key;
  }

  /// Translate with dynamic parameters
  String trWithParams(String key, Map<String, String> params) {
    String text = tr(key);
    params.forEach((param, value) {
      text = text.replaceAll('{$param}', value);
    });
    return text;
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      AppLocalizations.supportedLanguages.contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    final localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_) => false;
}
