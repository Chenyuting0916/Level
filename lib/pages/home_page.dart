import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:level/pages/daily_quest_page.dart';
import 'package:level/pages/profile_page.dart';
import 'package:level/pages/ranking_page.dart';
import 'package:level/pages/settings_page.dart';
import 'package:level/pages/timer_page.dart';
import 'package:level/services/daily_quest_service.dart';
import 'package:level/services/fake_scheduler_service.dart';
import 'package:level/services/user_service.dart';
import 'package:localization/localization.dart';

class HomePage extends StatefulWidget {
  final int selectedIndex;
  const HomePage({super.key, required this.selectedIndex});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  final List _pages = [
    const ProfilePage(),
    const TimerPage(),
    const DailyQuestPage(),
    const RankingPage(),
    const SettingsPage(),
  ];

  Future<void> _navigateBottomBar(int index) async {
    await UserService().updateLoginDay();
    await FakeSchedulerService().resetDataIfNeeded();
    await DailyQuestService().clearYesterdayCompletedDailyQuest();

    setState(() {
      _selectedIndex = index;
    });
  }

  GNav buildNav() {
    return GNav(
        selectedIndex: _selectedIndex,
        onTabChange: _navigateBottomBar,
        backgroundColor: Theme.of(context).colorScheme.surface,
        gap: 4,
        haptic: true,
        padding: const EdgeInsets.all(16),
        tabs: [
          GButton(
            icon: Icons.person,
            text: 'Profile'.i18n(),
          ),
          GButton(
            icon: Icons.access_time_filled,
            text: 'Focus'.i18n(),
          ),
          GButton(
            icon: Icons.task,
            text: 'Daily'.i18n(),
          ),
          GButton(
            icon: Icons.bar_chart_outlined,
            text: 'Rank'.i18n(),
          ),
          GButton(
            icon: Icons.settings,
            text: 'Settings'.i18n(),
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        bottomNavigationBar: Container(
          color: Theme.of(context).colorScheme.surface,
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
              child: buildNav()),
        ),
        body: _pages[_selectedIndex],
      ),
    );
  }
}
