import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wmbt/common/style/common_style.dart';

import '../../generated/l10n.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;
  List<String> menuItems = ['24h', '7d', '30d'];
  late String tapText;

  // DateFormat formatType = DateFormat.Md();
  final CustomPopupMenuController _controller = CustomPopupMenuController();

  @override
  void initState() {
    data = [
      _ChartData('CHN', 12),
      _ChartData('GER', 15),
      _ChartData('RUS', 30),
      _ChartData('BRZ', 6.4),
      _ChartData('IND', 14)
    ];
    tapText = menuItems[0];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF211d28),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bgc_dark.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.12),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.symmetric(horizontal: 19, vertical: 31),
              height: Get.height * 0.35,
              width: Get.width,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _balanceDetail(S.of(context).total_balance, "4313WMBT"),
                      _balanceDetail(S.of(context).locked, "4313WMBT"),
                      _balanceDetail(S.of(context).unlocked, "4313WMBT"),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).activities,
                        style: CommonStyle.text_16_white_underline,
                      ),
                      InkWell(
                        child: Container(
                          width: 100,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: LinearGradient(
                              colors: [Color(0xffCC9DFF), Color(0xff563C72)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Text(
                            S.of(context).withdraw,
                            style: CommonStyle.text_14_white_w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 38),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            colors: <Color>[Color(0xFF9A4DFF), Color(0xFFF600DD)],
                          ).createShader(Offset.zero & bounds.size);
                        },
                        blendMode: BlendMode.srcATop,
                        child: Center(
                          child: Text(
                            S.of(context).balance,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(width: 30),
                      Text(
                        "WMBT",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFF6F6FB).withOpacity(0.5)),
                      ),
                    ],
                  ),
                  _timeMenu(),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: Get.height * 0.22,
              child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(
                    isVisible: false,
                    // axisBorderType: AxisBorderType.withoutTopAndBottom,
                    axisLine: AxisLine(width: 0),
                    majorTickLines: MajorTickLines(width: 0),
                    majorGridLines: MajorGridLines(width: 0),
                    labelPlacement: LabelPlacement.onTicks,
                  ),
                  primaryYAxis: NumericAxis(
                    labelPosition: ChartDataLabelPosition.inside,
                    labelStyle: TextStyle(color: Colors.grey),
                    isVisible: true,
                    minimum: 0,
                    // maximum: 5,
                    interval: 10,
                    axisLine: AxisLine(width: 0),
                    majorTickLines: MajorTickLines(width: 0),
                    // 刻度线
                    majorGridLines: MajorGridLines(width: 1),
                  ),
                  plotAreaBorderWidth: 0,
                  //跟踪球
                  trackballBehavior: TrackballBehavior(
                    lineType: TrackballLineType.vertical,
                    lineColor: Colors.transparent,
                    //纵向选择指示器
                    activationMode: ActivationMode.singleTap,
                    enable: true,
                    //工具提示位置(顶部)
                    tooltipAlignment: ChartAlignment.far,
                    shouldAlwaysShow: false,
                    //跟踪球始终显示
                    tooltipDisplayMode: TrackballDisplayMode.nearestPoint,
                    tooltipSettings: InteractiveTooltip(
                      enable: true,
                      color: Colors.transparent,
                      borderColor: Colors.white,
                      borderWidth: 0,
                      textStyle: CommonStyle.text_12_white,
                      format: 'point.yWMBT',
                      arrowLength: 0,
                      arrowWidth: 0,
                      canShowMarker: false,
                    ),
                    markerSettings: TrackballMarkerSettings(
                      markerVisibility: TrackballVisibilityMode.visible,
                      color: Colors.white,
                      height: 10,
                      width: 10,
                    ),
                    lineDashArray: [2, 2],
                  ),
                  series: <ChartSeries<_ChartData, String>>[
                    SplineAreaSeries(
                      dataSource: data,
                      xValueMapper: (_ChartData data, _) => data.x,
                      yValueMapper: (_ChartData data, _) => data.y,
                      // dataLabelMapper: (_ChartData data, _) => '${data.y.toString()}WMBT',
                      // dataLabelSettings: DataLabelSettings(
                      //   isVisible: false,
                      //   labelAlignment: ChartDataLabelAlignment.outer,
                      //   labelPosition: ChartDataLabelPosition.outside,
                      //   textStyle: CommonStyle.text_12_white,
                      // ),
                      enableTooltip: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          Color(0xFF9A4DFF),
                          Color(0xFFF600DD).withOpacity(0.1),
                        ],
                      ),
                      splineType: SplineType.natural,
                      borderWidth: 4,
                      borderGradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: <Color>[
                          Color(0xFFFEB7FF),
                          Color(0xFFD274FF),
                          Color(0xFF778DFF),
                          Color(0xFF86FFE2),
                        ],
                      ),
                    ),
                  ]),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ClipOval(
                    child: Container(
                      width: Get.height * .08,
                      height: Get.height * .08,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF9A4DFF).withOpacity(0.3), Color(0xFFF600DD)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        // border: Border.all(color: Color(0xFFab3bb0),width: 1)
                      ),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Image.asset("assets/images/qrcode.png"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: ClipOval(
      //   child: Container(
      //     width: 77,
      //     height: 77,
      //     decoration: BoxDecoration(
      //       gradient: LinearGradient(
      //         colors: [Color(0xFF9A4DFF).withOpacity(1), Color(0xFFF600DD)],
      //         begin: Alignment.topCenter,
      //         end: Alignment.bottomCenter,
      //       ),
      //       // border: Border.all(color: Color(0xFFab3bb0),width: 1)
      //     ),
      //     child: FloatingActionButton(
      //         onPressed: () {},
      //         child: Container(
      //           child: Image.asset("assets/images/qrcode_icon.png"),
      //         )),
      //   ),
      // ),
    );
  }

  // 下拉菜单
  Widget _timeMenu() {
    return Container(
      child: CustomPopupMenu(
        child: Container(
          height: 40,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: IntrinsicWidth(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  tapText,
                  style: CommonStyle.text_12_white,
                ),
                Icon(Icons.arrow_drop_down, color: Colors.white, size: 16),
              ],
            ),
          ),
        ),
        menuBuilder: () => ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            // color: Color(0xFF9A4DFF).withOpacity(0.8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xffCC9DFF), Color(0xff563C72)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            width: 60,
            child: IntrinsicWidth(
              child: Column(
                children: menuItems
                    .map(
                      (item) => GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            tapText = item.toString();
                            if (item.toString() == '24h内') {
                              // formatType = DateFormat.Hm();
                            } else if (item.toString() == '7d') {
                              // formatType = DateFormat.Md();
                            } else if (item.toString() == '30d') {
                              // formatType = DateFormat.Md();
                            }
                          });
                          _controller.hideMenu();
                        },
                        child: Container(
                          height: 36,
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(item, style: CommonStyle.text_10_white),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
        pressType: PressType.singleClick,
        // 弹窗偏移量
        verticalMargin: 0,
        controller: _controller,
        showArrow: false,
        position: PreferredPosition.bottom,
      ),
    );
  }

  Widget _balanceDetail(String name, String num) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              name + ":",
              style: CommonStyle.text_16_white,
            ),
          ],
        ),
        Row(
          children: [
            Text(
              num,
              style: CommonStyle.text_20_white_w700,
            ),
          ],
        ),
      ],
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
