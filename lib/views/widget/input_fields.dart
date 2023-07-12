// ignore_for_file: prefer_const_constructors

// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_uas/controllers/auth_controller.dart';
import 'package:get/get.dart';

class InputTextFieldWidget extends StatelessWidget {
  AuthController loginController = Get.put(AuthController());
  final TextEditingController textEditingController;
  final String hintText;
  final String obsecure;
  late final String multiline;
  late final bool disabled;

  InputTextFieldWidget(
      this.textEditingController, this.hintText, this.obsecure, this.multiline,
      [this.disabled = false]);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 46,
        child: (obsecure == 'false')
            ? TextField(
                style: TextStyle(
                    color: (disabled == true) ? Colors.grey : Colors.black),
                enabled: disabled == true ? false : true,
                obscureText: false,
                // obsecure == 'false' ? false : true,
                // maxLines: multiline == 'true' ? 5 : null,
                controller: textEditingController,
                decoration: InputDecoration(
                    alignLabelWithHint: true,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    fillColor: Colors.white54,
                    hintText: hintText,
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding: EdgeInsets.only(bottom: 15),
                    suffixIcon: (obsecure == 'false')
                        ? null
                        : Obx(() => IconButton(
                              icon: Icon(
                                  loginController.passwordVisible.value == true
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                              onPressed: () {
                                // setState(
                                //   () {
                                //     passwordVisible = !passwordVisible;
                                //   },
                                // );
                                loginController.togglePassword();
                              },
                            )),
                    // suffixIcon: null,
                    focusColor: Colors.white60),
              )
            : Obx(() => TextField(
                  style: TextStyle(
                      color: (disabled == true) ? Colors.grey : Colors.black),
                  enabled: disabled == true ? false : true,
                  obscureText: (loginController.passwordVisible.value == true)
                      ? false
                      : true,
                  // obsecure == 'false' ? false : true,
                  // maxLines: multiline == 'true' ? 5 : null,
                  controller: textEditingController,
                  decoration: InputDecoration(
                      alignLabelWithHint: true,
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      disabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.white54,
                      hintText: hintText,
                      hintStyle: TextStyle(color: Colors.grey),
                      contentPadding: EdgeInsets.only(bottom: 15),
                      suffixIcon: (obsecure == 'false')
                          ? null
                          : Obx(() => IconButton(
                                icon: Icon(
                                    loginController.passwordVisible.value ==
                                            true
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                onPressed: () {
                                  // setState(
                                  //   () {
                                  //     passwordVisible = !passwordVisible;
                                  //   },
                                  // );
                                  loginController.togglePassword();
                                },
                              )),
                      // suffixIcon: null,
                      focusColor: Colors.white60),
                )),
      ),
    );
  }
}
