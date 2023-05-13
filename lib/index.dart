import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:wmbt/widgets/home/home.dart';
import 'package:wmbt/widgets/mine/mine.dart';

class Index extends StatefulWidget {
  Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  TabController? _tabController;
  final List<Widget> _pages = [
    Home(),
    Mine(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_currentIndex),
      bottomNavigationBar: ConvexAppBar(
            controller: _tabController,
            color: Colors.black38,
            style: TabStyle.react,
            items: [
              TabItem(
                icon: Image.asset(
                  'assets/images/inactive_bottom_icon1.png',
                ),
                activeIcon: Image.asset(
                  'assets/images/active_bottom_icon1.png',
                ),
              ),
              TabItem(
                icon: Image.asset(
                  'assets/images/inactive_bottom_icon2.png',
                ),
                activeIcon: Image.asset(
                  'assets/images/active_bottom_icon2.png',
                ),
              ),
            ],
            initialActiveIndex: 0,
            height: Get.height * .07,
            backgroundColor: Color(0xFF211d28),
            top: 0,
            elevation: 20,
            shadowColor: Color(0xFF8927a5),
            onTap: (int i) {
              setState(() {
                _currentIndex = i;
              });
            },
          ),

      // bottomNavigationBar: BottomNavigationBar(
      //     fixedColor: Colors.red,
      //     // 选中的颜色
      //     iconSize: 25,
      //     currentIndex: _currentIndex,
      //     type: BottomNavigationBarType.fixed,
      //     // 如果底部有4个或者以上时，需要设置
      //     onTap: (index) {
      //       setState(() {
      //         _currentIndex = index;
      //       });
      //     },
      //     items: const [
      //       BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
      //       BottomNavigationBarItem(
      //           icon: Icon(Icons.heart_broken), label: "市场"),
      //       BottomNavigationBarItem(icon: Icon(Icons.home), label: "收藏"),
      //       BottomNavigationBarItem(icon: Icon(Icons.settings), label: "我的"),
      //     ]),
    );
  }
}
