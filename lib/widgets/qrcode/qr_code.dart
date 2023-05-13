import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:wmbt/common/style/common_style.dart';

import '../setI10n/WmbtDropdownButton.dart';

class QrCode extends StatefulWidget {
  const QrCode({super.key});

  @override
  State<QrCode> createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  @override
  Widget build(BuildContext context) {
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 280,
                        height: 280,
                        padding: EdgeInsets.all(24),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("123123", style: CommonStyle.text_16_white),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.copy, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Image(
                    image: AssetImage("assets/images/download_arrow.png"),
                    width: 24,
                    height: 24,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "download the QR code",
                    style: CommonStyle.text_16_grey,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
