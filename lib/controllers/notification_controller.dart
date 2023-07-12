import 'package:flutter/material.dart';
import 'package:flutter_uas/models/myDonationModel.dart';
import 'package:flutter_uas/models/notificationModel.dart';
import 'package:flutter_uas/utils/api_endpoints.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationController extends GetxController {
  final notificationModel = Rxn<NotificationModel>();
  final box = GetStorage();
  RxBool isLoading = false.obs;
  var tabIndex = 0;
  BuildContext? context;

  refreshData() async {
    // Future.delayed(Duration(seconds: 1), () {
    //   FetchData();
    //   FetchCategory();
    //   FetchBanner();
    // });
    await FetchData();
    print('refreshed');
  }

  @override
  // void onInit() async {
  //   isLoading.value = true;
  //   await FetchDonations();
  //   // savedproductController.FetchDonationsSaved();

  //   super.onInit();
  // }

  FetchData() async {
    isLoading.value = true;
    var responses;
    http.Response response = await http.get(Uri.tryParse(
        ApiEndPoints.baseUrl + 'notifications/' + box.read('id').toString())!);

    try {
      print(response.statusCode);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        notificationModel.value = NotificationModel.fromJson(result);
        isLoading.value = false;
        print(result);
      } else {
        print('Error fetching data');
      }
    } catch (e) {
      print('error while getting data is $e');
    }
    // finally {
    //   isLoadingProduct = false;
    // }
  }

  // void getDetail(String id) {
  //   Get.toNamed('/campaign/detail', arguments: id);
  // }
  onDismissed(String id) async {
    isLoading.value = true;
    var responses;
    http.Response response = await http.get(
        Uri.tryParse(ApiEndPoints.baseUrl + 'notifications/delete/' + id)!);

    try {
      print(response.statusCode);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print(result);

        FetchData();
      } else {
        print('Error fetching data');
      }
    } catch (e) {
      print('error while getting data is $e');
    }
    // finally {
    //   isLoadingProduct = false;
    // }
  }
}
