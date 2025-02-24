import 'package:flutter/material.dart';

import '../l10n/l10n.dart';

class LanguageProvider with ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if(!L10n.all.contains(locale)) return;
    _locale = locale;
    notifyListeners();
  }
}