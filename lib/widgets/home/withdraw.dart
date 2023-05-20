import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:wmbt/widgets/home/withdraw_detail.dart';

import '../../common/style/common_style.dart';
import '../../common/util/app_tools.dart';
import '../../data/repositories/Theme_cubit.dart';
import '../../generated/l10n.dart';
import '../../utils/gradient_text.dart';
import '../setI10n/WmbtDropdownButton.dart';

class InputItem {
  final int id;
  final String hint_text;
  final String title;
  final TextEditingController controller;
  final FocusNode node;

  InputItem(
      {required this.id,
      required this.hint_text,
      required this.title,
      required this.controller,
      required this.node});
}

class WithdrawPage extends StatefulWidget {
  const WithdrawPage({Key? key}) : super(key: key);

  @override
  State<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  late TextEditingController _pinEditingController;
  late FocusNode _focusNode;
  final formKey = GlobalKey<FormState>();

  List<InputItem> input_item = <InputItem>[];

  final addressController = TextEditingController();
  final amountController = TextEditingController();
  final codeController = TextEditingController();

  FocusNode addressNode = FocusNode();
  FocusNode amountNode = FocusNode();
  FocusNode codeNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double safe_bottom = MediaQuery.of(context).padding.bottom;
    final double safe_top = MediaQuery.of(context).padding.top;
    bool isDark_on = context.read<ThemeCubit>().isDarkTheme();
    input_item.clear();

    input_item.addAll([
      InputItem(
          id: 1,
          hint_text: "aaaa",
          title: S.of(context).address,
          controller: addressController,
          node: addressNode),
      InputItem(
          id: 2,
          hint_text: "amount",
          title: S.of(context).amount_to_withdraw,
          controller: amountController,
          node: amountNode),
      InputItem(
          id: 3,
          hint_text: "verification_code",
          title: S.of(context).verification_code,
          controller: codeController,
          node: codeNode),
    ]);

    return Material(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: isDark_on
                ? const AssetImage("assets/images/bgc_login_dark.png")
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
              margin: EdgeInsets.only(top: safe_top),
              padding: EdgeInsets.only(right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //
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

            // 地址 + 金额输入框 + 验证码
            Container(
              //color: Colors.red,
              margin: EdgeInsets.only(top: 128),
              height: 80.0 * input_item.length,
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

            Container(
              height: 80,
              padding: EdgeInsets.symmetric(horizontal: 38),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text("Commission fee"),
                  ),
                  Container(
                    height: 45,
                    padding: EdgeInsets.only(left: 15),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: isDark_on
                              ? const AssetImage(
                                  "assets/images/tixianbg_dark.png")
                              : const AssetImage(
                                  "assets/images/tixianbg_light.png"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Text(
                      "1.0 WMBT",
                      style: CommonStyle.text_14_colorF6F6FB_w400,
                    ),
                  )
                ],
              ),
            ),

            // 提现 + 指示器
            Expanded(
                flex: 1,
                child: Container(
                  //color: Colors.orange,
                  padding: const EdgeInsets.only(left: 97, right: 97),
                  margin: EdgeInsets.only(bottom: safe_bottom + 30),
                  alignment: Alignment.bottomCenter,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            //height: 50,
                            //color: Colors.red,
                            padding: EdgeInsets.only(bottom: 20),
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 38,
                                      alignment: Alignment.bottomCenter,
                                      padding: EdgeInsets.only(bottom: 10),
                                      //    color: Colors.blue,
                                      child: Image.asset(
                                          "assets/images/home_withdraw<->.png"),
                                    )),
                                Container(
                                  height: 20,
                                  //color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            //color: _currentPage == 0 ? Colors.black : Colors.grey,
                                            gradient: LinearGradient(
                                              colors: [
                                                Color(0xff9A4DFF),
                                                Color(0xffF600DD)
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            )),
                                        margin: EdgeInsets.all(5),
                                      ),
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              width: 1,
                                              color: Color(0xff9A4DFF),
                                              style: BorderStyle.solid),
                                        ),
                                        margin: EdgeInsets.all(5),
                                      ),
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              width: 1,
                                              color: Color(0xff9A4DFF),
                                              style: BorderStyle.solid),
                                        ),
                                        margin: EdgeInsets.all(5),
                                      ),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),

                      // 提现
                      GestureDetector(
                        onTap: () {
                          showPasswordPopView();
                        },
                        child: Container(
                          height: 49,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Color(0xff9A4DFF),
                                    Color(0xffF600DD)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.centerRight),
                              boxShadow: [
                                //BoxShadow(color: Colors.grey.shade300, blurRadius: 6.0, spreadRadius: 2.0)
                                BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 4,
                                    spreadRadius: 2),
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          alignment: Alignment.bottomCenter,
                          child: TextButton(
                            onPressed: null,
                            child: Text(
                              "Withdraw",
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
      ),
    );
  }

  Widget getInputListRow(index) {
    bool isDark_on = context.read<ThemeCubit>().isDarkTheme();
    InputItem item = input_item[index];
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 38),
          alignment: Alignment.centerLeft,
          child: Text(item.title),
        ),
        Container(
            height: 45,
            //color: Colors.red,
            padding: EdgeInsets.symmetric(horizontal: 38),
            margin: EdgeInsets.only(top: 16),
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: 15,
                  ),
                  height: 37,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: isDark_on ? Color(0xff221d29) : Color(0xffffffff),
                      border: Border.all(color: Color(0xff9A4DFF), width: 0.5)),
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
                          cursorColor: Color(0xff348a70),
                          onFieldSubmitted: (value) {
                            setState(() {});
                          },
                          onChanged: (value) {
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            isCollapsed: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
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
                      index == 2
                          ? Container(
                              width: 80,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xff9A4DFF),
                                    Color(0xffF600DD)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                              height: double.infinity,
                              alignment: Alignment.center,
                              child: Text(
                                S.of(context).send_code,
                                style: CommonStyle.text_12_white_w400,
                              ),
                            )
                          : Container()
                    ],
                  ),
                )
              ],
            )),
      ],
    );
  }

  showPasswordPopView() {
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
                ? Get.height * 0.6
                : Get.height * 0.67,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              blendMode: BlendMode.colorDodge,
              child: GestureDetector(
                child: Container(
                  padding: EdgeInsets.only(top: 20),
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
                      image: AssetImage("assets/images/wallet_payment_bg.png"),
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
                                child: Container(
                                  height: 20,
                                  //color: Colors.orange,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 11,
                                        height: 11,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              width: 1,
                                              color: Color(0xffffffff),
                                              style: BorderStyle.solid),
                                        ),
                                        margin: EdgeInsets.all(5),
                                      ),
                                      Container(
                                        width: 11,
                                        height: 11,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            //color: _currentPage == 0 ? Colors.black : Colors.grey,
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.white,
                                                Colors.white,
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            )),
                                        margin: EdgeInsets.all(5),
                                      ),
                                      Container(
                                        width: 11,
                                        height: 11,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              width: 1,
                                              color: Color(0xffffffff),
                                              style: BorderStyle.solid),
                                        ),
                                        margin: EdgeInsets.all(5),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 55,
                            ),
                          ],
                        ),
                      ),

                      Container(
                        height: 55,
                        padding: EdgeInsets.only(top: 20),
                        child: Text("Please input your payment password"),
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
                              autoFocus: true,
                              // 自动弹出键盘

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
                              pinTheme: getPintheme(),
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
                                setState(() {
                                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                                    return WithdrawDetailPage();
                                  }));
                                });
                              },
                              onChanged: (value) {
                                setState(() {});
                              },
                              beforeTextPaste: (text) {
                                debugPrint("允许粘贴 $text");
                                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                return false;
                              },
                            )),
                      ),

                      Container(
                        height: 55,
                        child: Text(
                          "Forget password?",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xffF6F6FB),
                              decoration: TextDecoration.underline),
                        ),
                      )
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
  }

  PinTheme getPintheme() {
    return PinTheme(
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
    );
  }
}
