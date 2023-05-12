import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/style/common_style.dart';
import '../../common/style/language_dialog.dart';
import '../../data/repositories/Theme_cubit.dart';
import '../../generated/l10n.dart';
import '../../utils/gradient_text.dart';
import 'kyc_step_four.dart';

class KycStepThreePage extends StatefulWidget {
  const KycStepThreePage({Key? key}) : super(key: key);

  @override
  State<KycStepThreePage> createState() => _KycStepThreePageState();
}

class _KycStepThreePageState extends State<KycStepThreePage> {
  final PageController _pageController = PageController(initialPage: 1);
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
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

          //图片
          Container(
            margin: EdgeInsets.only(top: safe_top + 55,),
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: Center(
              child: Stack(
                children: [
                  Center(
                    child: Image.asset(
                      "assets/images/kyc_step0302.png",
                      height: 395,
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      "assets/images/kyc_step0301.png",
                      width: 127,
                      height: 395,
                      fit: BoxFit.fitWidth
                    ),
                  )

                ],
              )
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
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),

                    // 下一步
                    Container(
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
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                            return KycStepFourPage();
                          }));
                        },
                        child: Text(
                          "Document  uploading . . .",
                          style: CommonStyle.text_14_white,
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
