import 'package:flutter/material.dart';
import 'package:level/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: Text('settings'),
      
      ),
       floatingActionButton: FloatingActionButton(
          onPressed: (){
            Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
          },
          child: Icon(Icons.add),
        ),
    );
  }
}