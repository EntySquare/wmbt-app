import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'dart:math' as math;
import '../../common/style/common_style.dart';
import '../../data/repositories/Theme_cubit.dart';
import '../../generated/l10n.dart';
import '../../utils/auth.dart';
import '../../utils/gradient_text.dart';
import '../setI10n/WmbtDropdownButton.dart';
import 'kyc_step_one.dart';

class InputItem {
  final int id;
  final String hint_text;
  final TextEditingController controller;
  final FocusNode node;

  InputItem(
      {required this.id,
        required this.hint_text,
        required this.controller,
        required this.node});
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    //TokenStorage tokenStorage = TokenStorage();
    return Scaffold(
      body: FutureBuilder(
        future: isDarkMode(context),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            if (context.read<ThemeCubit>().isDarkTheme() == true) {
              return LoginBox();
            } else {
              return LoginBox(
                LoginBoxBgc: "assets/images/bgc_lingh.png",
              );
            }
          }
          else {
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

  LoginBox({super.key, this.LoginBoxBgc = "assets/images/bgc_login_dark.png"});

  @override
  State<LoginBox> createState() => _LoginBoxState();
}

class _LoginBoxState extends State<LoginBox> {
  ThemeStorage themeStorage = ThemeStorage();
  TokenStorage tokenStorage = TokenStorage();

  List<InputItem> input_item = <InputItem>[];

  final mobileController = TextEditingController();
  final pswController = TextEditingController();
  final referralController = TextEditingController();

  FocusNode emailNode = FocusNode();
  FocusNode pswNode = FocusNode();
  FocusNode referralNode = FocusNode();

  @override
  void initState() {
    super.initState();
    input_item.addAll([
      InputItem(
          id: 1,
          hint_text: "referral_code",
          controller: referralController,
          node: referralNode),
      InputItem(
          id: 2,
          hint_text: "mobile_number",
          controller: mobileController,
          node: emailNode),
      InputItem(
          id: 3,
          hint_text: "verification_code",
          controller: pswController,
          node: pswNode),

    ]);
  }

  @override
  Widget build(BuildContext context) {
    final double safe_bottom = MediaQuery.of(context).padding.bottom;
    bool isDark_on = context.read<ThemeCubit>().isDarkTheme();

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
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          //注册+ 主题切换
          Container(
            height: 44,
            //color: Colors.red,
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.045),
            padding: EdgeInsets.symmetric(horizontal: 38),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: GradientText(
                    text: S.of(context).login,
                    gradient: LinearGradient(
                        colors: [Color(0xff9A4DFF), Color(0xffF600DD)]),
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                ),
                // 主题切换按钮
                Container(
                  height: 24,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(127, 154, 77, 200),
                        Color.fromARGB(183, 246, 0, 200)
                      ], begin: Alignment.topRight, end: Alignment.bottomLeft)),
                  child: FlutterSwitch(
                    width: 40.0,
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
                          ? context.read<ThemeCubit>().switchToLightTheme()
                          : context.read<ThemeCubit>().switchToDarkTheme();
                    },
                  ),
                ),
              ],
            ),
          ),

          // 手机号 + 验证码
          Container(
            height: 61.0 * input_item.length,
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: input_item.length,
              itemBuilder: (BuildContext context, int index) {
                return getInputListRow(index);
              },
            ),
          ),

          //切换语言
          Container(
            //color: Colors.red,
            width: MediaQuery.of(context).size.width - 72,
            alignment: Alignment.centerRight,
            //margin: EdgeInsets.only(right: 20,left: 20),
            child: SwitchLanguage(),
          ),

          // 注册按钮
          Expanded(
              flex: 1,
              child: Container(
                //color: Colors.orange,
                padding: EdgeInsets.only(left: 97, right: 97),
                margin: EdgeInsets.only(bottom: safe_bottom + 30),
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(),
                            Container(
                              height: 50,
                              //color: Colors.orange,
                              //margin: EdgeInsets.only(bottom: 90),
                              alignment: Alignment.bottomCenter,
                              child: Center(
                                child: Row(
                                  children: [
                                    Container(
                                      width: 11,
                                      height: 11,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(width: 1, color:Color(0xff9A4DFF),style: BorderStyle.solid),
                                      ),
                                      margin: EdgeInsets.all(5),
                                    ),
                                    Text("Agree to the ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white,decoration: TextDecoration.none),),
                                    Text("terms and conditions", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white,decoration: TextDecoration.underline),)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                          return KycStepOnePage();
                        }));
                      },
                      child: Container(
                        height: 49,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Color(0xff9A4DFF), Color(0xffF600DD)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight),
                            borderRadius: BorderRadius.all(Radius.circular(8))
                        ),
                        alignment: Alignment.bottomCenter,
                        child: TextButton(
                          onPressed:null,
                          child: Text(
                            S.of(context).register,
                            style: CommonStyle.text_14_white,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ))
        ],
      ),
    );
  }

  Widget getInputListRow(index) {
    bool isDark_on = context.read<ThemeCubit>().isDarkTheme();
    InputItem item = input_item[index];
    return Container(
        height: 45,
        //color: Colors.red,
        padding: const EdgeInsets.symmetric(horizontal: 38),
        margin: const EdgeInsets.only(top: 16),
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15,),
              height: 37,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  color: isDark_on ? const Color(0xff221d29) : Color(0xffffffff),
                  border: Border.all(color: const Color(0xff9A4DFF), width: 0.5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 200,
                    child: TextFormField(
                      style: isDark_on
                          ? CommonStyle.text_15_white
                          : CommonStyle.text_15_black,
                      controller: item.controller,
                      keyboardType: TextInputType.number,
                      minLines: 1,
                      autofocus: false,
                      //focusNode: item.node,
                      cursorColor: const Color(0xff348a70),
                      onFieldSubmitted: (value) {
                        setState(() {});
                      },
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        isCollapsed: true,
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        hintText: item.node.hasFocus
                            ? ''
                            : (index == 0
                            ? S.of(context).mobile_number
                            : S.of(context).verification_code),
                        hintStyle: TextStyle(
                            color: isDark_on
                                ? Color(0xFFCACDDA)
                                : Colors.black.withOpacity(0.5),
                            fontSize: 14),
                        prefixText:
                        item.node.hasFocus || item.controller.text != ''
                            ? ''
                            : '',
                        prefixStyle: CommonStyle.text_12_black,

                        fillColor: Colors.transparent,
                        errorStyle: TextStyle(color: Color(0xFFE83C88)),
                        //errorText: numErrText,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  (index<2)?getInputRightWidget(index):Container()
                ],
              ),
            )
          ],
        ));
  }

  String getHintText(context, index){
    String hint_text = "";
    switch (index){
      case 1:
        hint_text = S.of(context).referral_code;
        break;
      case 2:
        hint_text = S.of(context).mobile_number;
        break;
      case 3:
        hint_text = S.of(context).verification_code;
        break;
    }

    return hint_text;
  }

  Widget getInputRightWidget (index){

    // 二维码
    if (index == 0) {
      return Container(
        width: 80,
        height: double.infinity,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 10),
        child: Image.asset("assets/images/register-qrcode.png"),
      );
    }else{
        // 发送验证码
        return Container(
          width: 80,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff9A4DFF),Color(0xffF600DD)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          height: double.infinity,
          alignment: Alignment.center,
          child: Text(S.of(context).send_code, style: CommonStyle.text_12_white_w400,),
        );

    }

  }
}
