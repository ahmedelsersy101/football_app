import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:football_app/features/onboarding/data/models/language_model.dart';

class LanguageCubit extends Cubit<String> {
  static const String _languageBoxName = 'language_box';
  static const String _languageKey = 'selected_language';

  late Box _languageBox;

  LanguageCubit() : super('ar'); // Default language is Arabic

  /// Initialize Hive and load saved language
  Future<void> initialize() async {
    await Hive.initFlutter();
    _languageBox = await Hive.openBox(_languageBoxName);

    // Load saved language or use default
    final savedLanguage = _languageBox.get(_languageKey, defaultValue: 'ar') as String;
    emit(savedLanguage);
  }

  /// Change language and persist it
  Future<void> changeLanguage(String languageCode) async {
    await _languageBox.put(_languageKey, languageCode);
    emit(languageCode);
  }

  /// Get current language model
  LanguageModel get currentLanguage => LanguageModel.getLanguageByCode(state);

  @override
  Future<void> close() {
    _languageBox.close();
    return super.close();
  }
}
