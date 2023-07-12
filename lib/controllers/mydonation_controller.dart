import 'package:flutter_uas/models/myDonationModel.dart';
import 'package:flutter_uas/utils/api_endpoints.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyDonationController extends GetxController {
  final donationModel = Rxn<MyDonationModel>();
  final box = GetStorage();
  RxBool isLoading = false.obs;
  var tabIndex = 0;
  // late Map<String, dynamic> userData;
  refreshData() async {
    // Future.delayed(Duration(seconds: 1), () {
    //   FetchData();
    //   FetchCategory();
    //   FetchBanner();
    // });
    await FetchDonations();
    print('refreshed');
  }

  @override
  // void onInit() async {
  //   isLoading.value = true;
  //   await FetchDonations();
  //   // savedproductController.FetchDonationsSaved();

  //   super.onInit();
  // }

  FetchDonations() async {
    isLoading.value = true;
    var responses;
    http.Response response = await http.get(Uri.tryParse(
        ApiEndPoints.baseUrl + 'donations/' + box.read('id').toString())!);

    try {
      print(response.statusCode);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        donationModel.value = MyDonationModel.fromJson(result);
        isLoading.value = false;
        // userData = result['body'][0];
        // var data = result['body'][0];
        // print(userData['invoice_number']);
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

  void getDetail(String id) {
    Get.toNamed('/campaign/detail', arguments: id);
  }
}
