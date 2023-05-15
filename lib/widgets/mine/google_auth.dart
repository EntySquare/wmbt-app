import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmbt/common/style/common_style.dart';
// import 'package:wmbt/event/event_const.dart';
// import 'package:wmbt/event/notify_new_event.dart';
// import 'package:wmbt/http/http_provider.dart';
import 'package:wmbt/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../data/repositories/Theme_cubit.dart';

//import '../common/util/shadow_widget.dart';
//import '../http/http_interceptor.dart';

class GooleAuth extends StatefulWidget {
  String signData;
  String phone;
  GooleAuth({Key? key,required this.signData,required this.phone }) : super(key: key);
  @override
  State<GooleAuth> createState() => _GooleAuthState(signData);
}

class _GooleAuthState extends State<GooleAuth> {
  final formKey = GlobalKey<FormState>();

  String qr_code_str = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _GooleAuthState(code_str){
    //String phone = HttpInterceptor.box.read("phone");
    //qr_code_str = "otpauth://totp/"+"Bpool"+"?secret="+code_str+"&issuer=${phone}";
  }

  @override
  Widget build(BuildContext context) {

    bool isDark_on = context.read<ThemeCubit>().isDarkTheme();

    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: isDark_on
                ? const AssetImage("assets/images/bgc_dark.png")
                : const AssetImage("assets/images/bgc_lingh.png"),
            fit: BoxFit.cover,
          ),
          //圆角
            borderRadius: BorderRadius.all(Radius.circular(8)),
            // gradient: LinearGradient(
            //   colors: [
            //     Color(0xffF4E1D4).withOpacity(0.5),
            //     Colors.white
            //   ],
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            // )
        ),
        child:SafeArea(
          child:Column(
            children: [
              //返回按钮
              Row(
                children: [
                  //返回按钮
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 48,
                      height: 48,
                      child: Image.asset("assets/images/app_back_<-.png"),
                    ),
                  ),
                ],
              ),
              //显示二维码
              Expanded(child: Container(
                child:Column(
                  children: [
                    Container(
                      width: 280,
                      height: 280,
                      padding: EdgeInsets.all(24),
                      margin: EdgeInsets.only(top: 100),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white.withOpacity(0.15),
                      ),
                      child: QrImage(
                        data: "123123",
                        version: QrVersions.auto,
                        foregroundColor: Colors.white,
                        size: 214,
                      ),
                    ),
                    SizedBox(height: 33),
                    Text("Recommendation Code", style: CommonStyle.text_20_white_w700),
                    SizedBox(height: 12),
                    Container(
                      //color: Color(0xffD8DEE3),
                      width: 140,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Color(0xffD8DEE3).withOpacity(0.4),
                        //圆角
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: TextButton(onPressed: (){
                        Fluttertoast.showToast(msg: "复制成功", gravity: ToastGravity.CENTER);
                        Clipboard.setData(ClipboardData(text: widget.signData));
                      }, child: Text("复制密钥",style: TextStyle(color: Color(0xffA4AEB7), fontSize: 20, fontWeight: FontWeight.w700),)),
                    ),
                  ],
                ),

              ),flex:1,),

              //去认证
              Container(
                  height: 60,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Color(0xffe7f3f0),
                    //圆角
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    // 阴影
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 1.0,
                          spreadRadius: 1.0,
                          offset:Offset(-3, 0)
                      ),
                      BoxShadow(
                          color: Colors.white,
                          offset:Offset(-3, 0),
                          blurRadius:2.0
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Center(
                        child: TextButton(
                          onPressed: null,
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                //color: Colors.red,
                                width: 130,
                                child: TextButton(
                                    onPressed: () {
                                      _showDialog();
                                    },
                                    child: Text(
                                      "去认证",
                                      style: TextStyle(
                                          color: Color(0xffa6adb6),
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
             SizedBox(
               height: 50,
             )

            ],
          ),
        ),
      ),
    );
  }
  _showDialog(){
   var _pinEditingController = TextEditingController();
  var  _focusNode = FocusNode();
  var enterContent="";
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // 默认情况下有高度限制，设置为true，弹出窗口高度将交给子视图
      builder: (BuildContext context)  {
        return StatefulBuilder(builder: (BuildContext context, StateSetter setState){
          return Container(
            height: 500,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: GestureDetector(
                child: Container(
                  color: Color(0xffA4AEB7).withOpacity(0.15),
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(1),
                            Colors.white.withOpacity(0),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        //返回键
                        Container(
                          height: 70,
                          padding: EdgeInsets.only(top: 10),
                          //color: Colors.red,
                          child: Row(
                            children: [
                              //返回按钮
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  width: 48,
                                  height: 48,
                                  margin: EdgeInsets.only(left: 15, top: 8, bottom: 8),
                                  child: Icon(
                                    Icons.arrow_back_ios_sharp,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),

                              Container(
                                width: 55,
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 34,
                          //color: Colors.orange,
                          margin: EdgeInsets.only(bottom: 20),
                          alignment: Alignment.topCenter,
                          child: Center(
                            child: Text(
                              "请输入Google验证码",
                              style: TextStyle(
                                  color: Color(0xff008B70),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        // 密码输入框
                        Form(
                          key: formKey,
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 20),
                              child: PinCodeTextField(
                                appContext: context,
                                pastedTextStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                length: 6,
                                obscureText: true,
                                obscuringCharacter: '*',
                                autoFocus: true,// 自动弹出键盘

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
                                  fieldHeight: 60,
                                  fieldWidth: 50,
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
                                  FocusScope.of(context).requestFocus(_focusNode); // 密码输入完成后，请求焦点并弹起键盘
                                  _googleAuthByCode(enterContent,widget.phone);
                                },

                                onChanged: (value) {
                                  enterContent=value;

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
                          height: 45,
                          padding: EdgeInsets.only(left: 35, right: 35),
                          child: Text(
                            "google验证码是保障您资产安全的重要凭证，请妥善保管。",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xffA4AEB7),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
      },
    ).then((val) {


    });
  }
  
  _googleAuthByCode(String gooleCode,String phone)async{

  }
}
