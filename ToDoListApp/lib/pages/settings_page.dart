import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../utils/constants.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.settingsTitle),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(Constants.darkModeToggle),
            trailing: Switch(
              value: themeProvider.isDarkMode, // Use the isDarkMode getter
              onChanged: (bool value) {
                themeProvider.toggleTheme(); // Toggle theme on change
              },
            ),
          ),
        ],
      ),
    );
  }
}
