import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmbt/common/style/common_style.dart';

import '../../data/repositories/Theme_cubit.dart';
import '../../utils/gradient_text.dart';
import '../setI10n/WmbtDropdownButton.dart';

class MyRelationshipPage extends StatefulWidget {
  const MyRelationshipPage({Key? key}) : super(key: key);

  @override
  State<MyRelationshipPage> createState() => _MyRelationshipPageState();
}

class _MyRelationshipPageState extends State<MyRelationshipPage> {
  @override
  Widget build(BuildContext context) {
    final double safe_bottom = MediaQuery.of(context).padding.bottom;
    final double safe_tope = MediaQuery.of(context).padding.top;
    bool isDark_on = context.read<ThemeCubit>().isDarkTheme();

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
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GradientText(
                    text: "First layer",
                    gradient: LinearGradient(colors: [Color(0xff9A4DFF), Color(0xffF600DD)]),
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, decoration: TextDecoration.underline),
                  ),
                  Text(
                    "Second layer",
                    style: CommonStyle.text_14_colorF6F6FB_w400_opacity50,
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 1,
                child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return getRow(index, isDark_on);
              },
            )),
          ],
        ),
      ),
    );
  }

  Widget getRow(index, isDark_on) {
    return Container(
      height: 68,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: isDark_on
              ? const AssetImage("assets/images/mine_tuijian_cell_dark.png")
              : const AssetImage("assets/images/mine_tuijian_cell_light.png"),
          fit: BoxFit.cover,
        ),
      ),
      padding: EdgeInsets.only(left: 30),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/mine_user_head.png",
                      width: 33,
                      height: 33,
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.only(left: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Andrew",
                              style: CommonStyle.text_14_colorF6F6FB_w400,
                            ),
                            Text(
                              "01/02/2023",
                              style: CommonStyle.text_14_colorF6F6FB_w400_opacity50,
                            )
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
          Container(
            height: 40,
            padding: EdgeInsets.only(right: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Total Amount Unlocked",
                  style: CommonStyle.text_12_colorF6F6FB_w400_opacity50,
                ),
                Text(
                  "4542WMBT",
                  style: CommonStyle.text_16_white_w400,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
