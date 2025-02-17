import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/providers/language_provider.dart';
import '../l10n/l10n.dart';
import '../providers/theme_provider.dart';
import '../utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);


    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.settingsTitle),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // Dark Mode Toggle
          _buildSettingTile(
            title: AppLocalizations.of(context)!.darkModeToggle,
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
            title: AppLocalizations.of(context)!.language,
            trailing: DropdownButton<Locale>( // Use Locale type
              value: languageProvider.locale, // Set value from provider
              onChanged: (Locale? newValue) {
                if (newValue != null) {
                  languageProvider.setLocale(newValue); // Update provider
                }
              },
              items: L10n.all.map<DropdownMenuItem<Locale>>((Locale locale) {
                return DropdownMenuItem<Locale>( // Use Locale in DropdownMenuItem
                  value: locale,
                  child: Text(locale.languageCode), // Display language code or name
                );
              }).toList(),
            ),
          ),
          Divider(),

          // Notification Preferences
          _buildSettingTile(
            title: AppLocalizations.of(context)!.enableNotifications
            ,
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
            title: AppLocalizations.of(context)!.accentColor,
            trailing: IconButton(
              icon: Icon(Icons.color_lens),
              onPressed: () {
                _showColorPicker(context, themeProvider,languageProvider);
              },
            ),
          ),
          Divider(),

          // Reset Settings
          _buildSettingTile(
            title: AppLocalizations.of(context)!.resetSettings,
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
  void _showColorPicker(BuildContext context, ThemeProvider themeProvider,LanguageProvider LanguageProvider) {
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
          title: Text(AppLocalizations.of(context)!.chooseAccentColor),
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
          title: Text(AppLocalizations.of(context)!.resetSettings),
          content: Text(AppLocalizations.of(context)!.resetSettingsConfirmation),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            TextButton(
              onPressed: () {
                themeProvider.resetSettings(); // Reset theme and other settings
                Navigator.pop(context);
              },
              child: Text(AppLocalizations.of(context)!.reset, style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}