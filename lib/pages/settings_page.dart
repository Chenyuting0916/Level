import 'package:flutter/material.dart';
import 'package:level/models/language.dart';
import 'package:level/components/my_divider.dart';
import 'package:level/components/my_title.dart';
import 'package:level/providers/locale_provider.dart';
import 'package:level/providers/theme_provider.dart';
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
            MyTitle(
                title: "Settings".i18n(),
                titleIcon: const Icon(Icons.settings)),
            const MyDevider(),
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
              activeColor: Theme.of(context).colorScheme.secondary,
              activeTrackColor: Theme.of(context).colorScheme.primary,
            ),
            buildLanguageDropdown(),
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

  DropdownButtonFormField<Locale> buildLanguageDropdown() {
    return DropdownButtonFormField<Locale>(
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.language,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
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
          Provider.of<LocaleProvider>(context, listen: false).setLocale(local);
        }
      },
    );
  }
}
