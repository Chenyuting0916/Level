import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:level/pages/profile_page.dart';
import 'package:level/pages/ranking_page.dart';
import 'package:level/pages/settings_page.dart';
import 'package:level/pages/timer_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

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
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
              selectedIndex: _selectedIndex,
              onTabChange: _navigateBottomBar,
              backgroundColor: Colors.black,
              color: Colors.white,
              activeColor: Colors.white,
              gap: 4,
              padding: const EdgeInsets.all(16),
              tabs: const [
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                ),
                GButton(
                  icon: Icons.access_time_filled,
                  text: 'Focus',
                ),
                GButton(
                  icon: Icons.bar_chart_outlined,
                  text: 'Ranking',
                ),
                GButton(
                  icon: Icons.settings,
                  text: 'Settings',
                ),
              ]),
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
