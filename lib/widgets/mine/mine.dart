import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:wmbt/widgets/setI10n/WmbtDropdownButton.dart';
import 'dart:math' as math;
import '../../common/style/common_style.dart';
import '../../data/repositories/Theme_cubit.dart';
import '../../generated/l10n.dart';
import '../../utils/gradient_text.dart';
import 'account_settings.dart';
import 'my_relationship.dart';

class Mine extends StatefulWidget {
  const Mine({super.key});

  @override
  State<Mine> createState() => _MineState();
}

class _MineState extends State<Mine> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double safe_bottom = MediaQuery.of(context).padding.bottom;
    final double safe_top = MediaQuery.of(context).padding.top;
    bool isDark_on = context.read<ThemeCubit>().isDarkTheme();
    bool two_aut_on = false; // 二次认证开启状态

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: isDark_on
              ? const AssetImage("assets/images/bgc_dark.png")
              : const AssetImage("assets/images/bgc_lingh.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          //切换语言
          Container(
              //color: Colors.red,
              height: 30,
              //width: MediaQuery.of(context).size.width - 72,
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(top: safe_top + 10),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GradientText(
                    text: "Welcome",
                    gradient: LinearGradient(
                        colors: [Color(0xff9A4DFF), Color(0xffF600DD)]),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.none),
                  ),
                  SwitchLanguage(),
                ],
              )),

          Container(
            height: 42,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "Quentin Taratino",
              style: CommonStyle.text_20_colorF6F6FB_w400,
            ),
          ),
          //
          Container(
            //margin: EdgeInsets.only(top: safe_top, left: 22, right: 22),
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 320,

            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  height: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GradientText(
                        text: "My recommendations",
                        gradient: LinearGradient(
                            colors: [Color(0xff9A4DFF), Color(0xffF600DD)]),
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.none),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                            return MyRelationshipPage();
                          }));
                        },
                        child: Text(
                          "View all",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Color(0xffF6F6FB),
                              //height: 1,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/images/mine_top_nor.png",
                      ),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                )
              ],
            ),
          ),

          // 安全设置
          Container(
              height: 210,
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    child: GradientText(
                      text: "Security Settings",
                      gradient: LinearGradient(
                          colors: [Color(0xff9A4DFF), Color(0xffF600DD)]),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.none),
                    ),
                    padding: EdgeInsets.only(left: 20),
                  ),
                  Container(
                    height: 185,
                    //color: Colors.red,
                    padding: EdgeInsets.only(top: 25),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/images/security_settings.png",
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 45,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          //color: Colors.blue,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.only(left: 15),
                                    //color: Colors.orange,
                                    child: Row(
                                      children: [
                                        Image.asset(
                                            "assets/images/mine_google.png"),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("Google Authenticator"),
                                      ],
                                    ),
                                  )),
                              Container(
                                width: 65,
                                //color: Colors.brown,
                                padding: EdgeInsets.only(right: 15),
                                child: FlutterSwitch(
                                  width: 50.0,
                                  height: 24.0,
                                  valueFontSize: 12.0,
                                  toggleSize: 20.0,
                                  value: two_aut_on,
                                  borderRadius: 30.0,
                                  padding: 2.0,
                                  activeColor: two_aut_on?Color(0xff9A4DFF):Color(0xffF6F6FB).withOpacity(0.5),// 打开时背景色
                                  inactiveColor: Color(0xff634e68),// 关闭时开关的背景颜色
                                  activeToggleColor: Color(0xff9A4DFF),
                                  showOnOff: false,
                                  onToggle: (val) {
                                    setState(() {
                                      if (two_aut_on){
                                        two_aut_on = false;
                                      }else{
                                        two_aut_on = true;
                                      }
                                    });
                                    print(two_aut_on);

                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 40,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          //color: Colors.blue,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.only(left: 15),
                                    //color: Colors.orange,
                                    child: Row(
                                      children: [
                                        Image.asset(
                                            "assets/images/mine_lock.png",width: 20,),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("Password"),
                                      ],
                                    ),
                                  )),
                              Container(
                                width: 65,
                                //color: Colors.brown,
                                child: Image.asset(
                                  "assets/images/mine_password.png",width: 20,),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 45,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          //color: Colors.blue,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.only(left: 15),
                                    //color: Colors.orange,
                                    child: Row(
                                      children: [
                                        Image.asset(
                                            "assets/images/mine_2fa.png"),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("Two-factor authentication"),
                                      ],
                                    ),
                                  )),
                              Container(
                                width: 65,
                                //color: Colors.red,
                                padding: EdgeInsets.only(right: 15),
                                child: FlutterSwitch(
                                  width: 50.0,
                                  height: 24.0,
                                  valueFontSize: 12.0,
                                  toggleSize: 20.0,
                                  value: true,
                                  borderRadius: 30.0,
                                  padding: 2.0,
                                  activeColor: two_aut_on?Color(0xff9A4DFF):Color(0xffF6F6FB).withOpacity(0.5),// 打开时背景色
                                  inactiveColor: Color(0xff634e68),// 关闭时开关的背景颜色
                                  activeToggleColor: Color(0xff9A4DFF),
                                  showOnOff: false,
                                  onToggle: (val) {
                                    setState(() {
                                      if (two_aut_on){
                                        two_aut_on = false;
                                      }else{
                                        two_aut_on = true;
                                      }
                                    });
                                    print(two_aut_on);

                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),

          // 账户设置
          Container(
            height: 26,
            margin: EdgeInsets.symmetric(horizontal: 20),
            //color: Colors.red,
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                  return AccountSettingsPage();
                }));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GradientText(
                    text: "Account Settings",
                    gradient: LinearGradient(
                        colors: [Color(0xff9A4DFF), Color(0xffF600DD)]),
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.none),
                  ),
                  Image.asset(
                    "assets/images/mine_detail.png",width: 15,),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
