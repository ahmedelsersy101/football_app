class LanguageModel {
  final String code;
  final String nativeName;
  final String englishName;
  final String flagEmoji;

  const LanguageModel({
    required this.code,
    required this.nativeName,
    required this.englishName,
    required this.flagEmoji,
  });

  static const List<LanguageModel> supportedLanguages = [
    LanguageModel(code: 'ar', nativeName: 'العربية', englishName: 'Arabic', flagEmoji: '🇸🇦'),
    LanguageModel(code: 'en', nativeName: 'English', englishName: 'English', flagEmoji: '🇺🇸'),
  ];

  static LanguageModel getLanguageByCode(String code) {
    return supportedLanguages.firstWhere(
      (lang) => lang.code == code,
      orElse: () => supportedLanguages[1], // Default to English
    );
  }
}
