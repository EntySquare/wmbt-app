import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:wmbt/widgets/home/home.dart';
import 'package:wmbt/widgets/mine/mine.dart';

class Index2 extends StatefulWidget {
  const Index2({super.key});

  @override
  State<Index2> createState() => _Index2State();
}

class _Index2State extends State<Index2> {
  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  @override
  Widget build(final BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      navBarHeight: Get.height * 0.07,
      padding: NavBarPadding.only(top: 30),
      backgroundColor: Color(0xFF211d28),
      // bottomScreenMargin: 10,
      // Default is Colors.white.
      handleAndroidBackButtonPress: true,
      // Default is true.
      resizeToAvoidBottomInset: true,
      // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true,
      // Default is true.
      hideNavigationBarWhenKeyboardShows: true,

      // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(0.0),
        boxShadow: [
          BoxShadow(offset: Offset(0, 5), color: Color(0xFF5c3067), blurRadius: 40, spreadRadius: 10),
        ],
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      onItemSelected: (Index2) {
        setState(() {});
      },
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style12,
    );
  }

  List<Widget> _buildScreens() => [
        Home(),
        // Mine(),
        Mine(),
      ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
        PersistentBottomNavBarItem(
          // icon: _controller.Index2 == 0
          //     ? Image.asset("assets/images/active_bottom_icon1.png")
          //     : Image.asset("assets/images/inactive_bottom_icon1.png"),
          icon: Image.asset(
            "assets/images/active_bottom_icon1.png",
            width: 30,
            height: 30,
          ),
          inactiveIcon: Image.asset(
            "assets/images/inactive_bottom_icon1.png",
            width: 30,
            height: 30,
          ),
          iconSize: 30,
          // activeColorPrimary: CupertinoColors.activeBlue,
          // inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Image.asset(
            "assets/images/active_bottom_icon2.png",
            width: 30,
            height: 30,
          ),
          inactiveIcon: Image.asset(
            "assets/images/inactive_bottom_icon2.png",
            width: 30,
            height: 30,
          ),
        ),
      ];
}
