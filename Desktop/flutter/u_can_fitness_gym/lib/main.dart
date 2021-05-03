import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:u_can_fitness_gym/routes.dart';
import 'package:u_can_fitness_gym/screens/introduction/startup_screen.dart';
import 'package:u_can_fitness_gym/shared/settings/app.setting.dart';
import 'package:u_can_fitness_gym/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'screens/home/home_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppSetting(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'U CAN FITNESS GYM',
      locale: Locale('ar'),
      supportedLocales: [
        const Locale('en', ''), // English, no country code
        const Locale('ar', ''), // Arabic, no country code
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      routes: routes,
      themeMode: ThemeMode.dark,
      home: HomeScreen(),
    );
  }
}
