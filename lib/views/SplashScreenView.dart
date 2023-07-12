import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// import 'inputWrapper.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Container(
        width: double.infinity,
        child: Center(
          // child: Image(
          //   image: AssetImage('images/Aset/suryalogo.png'),
          //   height: 100,
          // ),
          child: CircularProgressIndicator(color: Colors.green[800]),
        ),
      )),
    );
  }
}
