import 'dart:convert';
import 'package:get_storage/get_storage.dart';
// import 'package:surya_remmitance/views/mainHomeView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_uas/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final box = GetStorage();
  final passwordVisible = false.obs;

  Future<void> loginWithEmail() async {
    var headers = {
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*'
    };
    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.loginEmail);
      Map body = {
        'mobile': mobileController.text,
        'password': passwordController.text
      };
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        var token = json['body']['access_token'];
        var data = json['body']['data'];
        // final SharedPreferences? prefs = await _prefs;
        // await prefs?.setString('token', token);
        box.write('token', token);
        box.write('id', data['id']);
        box.write('name', data['name']);
        // box.write('token', token);

        mobileController.clear();
        passwordController.clear();
        // Get.offAll(homeView());
        Get.toNamed("/home");
      } else if (response.statusCode == 400) {
        throw jsonDecode(response.body)["message"] ??
            "Username / Password salah!";
      } else {
        throw jsonDecode(response.body)["message"] ?? "Unknown Error Occured";
      }
    } catch (error) {
      print(error.toString());
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Error'),
              contentPadding: EdgeInsets.all(20),
              children: [Text(error.toString())],
            );
          });
    }
  }

  Future<void> registerWithEmail() async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.registerEmail);
      Map body = {
        'name': nameController.text,
        'email': emailController.text.trim(),
        'mobile': mobileController.text,
        'password': passwordController.text
      };

      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        var token = json['body']['name'];

        // final SharedPreferences? prefs = await _prefs;
        // await prefs?.setString('token', token);
        // Get.offAll(otpView(), arguments: mobileController.text);
        nameController.clear();
        emailController.clear();
        mobileController.clear();
        passwordController.clear();

        // Get.toNamed('/reward/detail', arguments: id);
        showDialog(
            context: Get.context!,
            builder: (context) {
              return SimpleDialog(
                title: Text('Success'),
                contentPadding: EdgeInsets.all(20),
                children: [
                  Text(' Registrasi Berhasil! '),
                  SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: () {
                        // Get.offAll(loginView());
                        Get.toNamed("/login");
                      },
                      child: Text('Close'))
                ],
              );
            });
      } else {
        throw jsonDecode(response.body)["Message"] ?? "Unknown Error Occured";
      }
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

  void togglePassword() {
    // print(tabIndex);
    passwordVisible.value = !passwordVisible.value;

    update();
    print(passwordVisible.value);
  }
}
