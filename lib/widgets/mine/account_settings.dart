import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:math' as math;
import '../../common/style/common_style.dart';
import '../../data/repositories/Theme_cubit.dart';
import '../setI10n/WmbtDropdownButton.dart';

class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage({Key? key}) : super(key: key);

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  @override
  Widget build(BuildContext context) {
    final double safe_bottom = MediaQuery.of(context).padding.bottom;
    final double safe_tope = MediaQuery.of(context).padding.top;
    bool isDark_on = context.read<ThemeCubit>().isDarkTheme();

    final ImagePicker picker = ImagePicker();
    XFile? pickImage = XFile("");
    String headPath = "assets/images/mine_user_head.png";
    bool chooseFlag = false;

    return Material(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: isDark_on
                ? const AssetImage("assets/images/mine_tuijian_bg.png")
                : const AssetImage("assets/images/bgc_lingh.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //切换语言
            Container(
              //color: Colors.red,
              height: 50,
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(top: safe_tope),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //返回按钮
                  Container(
                    child: TextButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Image.asset("assets/images/app_back_<-.png"),
                      label: Text(""),
                    ),
                  ),
                  SwitchLanguage(),
                ],
              ),
            ),

            // 头像
            Container(
              height: 88,
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 64,
                    //color: Colors.red,
                    margin: EdgeInsets.only(top: 10),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Avatar",
                            style: CommonStyle.text_14_colorF6F6FB_w400),
                        InkWell(
                          onTap: () async {
                            pickImage = await picker.pickImage(
                                source: ImageSource.gallery);
                            // headPath = pickImage!.path;
                            setState(() {
                              chooseFlag = true;
                              print(chooseFlag);
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            //padding: EdgeInsets.only(top: 10),
                            child: Stack(
                              children: [
                                // Image.asset("assets/images/mine_user_head.png"),
                                chooseFlag == false
                                    ? Image.asset(
                                        "assets/images/mine_user_head.png")
                                    : Image.network(
                                        "https://liupai001.oss-cn-shenzhen.aliyuncs.com/goodsv1/%E6%A6%B4%E8%8A%92-1.png"),
                                Positioned(
                                  left: 10,
                                  bottom: 8,
                                  child: Image.asset(
                                      "assets/images/mine_password.png"),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Divider(
                    color: Color(0xff9A4DFF),
                    height: 0.5,
                  )
                ],
              ),
            ),

            // 别名
            Container(
              height: 88,
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 64,
                    //color: Colors.red,
                    margin: EdgeInsets.only(top: 10),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Alias",
                            style: CommonStyle.text_14_colorF6F6FB_w400),
                        Container(
                          alignment: Alignment.center,
                          //padding: EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              Text("Quentin Taratino",
                                  style: CommonStyle.text_14_colorF6F6FB_w400),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                child: Image.asset(
                                    "assets/images/mine_password.png"),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Divider(
                    color: Color(0xff9A4DFF),
                    height: 0.5,
                  )
                ],
              ),
            ),

            // 主题
            Container(
              height: 88,
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 64,
                    //color: Colors.red,
                    margin: EdgeInsets.only(top: 10),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("System theme",
                            style: CommonStyle.text_14_colorF6F6FB_w400),
                        Container(
                          alignment: Alignment.center,
                          //padding: EdgeInsets.only(top: 10),
                          child: Container(
                            height: 24,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: LinearGradient(
                                    colors: [
                                      Color.fromARGB(127, 154, 77, 200),
                                      Color.fromARGB(183, 246, 0, 200)
                                    ],
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft)),
                            child: FlutterSwitch(
                              width: 55.0,
                              height: 24.0,
                              valueFontSize: 12.0,
                              toggleSize: 20.0,
                              value: isDark_on,
                              borderRadius: 30.0,
                              padding: 2.0,
                              activeIcon: Transform.rotate(
                                angle: math.pi * 1.2, // 旋转角度，以弧度表示。这里旋转180度
                                child: const Icon(
                                  Icons.nightlight_round,
                                  color: Color.fromRGBO(179, 64, 231, 1),
                                  size: 18,
                                ),
                              ),
                              inactiveIcon: const Icon(
                                Icons.wb_sunny_outlined,
                                color: Color.fromRGBO(179, 64, 231, 1),
                                size: 18,
                              ),
                              activeColor: Color.fromRGBO(179, 64, 231, 0),
                              inactiveColor: Color.fromRGBO(179, 64, 231, 0),
                              activeToggleColor: Colors.black,
                              showOnOff: false,
                              onToggle: (val) {
                                isDark_on
                                    ? context
                                        .read<ThemeCubit>()
                                        .switchToLightTheme()
                                    : context
                                        .read<ThemeCubit>()
                                        .switchToDarkTheme();
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
