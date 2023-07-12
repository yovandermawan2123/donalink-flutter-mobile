import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_uas/models/memberModel.dart';
import 'package:flutter_uas/views/auth/LoginView.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:surya_remmitance/controllers/product_controller.dart';
// import 'package:surya_remmitance/views/loginView.dart';
import 'dart:convert';
// import 'package:surya_remmitance/models/transactionModel.dart';

// import 'package:surya_remmitance/views/homeView.dart';
import 'package:flutter_uas/utils/api_endpoints.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AccountController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  // ImagePicker imagePicker = ImagePicker();
  final memberModel = Rxn<MemberModel>();
  ImagePicker imagePicker = ImagePicker();
  File? image;
  final isLoading = true.obs;
  final box = GetStorage();

  void logout() {
    box.remove('token');
    box.remove('id');
    box.remove('name');
    Get.offAll(Login());
  }

  Future getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? imagePicked =
        await _picker.pickImage(source: ImageSource.gallery);

    // :Image.file(File(imagePicked!.path));

    image = File(imagePicked!.path);
    // print(image);
    if (image != null) {
      print("coba update");
      update();
    }
  }

  void getDetail(String id) {
    Get.toNamed('/reward/detail', arguments: id);
  }

  FetchDataMember(String id) async {
    isLoading.value = true;
    var responses;
    http.Response response =
        await http.get(Uri.tryParse(ApiEndPoints.baseUrl + 'member/' + id)!);

    try {
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        memberModel.value = MemberModel.fromJson(result);
        print(result);
        isLoading.value = false;
      } else {
        print('Error fetching data');
      }
    } catch (e) {
      print('error while getting data is $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Future<void> getImage() async {
  //   final XFile? _image = (await imagePicker.pickImage(
  //       source: ImageSource.gallery, imageQuality: 50));
  //   if (_image != null) {
  //     image = File(_image.path);
  //     print(image);

  //     update();
  //   } else {
  //     Get.snackbar('Error', 'Please Provide Image');
  //   }
  // }

  // Future<void> getImage() async {
  //   print('test');

  //   final XFile? _image = (await imagePicker.pickImage(
  //       source: ImageSource.gallery, imageQuality: 50));

  //   if (_image != null) {
  //     image = File(_image.path);

  //     update();
  //   } else {
  //     Get.snackbar('Error', 'Please Provide Image');
  //   }
  // }

  Future<void> updateProfile(String id) async {
    try {
      // print(image != null ? image : 'nope');
      var request = http.MultipartRequest(
          'POST', Uri.parse(ApiEndPoints.baseUrl + "member/update"));
      request.fields['id'] = id;
      request.fields['name'] = nameController.text;
      request.fields['address'] = addressController.text;
      request.fields['email'] = emailController.text;
      request.fields['mobile'] = phoneController.text;
      (image != null)
          ? request.files.add(http.MultipartFile.fromBytes(
              'image', File(image!.path).readAsBytesSync(),
              filename: image!.path))
          : request.fields['decoy'] = '';
      var res = await request.send();

      print(res.statusCode);
      if (res.statusCode == 200) {
        await FetchDataMember(box.read('id').toString());
        // Get.snackbar("Update Profile", "Success");
        Get.back();
      }
      // Get.back();
    } catch (e) {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Error'),
              contentPadding: EdgeInsets.all(20),
              children: [Text(e.toString())],
            );
          });

      print(e);
    }
  }
}
