import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:wmbt/widgets/home/home.dart';
import 'package:wmbt/widgets/mine/mine.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  @override
  Widget build(final BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      // padding: NavBarPadding.only(bottom: 20),
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
        colorBehindNavBar: Colors.white,
        boxShadow: [
          BoxShadow(offset: Offset(0, 5), color: Color(0xFF5c3067), blurRadius: 40, spreadRadius: 20),
        ],
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      onItemSelected: (index) {
        setState(() {
          print(index);
        });
      },
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style15,
    );
  }

  List<Widget> _buildScreens() => [
        Home(),
        Mine(),
        Mine(),
      ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
        PersistentBottomNavBarItem(
          // icon: _controller.index == 0
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
            icon: ClipOval(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF9A4DFF).withOpacity(1), Color(0xFFF600DD)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  // border: Border.all(color: Color(0xFFab3bb0),width: 1)
                ),
                child: Image.asset("assets/images/qrcode.png"),
              ),
            ),
            activeColorPrimary: Colors.transparent),
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
