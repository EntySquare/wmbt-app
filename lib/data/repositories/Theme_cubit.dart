import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmbt/model/themes.dart';
import 'package:wmbt/utils/theme_preferences.dart';

class ThemeCubit extends Cubit<ThemeData> {
  final ThemePreferences _themePreferences = ThemePreferences();

  ThemeCubit() : super(ThemeClass.lightTheme) {
    _loadTheme();
  }

  bool isDarkTheme() {
    return state is ThemeData && state == ThemeClass.darkTheme;
  }

  void _loadTheme() async {
    final String? theme = await _themePreferences.getTheme();
    if (theme != null) {
      if (theme == 'dark') {
        emit(ThemeClass.darkTheme);
      } else {
        emit(ThemeClass.lightTheme);
      }
    }
  }

  void switchToDarkTheme() {
    emit(ThemeClass.darkTheme);
    _themePreferences.setTheme('dark');
  }

  void switchToLightTheme() {
    emit(ThemeClass.lightTheme);
    _themePreferences.setTheme('light');
  }

}
