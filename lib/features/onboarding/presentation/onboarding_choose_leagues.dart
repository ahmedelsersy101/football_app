import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/core/localization/app_localization.dart';
import 'package:football_app/core/utils/app_styels.dart';
import 'package:football_app/features/onboarding/cubit/leagues_cubit.dart';
import 'package:football_app/features/onboarding/data/models/league_model.dart';
import 'package:football_app/features/onboarding/presentation/onboarding_choose_teams.dart';

class OnboardingChooseLeagues extends StatelessWidget {
  const OnboardingChooseLeagues({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.tr('choose_leagues'), style: AppStyles.semiBoldStyle(22)),
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
              localizations.tr('select_your_leagues'),
              style: AppStyles.mediumStyle(16).copyWith(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            // Selection Counter
            BlocBuilder<LeaguesCubit, List<String>>(
              builder: (context, selectedLeagues) {
                return Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.3)),
                    ),
                    child: Text(
                      '${localizations.tr('selected_count')}: ${selectedLeagues.length} ${localizations.tr('leagues')}',
                      style: AppStyles.semiBoldStyle(
                        14,
                      ).copyWith(color: Theme.of(context).primaryColor),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 24),

            // Leagues Grid
            Expanded(
              child: BlocBuilder<LeaguesCubit, List<String>>(
                builder: (context, selectedLeagues) {
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: LeagueModel.availableLeagues.length,
                    itemBuilder: (context, index) {
                      final league = LeagueModel.availableLeagues[index];
                      final isSelected = selectedLeagues.contains(league.id);

                      return LeagueGridItem(
                        league: league,
                        isSelected: isSelected,
                        isArabic: isArabic,
                        onTap: () {
                          context.read<LeaguesCubit>().toggleLeague(league.id);
                        },
                      );
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // Continue Button
            BlocBuilder<LeaguesCubit, List<String>>(
              builder: (context, selectedLeagues) {
                return ElevatedButton(
                  onPressed: selectedLeagues.isNotEmpty
                      ? () async {
                          await context.read<LeaguesCubit>().saveSelection();
                          // Navigate to teams screen
                          if (context.mounted) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const OnboardingChooseTeams(),
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

class LeagueGridItem extends StatelessWidget {
  final LeagueModel league;
  final bool isSelected;
  final bool isArabic;
  final VoidCallback onTap;

  const LeagueGridItem({
    super.key,
    required this.league,
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
        padding: const EdgeInsets.all(12),
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
          color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.15) : Colors.transparent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Selection Indicator (Top Right)
            Align(
              alignment: Alignment.topRight,
              child: isSelected
                  ? Icon(Icons.check_circle, color: Theme.of(context).primaryColor, size: 20)
                  : const SizedBox(height: 20),
            ),

            const SizedBox(height: 4),

            // League Logo/Emoji
            Text(league.logoEmoji, style: const TextStyle(fontSize: 42)),

            const SizedBox(height: 12),

            // League Name
            Expanded(
              child: Center(
                child: Text(
                  isArabic ? league.nameAr : league.nameEn,
                  style: AppStyles.semiBoldStyle(
                    12,
                  ).copyWith(color: isSelected ? Theme.of(context).primaryColor : null),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
