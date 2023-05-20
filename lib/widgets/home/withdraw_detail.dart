import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/style/common_style.dart';
import '../../data/repositories/Theme_cubit.dart';
import '../../index.dart';
import '../../utils/gradient_text.dart';
import '../setI10n/WmbtDropdownButton.dart';

class ListItem {
  final String detail;
  final String title;

  ListItem({
    required this.title,
    required this.detail,
  });
}

class WithdrawDetailPage extends StatefulWidget {
  const WithdrawDetailPage({Key? key}) : super(key: key);

  @override
  State<WithdrawDetailPage> createState() => _WithdrawDetailPageState();
}

class _WithdrawDetailPageState extends State<WithdrawDetailPage> {
  List<ListItem> list_item = <ListItem>[];

  @override
  void initState() {
    super.initState();
    list_item.addAll([
      ListItem(title: "Address", detail: 'adweq****1314dsfa'),
      ListItem(title: 'Amount', detail: '12321 WMBT'),
      ListItem(title: "Commission fee", detail: '0.213 WMBT'),
      ListItem(title: 'Withdraw time', detail: '11:30:00  05/07/2022'),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final double safe_bottom = MediaQuery.of(context).padding.bottom;
    final double safe_top = MediaQuery.of(context).padding.top;
    bool isDark_on = context.read<ThemeCubit>().isDarkTheme();

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

            Container(
              height: 30,
              margin: EdgeInsets.only(top: 110),
              padding: EdgeInsets.symmetric(horizontal: 38),
              alignment: Alignment.center,
              child: GradientText(
                text: "Detail",
                gradient: LinearGradient(colors: [Color(0xff9A4DFF), Color(0xffF600DD)]),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, decoration: TextDecoration.none),
              ),
            ),

            // 提现详情
            Container(
              //color: Colors.red,
              margin: EdgeInsets.only(top: 36),
              height: 47.0 * list_item.length,
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: list_item.length,
                itemBuilder: (BuildContext context, int index) {
                  return getInputListRow(index);
                },
              ),
            ),



            // 完成 + 指示器
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

                      // 完成
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                          //Navigator.of(context).popUntil((route) => route.isFirst); // 返回根路由
                          //Navigator.of(context).pushReplacement(MaterialPageRoute(
                          // builder: (context) => Index(),
                          //)); // 返回根路由
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
                              "Complete",
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
    ListItem item = list_item[index];
    return Container(
      height: 47,
      padding: EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
            child: Text(item.title, style: CommonStyle.text_14_colorF6F6FB_w400,),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
            child: Text(item.detail, style: CommonStyle.text_12_colorD9D9D9_w400,),
          ),
          Divider(
            height: 0.5,
            color: Color(0xff9A4DFF),
          )
        ],
      ),
    );
  }
}
