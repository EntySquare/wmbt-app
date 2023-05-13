import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/style/common_style.dart';
import '../../common/style/dotted_line.dart';
import '../../common/style/language_dialog.dart';
import '../../data/repositories/Theme_cubit.dart';
import '../../generated/l10n.dart';
import 'dart:ui';

import '../../utils/gradient_text.dart';
import 'kyc_step_three.dart';

class kycStepTwoPage extends StatefulWidget {
  const kycStepTwoPage({Key? key}) : super(key: key);

  @override
  State<kycStepTwoPage> createState() => _kycStepTwoPageState();
}

class _kycStepTwoPageState extends State<kycStepTwoPage> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double safe_bottom = MediaQuery.of(context).padding.bottom;
    final double safe_top = MediaQuery.of(context).padding.top;
    bool isDark_on = context.read<ThemeCubit>().isDarkTheme();

    return Container(
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
                LanguageSelector(
                  languages: [
                    Language(
                        name: '简体中文', flag: 'assets/images/login_america.png'),
                    Language(
                        name: 'English',
                        flag: 'assets/images/login_america.png'),
                  ],
                  onLanguageChanged: (Language) {},
                ),
              ],
            ),
          ),

          // 身份证明
          Container(
            margin: EdgeInsets.only(top: safe_top, left: 22, right: 22),
            height: 450,
            //color: Colors.red,
            child: Column(
              children: [
                Container(
                  height: 65,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GradientText(
                        text: "Proof of Identity",
                        gradient: LinearGradient(
                            colors: [Color(0xff9A4DFF), Color(0xffF600DD)]),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.none),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Choose your identity type",
                        style: CommonStyle.text_14_white,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(
                              width: 11,
                              height: 11,
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
                            Text(
                              "ID Card",
                              style: CommonStyle.text_12_white,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 0),
                        child: Row(
                          children: [
                            Container(
                              width: 11,
                              height: 11,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 1,
                                    color: Color(0xff9A4DFF),
                                    style: BorderStyle.solid),
                              ),
                              margin: EdgeInsets.all(5),
                            ),
                            Text(
                              "ID Card",
                              style: CommonStyle.text_12_white,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 0),
                        child: Row(
                          children: [
                            Container(
                              width: 11,
                              height: 11,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 1,
                                    color: Color(0xff9A4DFF),
                                    style: BorderStyle.solid),
                              ),
                              margin: EdgeInsets.all(5),
                            ),
                            Text(
                              "ID Card",
                              style: CommonStyle.text_12_white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 0, right: 10),
                  child: Text(
                    "Please upload a copy of your identity with a clear selfie photo to proof in the document holder",
                    style: CommonStyle.text_12_white,
                  ),
                ),
                const SizedBox(
                  height: 36,
                ),

                // 身份证正面
                Container(
                  height: 120,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/step_idnum_bgicon.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 20, right: 10),
                            margin: EdgeInsets.symmetric(vertical: 32),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "Upload Proof of Identity",
                                  style: CommonStyle.text_14_colorF6F6FB_w600,
                                ),
                                Text(
                                  "We accept only\nID card, Passport, Driving license",
                                  style: CommonStyle.text_12_colorD9D9D9_w400,
                                )
                              ],
                            ),
                          )),
                      Container(
                        width: 110,
                        margin: EdgeInsets.only(right: 18),
                        child: Image.asset('assets/images/step_idcard_02.png', fit: BoxFit.cover,),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 36,
                ),
                // 身份证反面
                Container(
                  height: 120,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/step_idnum_bgicon.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 20,right: 10),
                            margin: EdgeInsets.symmetric(vertical: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "Take selfie with identity",
                                  style: CommonStyle.text_14_colorF6F6FB_w600,
                                ),
                                Text(
                                  "Please note Screenshots, mobile phone bills, and insurance are NOT accepted for verification",
                                  style: CommonStyle.text_12_colorD9D9D9_w400,
                                )
                              ],
                            ),
                          )),
                      Container(
                        width: 110,
                        margin: EdgeInsets.only(right: 18),
                        child: Image.asset('assets/images/step_idcard_01.png', fit: BoxFit.cover,),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 下一步 + 指示器
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
                                        "assets/images/step_safe_icon.png"),
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
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),

                    // 下一步
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                          return KycStepThreePage();
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
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        alignment: Alignment.bottomCenter,
                        child: TextButton(
                          onPressed: null,
                          child: Text(
                            S.of(context).next,
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
}
