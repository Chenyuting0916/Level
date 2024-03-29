import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:level/api/firebase_api.dart';
import 'package:level/firebase_options.dart';
import 'package:level/pages/home_page.dart';
import 'package:level/providers/locale_provider.dart';
import 'package:level/providers/theme_provider.dart';
import 'package:level/services/ad_mob_service.dart';
import 'package:level/services/auth_service.dart';
import 'package:level/services/daily_quest_service.dart';
import 'package:level/services/fake_scheduler_service.dart';
import 'package:level/services/user_service.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('settings');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();
  final initAdFuture = MobileAds.instance.initialize();
  final adMobService = AdMobService(initAdFuture);

  await AuthService().getOrCreateUser();
  await UserService().createUserIfNotExist();
  await DailyQuestService().createDailyQuestIfNotExist();
  await FakeSchedulerService().createReloadDaysIfNotExist();
  
  await UserService().updateLoginDay();
  await DailyQuestService().clearYesterdayCompletedDailyQuest();
  await FakeSchedulerService().resetDataIfNeeded();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => LocaleProvider(),
      ),
      Provider.value(value: adMobService)
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    LocalJsonLocalization.delegate.directories = ['lib/i18n'];
    return MaterialApp(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('zh', 'TW'),
        Locale('ja', 'JA'),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        LocalJsonLocalization.delegate,
      ],
      locale: Provider.of<LocaleProvider>(context).locale,
      debugShowCheckedModeBanner: false,
      home: const HomePage(
        selectedIndex: 1,
      ),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
