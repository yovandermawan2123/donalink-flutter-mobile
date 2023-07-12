import 'package:flutter_uas/controllers/account_controller.dart';
import 'package:flutter_uas/controllers/mydonation_controller.dart';
import 'package:flutter_uas/controllers/notification_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class NavbarController extends GetxController {
  var tabIndex = 0;
  final box = GetStorage();
  final AccountController accountController = Get.put(AccountController());
  final MyDonationController myDonationController =
      Get.put(MyDonationController());
  final NotificationController notificationController =
      Get.put(NotificationController());
  void changeTabIndex(int index) {
    tabIndex = index;
    update();
    // print(tabIndex);
    if (tabIndex == 3) {
      accountController.FetchDataMember(box.read('id').toString());
    } else if (tabIndex == 1) {
      myDonationController.FetchDonations();
    } else if (tabIndex == 2) {
      notificationController.FetchData();
    }
  }
}
