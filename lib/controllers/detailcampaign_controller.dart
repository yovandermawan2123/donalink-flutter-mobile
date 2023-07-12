import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_uas/controllers/home_controller.dart';
import 'package:flutter_uas/models/campaignModel.dart';
import 'package:flutter_uas/utils/api_endpoints.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:http/http.dart' as http;

class DetailCampaignController extends GetxController {
  final isLoading = true.obs;
  // final selectedDropdown = "".obs;
  final box = GetStorage();
  TextEditingController amountController = TextEditingController();
  final HomeController homeController = Get.put(HomeController());

  // List mitra_list = [];

  // ProductModel? campaignModel;
  final campaignModel = Rxn<CampaignModel>();

  late final String slug;
  DetailCampaignController(this.slug);

  @override
  void onInit() {
    FetchSingleData(slug);
    // FetchBranch(id);
    super.onInit();
  }

  FetchSingleData(String slug) async {
    isLoading(true);
    var responses;
    http.Response response = await http
        .get(Uri.tryParse(ApiEndPoints.baseUrl + 'campaign/' + slug)!);

    // print('mantul');
    // print(response.statusCode);
    try {
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        campaignModel.value = CampaignModel.fromJson(result);

        print(result);
        // print(campaignModel.value?.body[0].pointExchange);
        // if (result != null) {
        //   Get.toNamed('/reward/detail', arguments: 'Get is the best');
        // }

        // print();
        isLoading(false);
      } else {
        print('Error fetching data');
      }
    } catch (e) {
      print('error while getting data is $e');
    } finally {
      isLoading(false);
    }
  }

  // storeDonation() async {
  //   // print(slug);
  //   var responses;
  //   http.Response response = await http
  //       .get(Uri.tryParse(ApiEndPoints.baseUrl + 'campaign/' + slug)!);

  //   // print('mantul');
  //   // print(response.statusCode);
  //   try {
  //     if (response.statusCode == 200) {
  //       var result = jsonDecode(response.body);

  //       campaignModel.value = CampaignModel.fromJson(result);
  //       // print(campaignModel.value?.body[0].pointExchange);
  //       // if (result != null) {
  //       //   Get.toNamed('/reward/detail', arguments: 'Get is the best');
  //       // }

  //       // print();
  //       isLoading(false);
  //     } else {
  //       print('Error fetching data');
  //     }
  //   } catch (e) {
  //     print('error while getting data is $e');
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  // Future<void> storeDonation(id) async {
  //   print(amountController.text);
  //   var headers = {
  //     'Content-Type': 'application/json',
  //     'Access-Control-Allow-Origin': '*'
  //   };
  //   try {
  //     var url = Uri.parse(ApiEndPoints.baseUrl + 'donation');
  //     Map body = {
  //       'amount': amountController.text,
  //       'user_id': box.read('id'),
  //       'campaign_id': id
  //     };
  //     http.Response response =
  //         await http.post(url, body: jsonEncode(body), headers: headers);

  //     print(response.statusCode);
  //     if (response.statusCode == 200) {
  //       final json = jsonDecode(response.body);

  //       var token = json['body']['access_token'];
  //       var data = json['body']['data'];

  //       amountController.clear();

  //       // Get.offAll(homeView());

  //       // Get.toNamed("/home");
  //       return json['body']['snap_token'];
  //     } else if (response.statusCode == 400) {
  //       throw jsonDecode(response.body)["message"] ??
  //           "Username / Password salah!";
  //     } else {
  //       throw jsonDecode(response.body)["message"] ?? "Unknown Error Occured";
  //     }
  //   } catch (error) {
  //     print(error.toString());
  //     Get.back();
  //     showDialog(
  //         context: Get.context!,
  //         builder: (context) {
  //           return SimpleDialog(
  //             title: Text('Error'),
  //             contentPadding: EdgeInsets.all(20),
  //             children: [Text(error.toString())],
  //           );
  //         });
  //   }
  // }

  Future<String> storeDonation(id) async {
    var headers = {
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*'
    };
    try {
      // Lakukan logika penyimpanan data donasi di sini

      // Contoh: Mengirimkan data donasi ke API
      var url = Uri.parse(ApiEndPoints.baseUrl + 'donation');
      Map body = {
        'amount': amountController.text,
        'user_id': box.read('id'),
        'campaign_id': id
      };
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        var token = json['body']['access_token'];
        var data = json['body']['data'];

        amountController.clear();
        FetchSingleData(slug);
        homeController.FetchCampaign();

        // Get.offAll(homeView());

        // Get.toNamed("/home");
        return json['body']['snap_token'];
      } else {
        throw Exception('Failed to store donation');
      }
    } catch (error) {
      print('Error storing donation: $error');
      throw Exception('Error storing donation: $error');
    }
  }

  void addAmount(String amount) {
    amountController.text = amount;
  }
}
