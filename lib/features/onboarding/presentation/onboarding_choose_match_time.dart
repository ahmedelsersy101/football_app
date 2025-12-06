import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/core/localization/app_localization.dart';
import 'package:football_app/core/utils/app_styels.dart';
import 'package:football_app/features/onboarding/cubit/timezone_cubit.dart';
import 'package:football_app/features/onboarding/data/models/timezone_model.dart';
import 'package:football_app/features/onboarding/presentation/onboarding_choose_leagues.dart';

class OnboardingChooseMatchTime extends StatefulWidget {
  const OnboardingChooseMatchTime({super.key});

  @override
  State<OnboardingChooseMatchTime> createState() => _OnboardingChooseMatchTimeState();
}

class _OnboardingChooseMatchTimeState extends State<OnboardingChooseMatchTime> {
  String? selectedCountryCode;

  @override
  void initState() {
    super.initState();
    // Set initial selected timezone from cubit
    selectedCountryCode = context.read<TimezoneCubit>().state;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.tr('choose_timezone'), style: AppStyles.semiBoldStyle(22)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),

            // Subtitle
            Text(
              localizations.tr('select_your_timezone'),
              style: AppStyles.mediumStyle(16).copyWith(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 40),

            // Timezone Cards
            Expanded(
              child: ListView.separated(
                itemCount: TimezoneModel.supportedTimezones.length,
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final timezone = TimezoneModel.supportedTimezones[index];
                  final isSelected = selectedCountryCode == timezone.countryCode;

                  return TimezoneCard(
                    timezone: timezone,
                    isSelected: isSelected,
                    isArabic: isArabic,
                    onTap: () {
                      setState(() {
                        selectedCountryCode = timezone.countryCode;
                      });
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // Continue Button
            BlocBuilder<TimezoneCubit, String>(
              builder: (context, currentTimezone) {
                return ElevatedButton(
                  onPressed: selectedCountryCode != null
                      ? () async {
                          await context.read<TimezoneCubit>().changeTimezone(selectedCountryCode!);
                          // Navigate to next screen or show confirmation
                          if (context.mounted) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const OnboardingChooseLeagues(),
                              ),
                            );
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(localizations.tr('continue'), style: AppStyles.semiBoldStyle(16)),
                );
              },
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class TimezoneCard extends StatelessWidget {
  final TimezoneModel timezone;
  final bool isSelected;
  final bool isArabic;
  final VoidCallback onTap;

  const TimezoneCard({
    super.key,
    required this.timezone,
    required this.isSelected,
    required this.isArabic,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).primaryColor
                : isDarkMode
                ? Colors.grey[700]!
                : Colors.grey[300]!,
            width: isSelected ? 2.5 : 1.5,
          ),
          color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.1) : Colors.transparent,
        ),
        child: Row(
          children: [
            // Flag Emoji
            Text(timezone.flagEmoji, style: const TextStyle(fontSize: 40)),

            const SizedBox(width: 20),

            // Country Names and Timezone
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isArabic ? timezone.countryNameAr : timezone.countryNameEn,
                    style: AppStyles.semiBoldStyle(
                      18,
                    ).copyWith(color: isSelected ? Theme.of(context).primaryColor : null),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    timezone.utcOffset,
                    style: AppStyles.mediumStyle(14).copyWith(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),

            // Selection Indicator
            if (isSelected)
              Icon(Icons.check_circle, color: Theme.of(context).primaryColor, size: 28),
          ],
        ),
      ),
    );
  }
}
