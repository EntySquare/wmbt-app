// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmbt/data/repositories/Theme_cubit.dart';
import 'package:wmbt/generated/l10n.dart';
// import 'package:wmbt/routes.dart';
import 'package:wmbt/utils/auth.dart';
import 'package:wmbt/widgets/setI10n/WmbtDropdownButton.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    TokenStorage tokenStorage = TokenStorage();
    return Scaffold(
      body: FutureBuilder(
        future: isDarkMode(context),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            if (context.read<ThemeCubit>().isDarkTheme() == true) {
              return LoginBox();
            } else {
              return LoginBox(
                LoginBoxBgc: "",
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class LoginBox extends StatefulWidget {
  // 背景图片
  String LoginBoxBgc;

  LoginBox({super.key, this.LoginBoxBgc = "assets/images/bac_login_dark.png"});

  @override
  State<LoginBox> createState() => _LoginBoxState();
}

class _LoginBoxState extends State<LoginBox> {
  ThemeStorage themeStorage = ThemeStorage();
  TokenStorage tokenStorage = TokenStorage();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(widget.LoginBoxBgc),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          //图片
          Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.138,
                left: MediaQuery.of(context).size.width * 0.05),
            child: Image.asset(
              "assets/images/login_img1.png",
              width: 346,
              height: 263,
            ),
          ),
          //输入框
          Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.045),
            child: Text(
              S.of(context).login,
              style: const TextStyle(
                fontSize: 30,
              ),
            ),
          ),
          Switchtheme(),
          SwitchLanguage(),
        ],
      ),
    );
  }
}

// 切换主题按钮
class Switchtheme extends StatelessWidget {
  const Switchtheme({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
        builder: ((context, theme) => FloatingActionButton(
              onPressed: () async => {
                // await tokenStorage.deleteToken(),
                context.read<ThemeCubit>().isDarkTheme()
                    ? context.read<ThemeCubit>().switchToLightTheme()
                    : context.read<ThemeCubit>().switchToDarkTheme(),
                // AppNavigator.push(Routes.home)
              },
              child: const Text('Next'),
            )));
  }
}
