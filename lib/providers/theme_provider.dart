import 'package:flutter/material.dart';
import 'package:tp2_flutter_grupo12/helpers/preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = Preferences.darkmode;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme(bool value) {
    _isDarkMode = value;
    Preferences.darkmode = value; // Guardar el estado en SharedPreferences
    notifyListeners(); // Notificar a los widgets que dependan del estado
  }
}