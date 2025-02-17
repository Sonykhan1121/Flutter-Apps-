import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/providers/language_provider.dart';
import 'l10n/l10n.dart';
import 'providers/task_provider.dart';
import 'providers/theme_provider.dart';
import 'pages/home_page.dart';
import 'utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_)=>LanguageProvider()),

      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          final languageProvder = Provider.of<LanguageProvider>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: Constants.appName,
            theme: themeProvider.themeData,
            supportedLocales: L10n.all,
            locale: languageProvder.locale,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            home: HomePage(),
          );
        },
      ),
    );
  }
}
