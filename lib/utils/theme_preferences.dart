import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {
  static const String themeKey = 'theme';

  Future<void> setTheme(String theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(themeKey, theme);
  }

  Future<String?> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(themeKey);
  }
}
