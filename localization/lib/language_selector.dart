import 'package:flutter/material.dart';

import 'Applocations.dart';

class LanguageSelectorPage extends StatefulWidget {
  final Function(String) onLanguageChanged;

  const LanguageSelectorPage(this.onLanguageChanged, {super.key});

  @override
  State<LanguageSelectorPage> createState() => _LanguageSelectorPageState();
}

class _LanguageSelectorPageState extends State<LanguageSelectorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.translate('nada')!),
        actions: [
          DropdownButton<String>(
            value: Localizations.localeOf(context).languageCode,
            onChanged: (value) {
              widget.onLanguageChanged(value!);
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
          )
        ], // Título de la página
      ),
      body: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.album),
              title: Text(AppLocalizations.of(context)!.translate('prueba1')!),
              subtitle: Text(AppLocalizations.of(context)!.translate('nada')!),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: Text(AppLocalizations.of(context)!.translate('esta')!),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: Text(AppLocalizations.of(context)!.translate('bien')!),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
