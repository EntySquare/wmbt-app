// ignore_for_file: prefer_const_constructors
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wmbt/common/style/common_style.dart';
import 'package:wmbt/data/repositories/Language_provider';
import 'package:wmbt/generated/l10n.dart';

class SwitchLanguage extends StatefulWidget {
  const SwitchLanguage({super.key});

  @override
  State<SwitchLanguage> createState() => _SwitchLanguageState();
}

class _SwitchLanguageState extends State<SwitchLanguage> {
  Locale _locale = Locale('en');

  void _switchLanguage(Locale locale) {
    if (locale.languageCode == 'zh') {
      Provider.of<LanguageProvider>(context, listen: false)
          .setLocale(Locale('zh', 'CN'));
    } else {
      Provider.of<LanguageProvider>(context, listen: false)
          .setLocale(Locale('en', 'US'));
    }
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    _locale = Locale(Provider.of<LanguageProvider>(context, listen: false)
        .getCurrentLanguageString());
    return DropdownButton2<Locale>(
      dropdownStyleData: DropdownStyleData(
        width: 130,
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          // color: Colors.redAccent,
        ),
        elevation: 8,
      ),
      value: _locale,
      underline: Container(),
      onChanged: ((value) => _switchLanguage(value!)),
      items: S.delegate.supportedLocales.map((Locale locale) {
        return DropdownMenuItem<Locale>(
          value: locale,
          child: Container(
            //padding: EdgeInsets.only(right: 20),
            child: Row(children: [
              Image.asset(
                "assets/images/login_america.png",
                width: 17,
                height: 17,
              ),
              SizedBox(width: 5,),
              Text(locale.languageCode == 'zh'
                  ? '简体中文'
                  : locale.languageCode == 'en'
                      ? 'English'
                      : '未知',style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),),
            ]),
          ),
        );
      }).toList(),
    );
  }
}

// AppNavigator.push(Routes.login)
// await tokenStorage.deleteToken(),
