import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:wmbt/data/repositories/Language_provider';
import 'package:wmbt/model/themes.dart';
import 'package:wmbt/routes.dart';
import 'package:wmbt/widgets/home/home.dart';
import 'package:wmbt/widgets/login/login.dart';
import 'generated/l10n.dart';
import 'package:wmbt/data/repositories/Theme_cubit.dart';

import 'index.dart';

class WmbtApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
        builder: ((context, theme) => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Wmbt',
              locale: Provider.of<LanguageProvider>(context).currentLocale,
              onGenerateTitle: (context) {
                return S.of(context).login;
              },
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate
              ],
              localeResolutionCallback: (deviceLocale, supportedLocales) {
                if (Provider.of<LanguageProvider>(context, listen: false).currentLocale == null) {
                  // 当用户没有选择语言时，根据设备的语言设置应用的语言
                  return deviceLocale;
                }
                return Provider.of<LanguageProvider>(context, listen: false).currentLocale;
              },
              navigatorKey: AppNavigator.navigatorKey,
              onGenerateRoute: AppNavigator.onGenerateRoute,
              supportedLocales: S.delegate.supportedLocales,
              theme: theme,
              // home: Login(),
              // home: Home(),
              home: MainMenu(),
            )));
  }
}
