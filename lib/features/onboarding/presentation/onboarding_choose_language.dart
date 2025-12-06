import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/core/localization/app_localization.dart';
import 'package:football_app/core/utils/app_styels.dart';
import 'package:football_app/features/onboarding/cubit/language_cubit.dart';
import 'package:football_app/features/onboarding/data/models/language_model.dart';
import 'package:football_app/features/onboarding/presentation/onboarding_choose_match_time.dart';

class OnboardingChooseLanguage extends StatefulWidget {
  const OnboardingChooseLanguage({super.key});

  @override
  State<OnboardingChooseLanguage> createState() => _OnboardingChooseLanguageState();
}

class _OnboardingChooseLanguageState extends State<OnboardingChooseLanguage> {
  String? selectedLanguageCode;

  @override
  void initState() {
    super.initState();
    // Set initial selected language from cubit
    selectedLanguageCode = context.read<LanguageCubit>().state;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.tr('choose_language'), style: AppStyles.semiBoldStyle(22)),
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
              localizations.tr('select_your_language'),
              style: AppStyles.mediumStyle(16).copyWith(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 40),

            // Language Cards
            Expanded(
              child: ListView.separated(
                itemCount: LanguageModel.supportedLanguages.length,
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final language = LanguageModel.supportedLanguages[index];
                  final isSelected = selectedLanguageCode == language.code;

                  return LanguageCard(
                    language: language,
                    isSelected: isSelected,
                    onTap: () {
                      setState(() {
                        selectedLanguageCode = language.code;
                      });
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // Continue Button
            BlocBuilder<LanguageCubit, String>(
              builder: (context, currentLanguage) {
                return ElevatedButton(
                  onPressed: selectedLanguageCode != null
                      ? () async {
                          await context.read<LanguageCubit>().changeLanguage(selectedLanguageCode!);
                          // Show confirmation
                          if (context.mounted) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const OnboardingChooseMatchTime(),
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

class LanguageCard extends StatelessWidget {
  final LanguageModel language;
  final bool isSelected;
  final VoidCallback onTap;

  const LanguageCard({
    super.key,
    required this.language,
    required this.isSelected,
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
            Text(language.flagEmoji, style: const TextStyle(fontSize: 40)),

            const SizedBox(width: 20),

            // Language Names
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    language.nativeName,
                    style: AppStyles.semiBoldStyle(
                      18,
                    ).copyWith(color: isSelected ? Theme.of(context).primaryColor : null),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    language.englishName,
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
