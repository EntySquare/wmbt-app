
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';

// 如果设备是iPhoneX及更新设备，返回ture
bool isIPhoneXOrAbove(BuildContext context) {
  final mediaQueryData = MediaQuery.of(context);
  final size = mediaQueryData.size;
  final screenHeight = size.height;
  final screenWidth = size.width;

  return mediaQueryData.platformBrightness == Brightness.light &&
      (screenHeight / screenWidth >= 2.16) &&
      (screenHeight / screenWidth < 2.19);
}


Future<String> getDeviceUDID() async {
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  String udid = "";

  if (Platform.isAndroid) {
    final AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
    udid = androidInfo.androidId; // 获取Android设备的UDID
  } else if (Platform.isIOS) {
    final IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
    udid = iosInfo.identifierForVendor; // 获取iOS设备的UDID
  }

  return udid;
}

// 根据不同的值，返回不同的颜色
Color getMarketColor(double value) {
  return value > 0
      ? Color(0xff008B70)
      : value < 0
      ? Colors.red
      : Color(0xffA4AEB7);
}


// 传入11位手机号， 前四位和后三位正常显示，其余用*代替
String maskPhoneNumber(String phoneNumber) {
  if (phoneNumber == null || phoneNumber.isEmpty) {
    return '';
  }

  String maskedNumber = phoneNumber.replaceRange(4, phoneNumber.length - 3, '**');

  return maskedNumber;
}

int getTimestamp(String time) {
  DateTime dt = DateTime.parse(time);
  int timestamp = dt.millisecondsSinceEpoch;
  int timestamp_10 = (timestamp / 1000).toInt();
  return timestamp_10;
}

// 传入10位时间戳，返回一个格式为yyyy-MM-dd的时期字符串
String formatTimestampToDate(int timestamp) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  return "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
}

// 传入10位时间戳，返回一个格式为yyyy-MM-dd的时期字符串
String formatTimestampToYearMonthDay(int timestamp) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  return "${date.year.toString().padLeft(4, '0')}年${date.month.toString().padLeft(2, '0')}月${date.day.toString().padLeft(2, '0')}日";
}


// 传入一个数，将这个数除以10的18次方，然后将结果返回
double divideBy10To18(int number) {
  final BigInt divisor = BigInt.from(10).pow(18);
  return number.toDouble() / divisor.toDouble();
}

// 传入分钟，返回X天X小时
String formatMinutes(int minutes) {
  int hours = minutes ~/ 60;
  int days = hours ~/ 24;
  hours -= days * 24;
  return '$days 天 $hours 小时';
}

// 传入分钟，返回X天
String formatMinutesReturnDay(int minutes) {
  int hours = minutes ~/ 60;
  int days = hours ~/ 24;
  return '$days';
}

// 传入秒，返回多少天
int secondsToDays(int seconds) {
  const int msPerDay = 86400; // 24 * 60 * 60
  return (seconds / msPerDay).floor();
}

 // 传入一个double类型数据，精度保留 fractionDigits 位， 返回一个 double
 double getNumByValueDouble(double value, int fractionDigits){
   double num = value;
   String result = num.toStringAsFixed(fractionDigits).replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "");
   //print(result);
   return double.parse(result);
}


