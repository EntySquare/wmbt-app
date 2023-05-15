import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:wmbt/widgets/setI10n/WmbtDropdownButton.dart';
import 'dart:math' as math;
import '../../common/style/common_style.dart';
import '../../common/util/app_tools.dart';
import '../../data/repositories/Theme_cubit.dart';
import '../../generated/l10n.dart';
import '../../utils/gradient_text.dart';
import '../qrcode/qr_code.dart';
import 'account_settings.dart';
import 'google_auth.dart';
import 'my_relationship.dart';

class Mine extends StatefulWidget {
  const Mine({super.key});

  @override
  State<Mine> createState() => _MineState();
}

class _MineState extends State<Mine> {

  late TextEditingController _pinEditingController;
  late FocusNode _focusNode;
  final formKey = GlobalKey<FormState>();

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
                                child: Container(
                                  height: 24,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      gradient: LinearGradient(colors: [
                                        Color.fromARGB(127, 154, 77, 200),
                                        Color.fromARGB(183, 246, 0, 200)
                                      ], begin: Alignment.topRight, end: Alignment.bottomLeft)
                                  ),
                                  child: FlutterSwitch(
                                    width: 50.0,
                                    height: 24.0,
                                    valueFontSize: 12.0,
                                    toggleSize: 20.0,
                                    value: false,
                                    borderRadius: 30.0,
                                    padding: 2.0,
                                    activeColor: two_aut_on?Color(0xff9A4DFF):Color(0xffF6F6FB).withOpacity(0.5),// 打开时背景色
                                    inactiveColor: Color(0xff634e68),// 关闭时开关的背景颜色
                                    activeToggleColor: Color(0xff9A4DFF),
                                    showOnOff: false,
                                    onToggle: (val) {
                                      _getBottomSheetView(0);

                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                        InkWell(
                          onTap: (){
                            _getBottomSheetView(1);
                          },
                          child: Container(
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
                        ),

                        // 又重验证
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
                                    _getBottomSheetView(2);

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
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                    return QrCode();
                  })),
                  child: ClipOval(
                    child: Container(
                      width: Get.height * .08,
                      height: Get.height * .08,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF9A4DFF).withOpacity(0.3), Color(0xFFF600DD)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        // border: Border.all(color: Color(0xFFab3bb0),width: 1)
                      ),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Image.asset("assets/images/qrcode.png"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 根据不同的类型，弹窗
  _getBottomSheetView(int index) {
    switch (index) {
      case 0:// 谷歌认证
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GooleAuth(
                  signData: "signData",
                  phone: "+4401***1221",
                )));
        break;
      case 1: // // 设置 + 修改支付密码
        _pinEditingController = TextEditingController();
        _focusNode = FocusNode();
        showModalBottomSheet(
          context: context,
          isScrollControlled: true, // 默认情况下有高度限制，设置为true，弹出窗口高度将交给子视图
          builder: (BuildContext context) {
            return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Container(
                    height: (isIPhoneXOrAbove(context))
                        ? Get.height * 0.515
                        : Get.height * 0.67,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                      blendMode:BlendMode.colorDodge,
                      child: GestureDetector(
                        child: Container(
                          padding: EdgeInsets.only(top: 30),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withOpacity(1),
                                Colors.white.withOpacity(1),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            image: DecorationImage(
                              image: AssetImage("assets/images/pop_view_bg.png"),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: Column(
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    // 返回键
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                        width: 55,
                                        child: Image.asset(
                                            "assets/images/app_back_<-.png"),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: Text("Please input the verification code"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // 密码输入框
                              Form(
                                key: formKey,
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20.0, horizontal: 20),
                                    child: PinCodeTextField(
                                      appContext: context,
                                      pastedTextStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      length: 6,
                                      obscureText: true,
                                      obscuringCharacter: '*',
                                      autoFocus: true, // 自动弹出键盘

                                      //obscuringWidget: const FlutterLogo(
                                      //  size: 24,
                                      //),
                                      blinkWhenObscuring: true,
                                      animationType: AnimationType.fade,
                                      validator: (v) {
                                        if (v!.length < 3) {
                                          return null;
                                        } else {
                                          return null;
                                        }
                                      },
                                      pinTheme: PinTheme(
                                        shape: PinCodeFieldShape.box,
                                        //边框颜色
                                        selectedColor: Colors.white,
                                        // 输入框选中时边框颜色
                                        //disabledColor: Colors.orange,
                                        inactiveColor: Colors.white,
                                        selectedFillColor: Colors.white,
                                        // 选中输入框时背景颜色
                                        inactiveFillColor: Colors.white,
                                        // 未选中时输入框背景颜色
                                        activeFillColor: Colors.white,
                                        activeColor: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        fieldHeight: 55,
                                        fieldWidth: 55,
                                      ),
                                      cursorColor: Colors.black,
                                      animationDuration:
                                      const Duration(milliseconds: 300),
                                      enableActiveFill: true,
                                      //errorAnimationController: errorController,
                                      controller: _pinEditingController,
                                      focusNode: _focusNode,
                                      keyboardType: TextInputType.number,
                                      boxShadows: const [
                                        BoxShadow(
                                          offset: Offset(0, 1),
                                          color: Colors.black12,
                                          blurRadius: 10,
                                        )
                                      ],
                                      onCompleted: (v) {
                                        debugPrint("密码输入完成");
                                        FocusScope.of(context).requestFocus(
                                            _focusNode); // 密码输入完成后，请求焦点并弹起键盘
                                        setState((){

                                        });
                                      },
                                      // onTap: () {
                                      //   print("Pressed");
                                      // },
                                      onChanged: (value) {
                                        setState(() {

                                        });
                                      },
                                      beforeTextPaste: (text) {
                                        debugPrint("允许粘贴 $text");
                                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                        return false;
                                      },
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
          },
        ).then((val) {
          //print("====>高斯模糊背景点击了");
        });
        break;
      case 2:  // 开启双重验证
      //print("_emptyPsw====>${_emptyPsw}");
        _pinEditingController = TextEditingController();
        _focusNode = FocusNode();
        showModalBottomSheet(
          context: context,
          isScrollControlled: true, // 默认情况下有高度限制，设置为true，弹出窗口高度将交给子视图
          builder: (BuildContext context) {
            return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Container(
                    height: (isIPhoneXOrAbove(context))
                        ? Get.height * 0.515
                        : Get.height * 0.67,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                        blendMode:BlendMode.colorDodge,
                      child: GestureDetector(
                        child: Container(
                          padding: EdgeInsets.only(top: 30),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withOpacity(1),
                                Colors.white.withOpacity(1),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            image: DecorationImage(
                              image: AssetImage("assets/images/pop_view_bg.png"),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: Column(
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    // 返回键
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                        width: 55,
                                        child: Image.asset(
                                            "assets/images/app_back_<-.png"),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: Text("Please input the verification code"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // 密码输入框
                              Form(
                                key: formKey,
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20.0, horizontal: 20),
                                    child: PinCodeTextField(
                                      appContext: context,
                                      pastedTextStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      length: 6,
                                      obscureText: true,
                                      obscuringCharacter: '*',
                                      autoFocus: true, // 自动弹出键盘

                                      //obscuringWidget: const FlutterLogo(
                                      //  size: 24,
                                      //),
                                      blinkWhenObscuring: true,
                                      animationType: AnimationType.fade,
                                      validator: (v) {
                                        if (v!.length < 3) {
                                          return null;
                                        } else {
                                          return null;
                                        }
                                      },
                                      pinTheme: PinTheme(
                                        shape: PinCodeFieldShape.box,
                                        //边框颜色
                                        selectedColor: Colors.white,
                                        // 输入框选中时边框颜色
                                        //disabledColor: Colors.orange,
                                        inactiveColor: Colors.white,
                                        selectedFillColor: Colors.white,
                                        // 选中输入框时背景颜色
                                        inactiveFillColor: Colors.white,
                                        // 未选中时输入框背景颜色
                                        activeFillColor: Colors.white,
                                        activeColor: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        fieldHeight: 55,
                                        fieldWidth: 55,
                                      ),
                                      cursorColor: Colors.black,
                                      animationDuration:
                                      const Duration(milliseconds: 300),
                                      enableActiveFill: true,
                                      //errorAnimationController: errorController,
                                      controller: _pinEditingController,
                                      focusNode: _focusNode,
                                      keyboardType: TextInputType.number,
                                      boxShadows: const [
                                        BoxShadow(
                                          offset: Offset(0, 1),
                                          color: Colors.black12,
                                          blurRadius: 10,
                                        )
                                      ],
                                      onCompleted: (v) {
                                        debugPrint("密码输入完成");
                                        FocusScope.of(context).requestFocus(
                                            _focusNode); // 密码输入完成后，请求焦点并弹起键盘
                                        setState((){

                                        });
                                      },
                                      // onTap: () {
                                      //   print("Pressed");
                                      // },
                                      onChanged: (value) {
                                        setState(() {

                                        });
                                      },
                                      beforeTextPaste: (text) {
                                        debugPrint("允许粘贴 $text");
                                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                        return false;
                                      },
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
          },
        ).then((val) {
          //print("====>高斯模糊背景点击了");
        });
        break;
      default:
        break;
    }
  }

  
}
