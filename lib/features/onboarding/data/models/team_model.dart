class TeamModel {
  final String id;
  final String nameEn;
  final String nameAr;
  final String leagueId; // Reference to league
  final String countryCode;
  final String logoEmoji;

  const TeamModel({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.leagueId,
    required this.countryCode,
    required this.logoEmoji,
  });

  static const List<TeamModel> availableTeams = [
    // Premier League Teams
    TeamModel(
      id: 'man_city',
      nameEn: 'Manchester City',
      nameAr: 'مانشستر سيتي',
      leagueId: 'epl',
      countryCode: 'GB',
      logoEmoji: '🔵',
    ),
    TeamModel(
      id: 'liverpool',
      nameEn: 'Liverpool',
      nameAr: 'ليفربول',
      leagueId: 'epl',
      countryCode: 'GB',
      logoEmoji: '🔴',
    ),
    TeamModel(
      id: 'arsenal',
      nameEn: 'Arsenal',
      nameAr: 'أرسنال',
      leagueId: 'epl',
      countryCode: 'GB',
      logoEmoji: '🔴',
    ),
    TeamModel(
      id: 'chelsea',
      nameEn: 'Chelsea',
      nameAr: 'تشيلسي',
      leagueId: 'epl',
      countryCode: 'GB',
      logoEmoji: '🔵',
    ),
    TeamModel(
      id: 'man_utd',
      nameEn: 'Manchester United',
      nameAr: 'مانشستر يونايتد',
      leagueId: 'epl',
      countryCode: 'GB',
      logoEmoji: '🔴',
    ),

    // La Liga Teams
    TeamModel(
      id: 'real_madrid',
      nameEn: 'Real Madrid',
      nameAr: 'ريال مدريد',
      leagueId: 'laliga',
      countryCode: 'ES',
      logoEmoji: '⚪',
    ),
    TeamModel(
      id: 'barcelona',
      nameEn: 'Barcelona',
      nameAr: 'برشلونة',
      leagueId: 'laliga',
      countryCode: 'ES',
      logoEmoji: '🔵',
    ),
    TeamModel(
      id: 'atletico',
      nameEn: 'Atlético Madrid',
      nameAr: 'أتلتيكو مدريد',
      leagueId: 'laliga',
      countryCode: 'ES',
      logoEmoji: '🔴',
    ),

    // Serie A Teams
    TeamModel(
      id: 'juventus',
      nameEn: 'Juventus',
      nameAr: 'يوفنتوس',
      leagueId: 'seriea',
      countryCode: 'IT',
      logoEmoji: '⚫',
    ),
    TeamModel(
      id: 'ac_milan',
      nameEn: 'AC Milan',
      nameAr: 'ميلان',
      leagueId: 'seriea',
      countryCode: 'IT',
      logoEmoji: '🔴',
    ),
    TeamModel(
      id: 'inter',
      nameEn: 'Inter Milan',
      nameAr: 'إنتر ميلان',
      leagueId: 'seriea',
      countryCode: 'IT',
      logoEmoji: '🔵',
    ),

    // Bundesliga Teams
    TeamModel(
      id: 'bayern',
      nameEn: 'Bayern Munich',
      nameAr: 'بايرن ميونخ',
      leagueId: 'bundesliga',
      countryCode: 'DE',
      logoEmoji: '🔴',
    ),
    TeamModel(
      id: 'dortmund',
      nameEn: 'Borussia Dortmund',
      nameAr: 'بوروسيا دورتموند',
      leagueId: 'bundesliga',
      countryCode: 'DE',
      logoEmoji: '🟡',
    ),

    // Ligue 1 Teams
    TeamModel(
      id: 'psg',
      nameEn: 'Paris Saint-Germain',
      nameAr: 'باريس سان جيرمان',
      leagueId: 'ligue1',
      countryCode: 'FR',
      logoEmoji: '🔵',
    ),

    // Egyptian League Teams
    TeamModel(
      id: 'al_ahly',
      nameEn: 'Al Ahly',
      nameAr: 'الأهلي',
      leagueId: 'egypt',
      countryCode: 'EG',
      logoEmoji: '🔴',
    ),
    TeamModel(
      id: 'zamalek',
      nameEn: 'Zamalek',
      nameAr: 'الزمالك',
      leagueId: 'egypt',
      countryCode: 'EG',
      logoEmoji: '⚪',
    ),

    // Saudi League Teams
    TeamModel(
      id: 'al_nassr',
      nameEn: 'Al Nassr',
      nameAr: 'النصر',
      leagueId: 'saudi',
      countryCode: 'SA',
      logoEmoji: '🟡',
    ),
    TeamModel(
      id: 'al_hilal',
      nameEn: 'Al Hilal',
      nameAr: 'الهلال',
      leagueId: 'saudi',
      countryCode: 'SA',
      logoEmoji: '🔵',
    ),
    TeamModel(
      id: 'al_ittihad',
      nameEn: 'Al Ittihad',
      nameAr: 'الاتحاد',
      leagueId: 'saudi',
      countryCode: 'SA',
      logoEmoji: '🟡',
    ),
  ];

  static TeamModel? getTeamById(String id) {
    try {
      return availableTeams.firstWhere((team) => team.id == id);
    } catch (_) {
      return null;
    }
  }

  static List<TeamModel> getTeamsByIds(List<String> ids) {
    return ids.map((id) => getTeamById(id)).whereType<TeamModel>().toList();
  }

  static List<TeamModel> getTeamsByLeague(String leagueId) {
    return availableTeams.where((team) => team.leagueId == leagueId).toList();
  }
}
