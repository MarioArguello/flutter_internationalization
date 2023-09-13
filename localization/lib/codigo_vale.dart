import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'Applocations.dart';
import 'package:device_preview/device_preview.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    DevicePreview(
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: DevicePreview.appBuilder,
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('es', 'ES'), // Para español de España
        Locale('es'), // Para español general
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const AppLang(),
    );
  }
}

class AppLang extends StatefulWidget {
  const AppLang();

  @override
  _AppLangState createState() => _AppLangState();
}

class _AppLangState extends State<AppLang> {
  String? selectedLanguage; // Cambiamos a String nullable

  @override
  void initState() {
    super.initState();
    loadLanguagePreference(); // Cargar la preferencia de idioma al iniciar
  }

  // Función para cargar la preferencia de idioma desde SharedPreferences
  Future<void> loadLanguagePreference() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLanguage = prefs.getString('language');
    if (savedLanguage != null) {
      setState(() {
        selectedLanguage = savedLanguage;
      });
    }
  }

  // Función para cambiar el idioma y guardar la preferencia
  void changeLanguage(String? languageCode) async {
    if (languageCode != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('language', languageCode);

      // Cambiar el idioma en tiempo real
      setState(() {
        selectedLanguage = languageCode;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Configura el idioma de la aplicación en tiempo real
    Intl.defaultLocale = selectedLanguage ?? 'en'; // Predeterminado a inglés

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)?.translate('title') ?? '',
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)?.translate('message') ?? '',
            ),
            DropdownButton<String>(
              value: selectedLanguage,
              onChanged: (value) {
                changeLanguage(value);
              },
              items: const [
                DropdownMenuItem(
                  value: 'en',
                  child: Text('English'),
                ),
                DropdownMenuItem(
                  value: 'es',
                  child: Text('Español'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
