import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:level/components/my_button.dart';
import 'package:level/components/my_hint.dart';
import 'package:level/models/language.dart';
import 'package:level/components/my_divider.dart';
import 'package:level/components/my_title.dart';
import 'package:level/pages/store_page.dart';
import 'package:level/providers/locale_provider.dart';
import 'package:level/providers/theme_provider.dart';
import 'package:level/services/ad_mob_service.dart';
import 'package:level/services/auth_service.dart';
import 'package:level/theme/theme.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late AdMobService _adMobService;
  RewardedAd? _rewardedAd;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _adMobService = context.read<AdMobService>();
    _createRewardAd();
  }

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
            const MyDivider(),
            SwitchListTile.adaptive(
              value: Provider.of<ThemeProvider>(context, listen: false)
                      .themeData ==
                  lightMode,
              onChanged: (newValue) async {
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
            const SizedBox(
              height: 20,
            ),
            Text(
              "SupportUs".i18n(),
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            MyButton(
              buttonChild: Text("ChooseYourPlan".i18n()),
              onPressed: fetchOffers,
              buttonBackgroundColor: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(
              height: 20,
            ),
            MyButton(
              buttonChild: Text("WatchAds".i18n()),
              onPressed: watchAds,
              buttonBackgroundColor: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "BindAccount".i18n(),
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            // MyButton(
            //   buttonChild: Text("SignInWithGoogle".i18n()),
            //   onPressed: () => signInGoogle(),
            //   buttonBackgroundColor: Theme.of(context).colorScheme.primary,
            // ),
            MyButton(
              buttonChild: Text("LinkAccountWithEmail".i18n()),
              onPressed: () => AuthService().signInWithEmail('chenyuting0916@hotmail.com ','qaz123456'),
              buttonBackgroundColor: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(
              height: 20,
            ),
            MyButton(
              buttonChild: Text("LoginExistedAccount".i18n()),
              onPressed: () => AuthService().login(),
              buttonBackgroundColor: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      ),
      floatingActionButton: MyHint(hintMessage: "AuthorBeggingForMoney".i18n()),
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

  Future fetchOffers() async {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const StorePage()));
  }

  void _createRewardAd() {
    RewardedAd.load(
        adUnitId: _adMobService.rewardedAdUnitId!,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');
            _rewardedAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('RewardedAd failed to load: $error');
          },
        ));
  }

  void watchAds() {
    if (_rewardedAd != null) {
      _rewardedAd!.fullScreenContentCallback =
          FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _createRewardAd();
      }, onAdFailedToShowFullScreenContent: ((ad, error) {
        ad.dispose();
        _createRewardAd();
      }));
      _rewardedAd!.show(onUserEarnedReward: ((ad, reward) {
        //reward user here
      }));
    }
  }

  signInGoogle() async {
    await AuthService().signInWithGoogle();
  }
}
