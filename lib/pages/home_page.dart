import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:level/pages/profile_page.dart';
import 'package:level/pages/ranking_page.dart';
import 'package:level/pages/settings_page.dart';
import 'package:level/pages/timer_page.dart';
import 'package:localization/localization.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;

  final List _pages = [
    const ProfilePage(),
    const TimerPage(),
    const RankingPage(),
    const SettingsPage()
  ];

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Theme.of(context).colorScheme.background,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
              selectedIndex: _selectedIndex,
              onTabChange: _navigateBottomBar,
              backgroundColor: Theme.of(context).colorScheme.background,
              gap: 4,
              padding: const EdgeInsets.all(16),
              tabs:  [
                GButton(
                  icon: Icons.person,
                  text: 'Profile'.i18n(),
                ),
                GButton(
                  icon: Icons.access_time_filled,
                  text: 'Focus'.i18n(),
                ),
                GButton(
                  icon: Icons.bar_chart_outlined,
                  text: 'Rank'.i18n(),
                ),
                GButton(
                  icon: Icons.settings,
                  text: 'Settings'.i18n(),
                ),
              ]),
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
