import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:wmbt/app.dart';
import 'package:wmbt/data/repositories/Theme_cubit.dart';
import 'package:wmbt/data/repositories/Language_provider';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LanguageProvider languageProvider =
      LanguageProvider(const Locale('en', 'US')); // 默认语言
  Locale savedLocale = await languageProvider.getLocaleFromPrefs();
  languageProvider.setLocale(savedLocale);
  runApp(
    MultiProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
        ),
        ChangeNotifierProvider<LanguageProvider>(
          create: (context) => languageProvider,
        )
      ],
      child: WmbtApp(),
    ),
  );
}
