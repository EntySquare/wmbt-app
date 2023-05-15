import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/style/common_style.dart';
import '../../data/repositories/Theme_cubit.dart';
import '../../generated/l10n.dart';
import '../setI10n/WmbtDropdownButton.dart';

class Activities extends StatefulWidget {
  const Activities({super.key});

  @override
  State<Activities> createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
  @override
  Widget build(BuildContext context) {
    bool isDark_on = context.read<ThemeCubit>().isDarkTheme();
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bgc_dark.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: DefaultTabController(
            length: 4, // Tab 的数量
            child: Column(
              children: [
                Container(
                  height: 50,
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(top: 10),
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
                TabBar(
                  indicatorWeight: 3,
                  indicatorColor: Color(0xFFF600DD),
                  indicatorSize: TabBarIndicatorSize.label,
                  labelColor: Color(0xFFF600DD),
                  unselectedLabelColor: Colors.white,
                  indicatorPadding: EdgeInsets.only(bottom: 10.0),
                  labelPadding: EdgeInsets.zero,

                  tabs: [
                    Tab(text: S.of(context).all),
                    Tab(text: S.of(context).withdraw),
                    Tab(text: S.of(context).unlock),
                    Tab(text: S.of(context).time_range),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Container(
                        //padding: EdgeInsets.only(top: 8),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: 10,
                          itemBuilder: (BuildContext context, int index) {
                            return getRow(index, isDark_on);
                          },
                        ),
                      ),
                      Center(
                          child: Text(
                        'No activities at the moment',
                        style: CommonStyle.text_16_grey_underline,
                      )),
                      Center(
                          child: Text(
                        'No activities at the moment',
                        style: CommonStyle.text_16_grey_underline,
                      )),
                      Center(
                          child: Text(
                        'No activities at the moment',
                        style: CommonStyle.text_16_grey_underline,
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
              //color: Colors.orange,

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
