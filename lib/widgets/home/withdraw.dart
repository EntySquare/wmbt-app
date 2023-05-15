import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/style/common_style.dart';
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
    input_item.addAll([
      InputItem(
          id: 1,
          hint_text: S.of(context).mobile_number,
          title: "",
          controller: addressController,
          node: addressNode),
      InputItem(
          id: 2,
          hint_text: "amount",
          title: "",
          controller: amountController,
          node: amountNode),
      InputItem(
          id: 3,
          hint_text: "verification_code",
          title: "",
          controller: codeController,
          node: codeNode),

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

            // 地址 + 金额输入框
            Container(
              margin: EdgeInsets.only(top: 128),
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

                      // 下一步
                      GestureDetector(
                        onTap: (){
                          //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){

                          //}));
                        },
                        child: Container(
                          height: 49,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Color(0xff9A4DFF), Color(0xffF600DD)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.centerRight),
                              boxShadow: [
                                //BoxShadow(color: Colors.grey.shade300, blurRadius: 6.0, spreadRadius: 2.0)
                                BoxShadow(color: Colors.grey, blurRadius: 4, spreadRadius: 2),
                              ],
                              borderRadius: BorderRadius.all(Radius.circular(8))),
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
                      index == 2
                          ? Container(
                        width: 80,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xff9A4DFF), Color(0xffF600DD)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
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
}
