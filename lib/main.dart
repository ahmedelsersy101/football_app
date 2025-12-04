import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:football_app/core/localization/app_localization.dart';
import 'package:football_app/core/theme/app_theme.dart';
import 'package:football_app/features/spalsh/spalsh_view.dart';

void main() {
  runApp(const FootballApp());
}

class FootballApp extends StatelessWidget {
  const FootballApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Football App',
      debugShowCheckedModeBanner: false,

      // ------------------------
      // Localization
      // ------------------------
      locale: const Locale('ar'),
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
  }
}
