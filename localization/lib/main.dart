import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Applocations.dart';
import 'language_selector.dart'; // Importa la página del selector de idioma

void main() {
  runApp(MyApp());
}

class LanguageController {
  static Locale locale = Locale('en');

  static void loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLanguage = prefs.getString('language');
    if (savedLanguage != null) {
      locale = Locale(savedLanguage);
    }
  }

  static Future<void> setLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', languageCode);
    locale = Locale(languageCode);
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    LanguageController.loadLanguage();
  }

  void _changeLanguage(String languageCode) async {
    await LanguageController.setLanguage(languageCode);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: LanguageController.locale,
      supportedLocales: [
        Locale('en'),
        Locale('es'),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: AppLang(_changeLanguage),
      routes: {
        '/language_selector': (context) => LanguageSelectorPage(
              (languageCode) {
                _changeLanguage(languageCode);
                //Navigator.pop(context);
              },
            ),
      },
    );
  }
}

class AppLang extends StatelessWidget {
  final Function(String) onLanguageChanged;

  AppLang(this.onLanguageChanged);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.translate('title')!),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context)!.translate('message')!),
            TextButton(
              child: Text(AppLocalizations.of(context)!.translate('bien')!),
              onPressed: () {
                Navigator.pushNamed(context, '/language_selector');
              },
            ),
          ],
        ),
      ),
    );
  }
}
