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
        padding: EdgeInsets.all(16),
        children: [
          // Dark Mode Toggle
          _buildSettingTile(
            title: Constants.darkModeToggle,
            trailing: Switch(
              value: themeProvider.isDarkMode,
              onChanged: (bool value) {
                themeProvider.toggleTheme();
              },
            ),
          ),
          Divider(),

          // Language Selection
          _buildSettingTile(
            title: 'Language',
            trailing: DropdownButton<String>(
              value: 'English', // Default language
              onChanged: (String? newValue) {
                // Handle language change
                // You can integrate a localization package like `flutter_localizations`
              },
              items: <String>['English', 'Spanish', 'French', 'German']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Divider(),

          // Notification Preferences
          _buildSettingTile(
            title: 'Enable Notifications',
            trailing: Switch(
              value: true, // Default value
              onChanged: (bool value) {
                // Handle notification toggle
              },
            ),
          ),
          Divider(),

          // Appearance Customization
          _buildSettingTile(
            title: 'Accent Color',
            trailing: IconButton(
              icon: Icon(Icons.color_lens),
              onPressed: () {
                _showColorPicker(context, themeProvider);
              },
            ),
          ),
          Divider(),

          // Reset Settings
          _buildSettingTile(
            title: 'Reset Settings',
            trailing: IconButton(
              icon: Icon(Icons.restore),
              onPressed: () {
                _showResetConfirmationDialog(context, themeProvider);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build a consistent setting tile
  Widget _buildSettingTile({required String title, required Widget trailing}) {
    return ListTile(
      title: Text(title),
      trailing: trailing,
    );
  }

  // Show a color picker dialog for accent color customization
  void _showColorPicker(BuildContext context, ThemeProvider themeProvider) {
    final List<Color> colors = [
      Colors.deepPurple,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.red,
    ];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Choose Accent Color'),
          content: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: colors.map((color) {
              return GestureDetector(
                onTap: () {
                  themeProvider.setAccentColor(color);
                  Navigator.pop(context);
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  // Show a confirmation dialog for resetting settings
  void _showResetConfirmationDialog(
      BuildContext context, ThemeProvider themeProvider) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Reset Settings'),
          content: Text('Are you sure you want to reset all settings?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                themeProvider.resetSettings(); // Reset theme and other settings
                Navigator.pop(context);
              },
              child: Text('Reset', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}