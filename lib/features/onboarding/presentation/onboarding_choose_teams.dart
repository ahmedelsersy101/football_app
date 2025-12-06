import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/core/localization/app_localization.dart';
import 'package:football_app/core/utils/app_styels.dart';
import 'package:football_app/features/home_view.dart';
import 'package:football_app/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:football_app/features/onboarding/cubit/teams_cubit.dart';
import 'package:football_app/features/onboarding/data/models/team_model.dart';

class OnboardingChooseTeams extends StatelessWidget {
  const OnboardingChooseTeams({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.tr('choose_teams'), style: AppStyles.semiBoldStyle(22)),
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
              localizations.tr('select_your_teams'),
              style: AppStyles.mediumStyle(16).copyWith(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            // Selection Counter
            BlocBuilder<TeamsCubit, List<String>>(
              builder: (context, selectedTeams) {
                return Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.3)),
                    ),
                    child: Text(
                      '${localizations.tr('selected_count')}: ${selectedTeams.length} ${localizations.tr('teams')}',
                      style: AppStyles.semiBoldStyle(
                        14,
                      ).copyWith(color: Theme.of(context).primaryColor),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 24),

            // Teams Grid
            Expanded(
              child: BlocBuilder<TeamsCubit, List<String>>(
                builder: (context, selectedTeams) {
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: TeamModel.availableTeams.length,
                    itemBuilder: (context, index) {
                      final team = TeamModel.availableTeams[index];
                      final isSelected = selectedTeams.contains(team.id);

                      return TeamGridItem(
                        team: team,
                        isSelected: isSelected,
                        isArabic: isArabic,
                        onTap: () {
                          context.read<TeamsCubit>().toggleTeam(team.id);
                        },
                      );
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // Continue Button
            BlocBuilder<TeamsCubit, List<String>>(
              builder: (context, selectedTeams) {
                return ElevatedButton(
                  onPressed: selectedTeams.isNotEmpty
                      ? () async {
                          await context.read<TeamsCubit>().saveSelection();

                          // Mark onboarding as completed
                          if (!context.mounted) return;
                          await context.read<OnboardingCubit>().completeOnboarding();

                          // Navigate to HomeView
                          if (context.mounted) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const HomeView()),
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

class TeamGridItem extends StatelessWidget {
  final TeamModel team;
  final bool isSelected;
  final bool isArabic;
  final VoidCallback onTap;

  const TeamGridItem({
    super.key,
    required this.team,
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

            // Team Logo/Emoji
            Text(team.logoEmoji, style: const TextStyle(fontSize: 42)),

            const SizedBox(height: 12),

            // Team Name
            Expanded(
              child: Center(
                child: Text(
                  isArabic ? team.nameAr : team.nameEn,
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
