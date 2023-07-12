import 'package:flutter/material.dart';
import 'package:flutter_uas/views/LayoutHomeView.dart';
import 'package:flutter_uas/views/MyDonationView.dart';
import 'package:flutter_uas/views/NotificationView.dart';
import 'package:flutter_uas/views/accountView.dart';
import 'package:flutter_uas/views/DetailCampaignView.dart';
import 'package:flutter_uas/views/account_editView.dart';
import 'package:flutter_uas/views/auth/RegisterView.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'views/SplashScreenView.dart';
import 'views/auth/LoginView.dart';

main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    if (box.read('token') != null) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        // home: Scaffold(
        //   // body: screens[index],
        //   // body: screens[index],
        // ),
        initialRoute: AppLinks.homePage,
        getPages: AppRoutes.pages,
      );
    } else {
      return FutureBuilder(
          future: Future.delayed(Duration(seconds: 3)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                // home: Scaffold(
                //   // body: screens[index],
                //   // body: screens[index],
                // ),
                initialRoute: AppLinks.loginPage,
                getPages: AppRoutes.pages,
              );
            }

            return SplashScreen();
          });
    }
  }
}

class AppRoutes {
  static final pages = [
    GetPage(name: AppLinks.splashPage, page: () => SplashScreen()),
    GetPage(name: AppLinks.loginPage, page: () => Login()),
    GetPage(name: AppLinks.registerPage, page: () => Register()),
    GetPage(name: AppLinks.homePage, page: () => LayoutHome()),
    GetPage(name: AppLinks.accountPage, page: () => Account()),
    GetPage(name: AppLinks.accountEditPage, page: () => AccountEditView()),
    GetPage(name: AppLinks.detailCampaignPage, page: () => DetailCampaign()),
    GetPage(name: AppLinks.myDonationPage, page: () => MyDonation()),
    GetPage(name: AppLinks.myDonationPage, page: () => NotificationView()),
  ];
}

class AppLinks {
  static const String splashPage = "/";
  static const String loginPage = "/login";
  static const String registerPage = "/register";
  static const String homePage = "/home";
  static const String accountPage = "/account";
  static const String accountEditPage = "/account/edit";
  static const String detailCampaignPage = "/campaign/detail";
  static const String myDonationPage = "/my-donation";
  static const String notificationPage = "/my-notification";
}
