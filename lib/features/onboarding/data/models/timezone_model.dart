class TimezoneModel {
  final String countryCode;
  final String countryNameEn;
  final String countryNameAr;
  final String timezone;
  final String flagEmoji;
  final String utcOffset;

  const TimezoneModel({
    required this.countryCode,
    required this.countryNameEn,
    required this.countryNameAr,
    required this.timezone,
    required this.flagEmoji,
    required this.utcOffset,
  });

  static const List<TimezoneModel> supportedTimezones = [
    // Egypt
    TimezoneModel(
      countryCode: 'EG',
      countryNameEn: 'Egypt',
      countryNameAr: 'مصر',
      timezone: 'Africa/Cairo',
      flagEmoji: '🇪🇬',
      utcOffset: 'UTC+2',
    ),
    // Saudi Arabia
    TimezoneModel(
      countryCode: 'SA',
      countryNameEn: 'Saudi Arabia',
      countryNameAr: 'السعودية',
      timezone: 'Asia/Riyadh',
      flagEmoji: '🇸🇦',
      utcOffset: 'UTC+3',
    ),
    // UAE
    TimezoneModel(
      countryCode: 'AE',
      countryNameEn: 'UAE',
      countryNameAr: 'الإمارات',
      timezone: 'Asia/Dubai',
      flagEmoji: '🇦🇪',
      utcOffset: 'UTC+4',
    ),
    // UK
    TimezoneModel(
      countryCode: 'GB',
      countryNameEn: 'United Kingdom',
      countryNameAr: 'المملكة المتحدة',
      timezone: 'Europe/London',
      flagEmoji: '🇬🇧',
      utcOffset: 'UTC+0',
    ),
    // Germany
    TimezoneModel(
      countryCode: 'DE',
      countryNameEn: 'Germany',
      countryNameAr: 'ألمانيا',
      timezone: 'Europe/Berlin',
      flagEmoji: '🇩🇪',
      utcOffset: 'UTC+1',
    ),
    // Spain
    TimezoneModel(
      countryCode: 'ES',
      countryNameEn: 'Spain',
      countryNameAr: 'إسبانيا',
      timezone: 'Europe/Madrid',
      flagEmoji: '🇪🇸',
      utcOffset: 'UTC+1',
    ),
    // Italy
    TimezoneModel(
      countryCode: 'IT',
      countryNameEn: 'Italy',
      countryNameAr: 'إيطاليا',
      timezone: 'Europe/Rome',
      flagEmoji: '🇮🇹',
      utcOffset: 'UTC+1',
    ),
    // USA (Eastern)
    TimezoneModel(
      countryCode: 'US',
      countryNameEn: 'USA (Eastern)',
      countryNameAr: 'أمريكا (الشرقي)',
      timezone: 'America/New_York',
      flagEmoji: '🇺🇸',
      utcOffset: 'UTC-5',
    ),
  ];

  static TimezoneModel getTimezoneByCode(String code) {
    return supportedTimezones.firstWhere(
      (tz) => tz.countryCode == code,
      orElse: () => supportedTimezones[0], // Default to Egypt
    );
  }
}
