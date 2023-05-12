import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 判断用户是否已经登录
class TokenStorage {
  static const String _tokenKey = "userToken";

  Future<void> saveToken(String token) async {
    // 保存token
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    // 获取token
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> deleteToken() async {
    // 删除token
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }
}

Future<bool> isAuthenticated() async {
  TokenStorage tokenStorage = TokenStorage();
  String? token = await tokenStorage.getToken();
  print("token:$token");
  return token != null;
}

// 本地存储用户主题
class ThemeStorage {
  static const String _themeKey = "userTheme";

  Future<void> saveTheme(String theme) async {
    // 保存theme
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, theme);
  }

  Future<String?> getTheme() async {
    // 获取theme
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_themeKey);
  }

  Future<void> deleteTheme() async {
    // 删除theme
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_themeKey);
  }
}

// 判断系统白天还是黑夜
Future<bool> isDarkMode(BuildContext context) {
  ThemeStorage themeStorage = ThemeStorage();
  return themeStorage.getTheme().then((theme) {
    // print("snapshot.data:$theme");
    if (theme == null) {
      return MediaQuery.of(context).platformBrightness == Brightness.dark;
    } else {
      return theme == "dark";
    }
  });
}


// 保存
// TokenStorage tokenStorage = TokenStorage();
// await tokenStorage.saveToken("your_login_token");

// 取
// TokenStorage tokenStorage = TokenStorage();
// String? token = await tokenStorage.getToken();

// 删
// TokenStorage tokenStorage = TokenStorage();
// await tokenStorage.deleteToken();
