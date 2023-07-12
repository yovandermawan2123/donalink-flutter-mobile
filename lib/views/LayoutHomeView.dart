import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uas/controllers/navbar_controller.dart';
import 'package:flutter_uas/views/HomeView.dart';
import 'package:flutter_uas/views/MyDonationView.dart';
import 'package:flutter_uas/views/NotificationView.dart';
import 'package:flutter_uas/views/SplashScreenView.dart';
import 'package:flutter_uas/views/accountView.dart';
import 'package:get/get.dart';
import 'package:animations/animations.dart';

// import 'inputWrapper.dart';

class LayoutHome extends StatefulWidget {
  @override
  State<LayoutHome> createState() => _LayoutHomeState();
}

class _LayoutHomeState extends State<LayoutHome> {
  final NavbarController navbarController = Get.put(NavbarController());
  static List<Widget> _widgetOptions = <Widget>[
    Home(),
    MyDonation(),
    NotificationView(),
    Account(),
    // SplashScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavbarController>(
      builder: (context) {
        return Scaffold(
          body: Container(
            child: PageTransitionSwitcher(
              duration: Duration(milliseconds: 700),
              transitionBuilder: (child, animation, secondaryAnimation) =>
                  FadeThroughTransition(
                      animation: animation,
                      secondaryAnimation: secondaryAnimation,
                      child: child),
              child: _widgetOptions.elementAt(navbarController.tabIndex),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.article),
                label: 'My Donation',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.email),
                label: 'Inbox',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Account',
              ),
            ],
            currentIndex: navbarController.tabIndex,
            selectedItemColor: Colors.green,
            onTap: navbarController.changeTabIndex,
          ),
        );
      },
    );
  }
}
