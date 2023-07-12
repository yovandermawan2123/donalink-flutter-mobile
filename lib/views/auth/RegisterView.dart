import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_uas/controllers/auth_controller.dart';
import 'package:get/get.dart';

// import 'inputWrapper.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  AuthController authController = Get.put(AuthController());
  FocusNode myFocusNode = new FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft, colors: [
          Colors.greenAccent.shade700,
          // Colors.red.shade300,
          Colors.greenAccent.shade200,
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Transform(
                        transform: Matrix4.translationValues(0.0, 10, 0.0),
                        child: Image.asset(
                          'images/Assets/Login_Illustration.png',
                          height: 200,
                        ),
                      ),
                      Text(
                        "Register",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
              ),
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    // topRight: Radius.circular(40)
                  )),
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: <Widget>[
                                Card(
                                  child: Container(
                                    height: 46,
                                    child: TextField(
                                      controller: authController.nameController,
                                      decoration: InputDecoration(
                                        alignLabelWithHint: true,
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.green)),
                                        labelText: 'Name',
                                        labelStyle:
                                            TextStyle(color: Colors.grey),
                                        fillColor: Colors.white54,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Card(
                                  child: Container(
                                    height: 46,
                                    child: TextField(
                                      controller:
                                          authController.emailController,
                                      decoration: InputDecoration(
                                        alignLabelWithHint: true,
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.green)),
                                        labelText: 'Email',
                                        labelStyle:
                                            TextStyle(color: Colors.grey),
                                        fillColor: Colors.white54,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Card(
                                  child: Container(
                                    height: 46,
                                    child: TextField(
                                      controller:
                                          authController.mobileController,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: InputDecoration(
                                        alignLabelWithHint: true,
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.green)),
                                        labelText: 'Phone Number',
                                        labelStyle:
                                            TextStyle(color: Colors.grey),
                                        fillColor: Colors.white54,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Card(
                                  child: Container(
                                    height: 46,
                                    child: TextField(
                                      obscureText: true,
                                      controller:
                                          authController.passwordController,
                                      decoration: InputDecoration(
                                        alignLabelWithHint: true,
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.green)),
                                        labelText: 'Password',
                                        labelStyle:
                                            TextStyle(color: Colors.grey),
                                        fillColor: Colors.white54,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.greenAccent.shade700,
                        minimumSize: const Size.fromHeight(50), // NEW
                      ),
                      // onPressed: () {
                      //   Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) {
                      //       return homeView();
                      //     },
                      //   ));
                      // },
                      // onPressed: () => {},
                      onPressed: () => authController.registerWithEmail(),
                      child: const Text(
                        'Register',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: "Already have an account ? ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        TextSpan(
                            text: "Login",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Navigator.of(context).push(MaterialPageRoute(
                                //   builder: (context) {
                                //     // return registerView();
                                //   },
                                // ));
                                Get.back();
                              })
                      ])),
                    )
                  ],
                ),
              ),
            ))
            // SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
