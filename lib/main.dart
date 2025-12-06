import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:football_app/core/localization/app_localization.dart';
import 'package:football_app/core/theme/app_theme.dart';
import 'package:football_app/features/onboarding/cubit/language_cubit.dart';
import 'package:football_app/features/onboarding/cubit/leagues_cubit.dart';
import 'package:football_app/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:football_app/features/onboarding/cubit/teams_cubit.dart';
import 'package:football_app/features/onboarding/cubit/timezone_cubit.dart';
import 'package:football_app/features/spalsh/spalsh_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize LanguageCubit
  final languageCubit = LanguageCubit();
  await languageCubit.initialize();

  // Initialize TimezoneCubit
  final timezoneCubit = TimezoneCubit();
  await timezoneCubit.initialize();

  // Initialize LeaguesCubit
  final leaguesCubit = LeaguesCubit();
  await leaguesCubit.initialize();

  // Initialize TeamsCubit
  final teamsCubit = TeamsCubit();
  await teamsCubit.initialize();

  // Initialize OnboardingCubit
  final onboardingCubit = OnboardingCubit();
  await onboardingCubit.initialize();

  runApp(
    FootballApp(
      languageCubit: languageCubit,
      timezoneCubit: timezoneCubit,
      leaguesCubit: leaguesCubit,
      teamsCubit: teamsCubit,
      onboardingCubit: onboardingCubit,
    ),
  );
}

class FootballApp extends StatefulWidget {
  final LanguageCubit languageCubit;
  final TimezoneCubit timezoneCubit;
  final LeaguesCubit leaguesCubit;
  final TeamsCubit teamsCubit;
  final OnboardingCubit onboardingCubit;

  const FootballApp({
    super.key,
    required this.languageCubit,
    required this.timezoneCubit,
    required this.leaguesCubit,
    required this.teamsCubit,
    required this.onboardingCubit,
  });

  @override
  State<FootballApp> createState() => _FootballAppState();
}

class _FootballAppState extends State<FootballApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: widget.languageCubit),
        BlocProvider.value(value: widget.timezoneCubit),
        BlocProvider.value(value: widget.leaguesCubit),
        BlocProvider.value(value: widget.teamsCubit),
        BlocProvider.value(value: widget.onboardingCubit),
      ],
      child: BlocBuilder<LanguageCubit, String>(
        builder: (context, languageCode) {
          return MaterialApp(
            title: 'Football App',
            debugShowCheckedModeBanner: false,

            // ------------------------
            // Localization
            // ------------------------
            locale: Locale(languageCode),
            supportedLocales: const [Locale('en'), Locale('ar')],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],

            // ------------------------
            // Direction RTL/LTR based on locale
            // ------------------------
            builder: (context, child) {
              final locale = Localizations.localeOf(context);
              final isRtl = locale.languageCode == 'ar';
              return Directionality(
                textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
                child: child!,
              );
            },

            // ------------------------
            // Theme Integration
            // ------------------------
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.system, // auto switching

            home: const SplashView(),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    widget.languageCubit.close();
    super.dispose();
  }
}
