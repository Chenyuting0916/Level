import 'package:flutter/material.dart';
import 'package:level/classes/language.dart';
import 'package:level/providers/locale_provider.dart';
import 'package:level/theme/theme_provider.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isLightMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
        child: ListView(
          children: [
            Row(
              children: [
                const Icon(Icons.settings),
                const SizedBox(width: 10),
                Text(
                  "Settings".i18n(),
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                )
              ],
            ),
            const Divider(
              height: 20,
              thickness: 1,
            ),
            SwitchListTile.adaptive(
              value: _isLightMode,
              onChanged: (newValue) async {
                _isLightMode = !_isLightMode;
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme();
              },
              title: Text(
                'LightTheme'.i18n(),
              ),
              subtitle: Text(
                'ChangeLightThemeDescription'.i18n(),
              ),

              // tileColor: FlutterFlowTheme.of(context).secondaryBackground,
              activeColor: Theme.of(context).colorScheme.secondary,
              activeTrackColor: Theme.of(context).colorScheme.primary,
            ),
            DropdownButtonFormField<Locale>(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.language),
              ),
              hint: Text('ChangeLanguage'.i18n()),
              items: Language.all.map(
                (locale) {
                  final name = Language.getLocaleName(locale.languageCode);

                  return DropdownMenuItem(
                    value: locale,
                    onTap: () {
                      final provider =
                          Provider.of<LocaleProvider>(context, listen: false);

                      provider.setLocale(locale);
                    },
                    child: Text(
                      name,
                    ),
                  );
                },
              ).toList(),
              onChanged: (Locale? local) {
                if (local != null) {
                  Provider.of<LocaleProvider>(context, listen: false)
                      .setLocale(local);
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
