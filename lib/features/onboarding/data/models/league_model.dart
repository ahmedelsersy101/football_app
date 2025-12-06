class LeagueModel {
  final String id;
  final String nameEn;
  final String nameAr;
  final String countryCode;
  final String logoEmoji;
  final String category; // 'domestic', 'international', 'continental'

  const LeagueModel({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.countryCode,
    required this.logoEmoji,
    required this.category,
  });

  static const List<LeagueModel> availableLeagues = [
    // International/Continental Competitions
    LeagueModel(
      id: 'ucl',
      nameEn: 'UEFA Champions League',
      nameAr: 'دوري أبطال أوروبا',
      countryCode: 'EU',
      logoEmoji: '🏆',
      category: 'continental',
    ),
    LeagueModel(
      id: 'uel',
      nameEn: 'UEFA Europa League',
      nameAr: 'الدوري الأوروبي',
      countryCode: 'EU',
      logoEmoji: '🥈',
      category: 'continental',
    ),
    LeagueModel(
      id: 'wcup',
      nameEn: 'FIFA World Cup',
      nameAr: 'كأس العالم',
      countryCode: 'INT',
      logoEmoji: '🌍',
      category: 'international',
    ),

    // European Domestic Leagues
    LeagueModel(
      id: 'epl',
      nameEn: 'Premier League',
      nameAr: 'الدوري الإنجليزي',
      countryCode: 'GB',
      logoEmoji: '🏴󠁧󠁢󠁥󠁮󠁧󠁿',
      category: 'domestic',
    ),
    LeagueModel(
      id: 'laliga',
      nameEn: 'La Liga',
      nameAr: 'الدوري الإسباني',
      countryCode: 'ES',
      logoEmoji: '🇪🇸',
      category: 'domestic',
    ),
    LeagueModel(
      id: 'seriea',
      nameEn: 'Serie A',
      nameAr: 'الدوري الإيطالي',
      countryCode: 'IT',
      logoEmoji: '🇮🇹',
      category: 'domestic',
    ),
    LeagueModel(
      id: 'bundesliga',
      nameEn: 'Bundesliga',
      nameAr: 'الدوري الألماني',
      countryCode: 'DE',
      logoEmoji: '🇩🇪',
      category: 'domestic',
    ),
    LeagueModel(
      id: 'ligue1',
      nameEn: 'Ligue 1',
      nameAr: 'الدوري الفرنسي',
      countryCode: 'FR',
      logoEmoji: '🇫🇷',
      category: 'domestic',
    ),

    // Arab Leagues
    LeagueModel(
      id: 'egypt',
      nameEn: 'Egyptian Premier League',
      nameAr: 'الدوري المصري',
      countryCode: 'EG',
      logoEmoji: '🇪🇬',
      category: 'domestic',
    ),
    LeagueModel(
      id: 'saudi',
      nameEn: 'Saudi Pro League',
      nameAr: 'دوري روشن السعودي',
      countryCode: 'SA',
      logoEmoji: '🇸🇦',
      category: 'domestic',
    ),
    LeagueModel(
      id: 'uae',
      nameEn: 'UAE Pro League',
      nameAr: 'دوري الخليج العربي',
      countryCode: 'AE',
      logoEmoji: '🇦🇪',
      category: 'domestic',
    ),

    // More Leagues (Easily Expandable)
    LeagueModel(
      id: 'portugal',
      nameEn: 'Primeira Liga',
      nameAr: 'الدوري البرتغالي',
      countryCode: 'PT',
      logoEmoji: '🇵🇹',
      category: 'domestic',
    ),
    LeagueModel(
      id: 'netherlands',
      nameEn: 'Eredivisie',
      nameAr: 'الدوري الهولندي',
      countryCode: 'NL',
      logoEmoji: '🇳🇱',
      category: 'domestic',
    ),
  ];

  static LeagueModel? getLeagueById(String id) {
    try {
      return availableLeagues.firstWhere((league) => league.id == id);
    } catch (_) {
      return null;
    }
  }

  static List<LeagueModel> getLeaguesByIds(List<String> ids) {
    return ids.map((id) => getLeagueById(id)).whereType<LeagueModel>().toList();
  }
}
