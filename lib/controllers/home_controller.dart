import 'package:flutter_uas/controllers/account_controller.dart';
import 'package:flutter_uas/models/campaignModel.dart';
import 'package:flutter_uas/utils/api_endpoints.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeController extends GetxController {
  final campaignModel = Rxn<CampaignModel>();
  RxBool isLoading = false.obs;
  final AccountController accountController = Get.put(AccountController());
   final box = GetStorage();
  var tabIndex = 0;
  refreshData() async {
    // Future.delayed(Duration(seconds: 1), () {
    //   FetchData();
    //   FetchCategory();
    //   FetchBanner();
    // });
    await FetchCampaign();
    print('refreshed');
  }

  @override
  void onInit() async {
    isLoading.value = true;
    await FetchCampaign();
    // savedproductController.FetchCampaignSaved();

    super.onInit();
  }

  FetchCampaign() async {
    isLoading.value = true;
    var responses;
    http.Response response =
        await http.get(Uri.tryParse(ApiEndPoints.baseUrl + 'campaign')!);

    try {
      print(response.statusCode);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        campaignModel.value = CampaignModel.fromJson(result);
        isLoading.value = false;
        print(jsonDecode(response.body));
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
