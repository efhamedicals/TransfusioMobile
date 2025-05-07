import 'package:flutter/material.dart';
import 'package:transfusio/src/core/services/storage/app_storage.dart';
import 'package:transfusio/src/core/utils/constants/app_strings.dart';

class ThemeViewModel extends ChangeNotifier {
  final ValueNotifier<ThemeMode> _themeMode = ValueNotifier(ThemeMode.system);
  final ValueNotifier<String> theme = ValueNotifier("system");
  final ValueNotifier<String> language = ValueNotifier("");

  ValueNotifier<ThemeMode> get themeModeNotifier => _themeMode;
  ThemeMode get themeMode => _themeMode.value;
  String get currentTheme => theme.value;
  String get currentLanguage => language.value;

  void setThemeMode(String value) async {
    theme.value = value;
    _themeMode.value = getThemeModeFromString(value);
    debugPrint('Theme is $value and value selected is ${_themeMode.value}');
    await AppStorage.instance.setString(key: themeUser, value: value);
    notifyListeners(); // Notify listeners
  }

  getThemeModeFromStore() async {
    String themeString = AppStorage.instance.getString(themeUser);
    setThemeMode(themeString.isEmpty ? 'light' : themeString);
  }

  ThemeMode getThemeModeFromString(String themeString) {
    switch (themeString) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.light;
    }
  }

  bool get isDarkModeOn {
    if (currentTheme == 'system') {
      // ignore: deprecated_member_use
      return WidgetsBinding.instance.window.platformBrightness ==
          Brightness.dark;
    }
    return currentTheme == 'dark';
  }
}
