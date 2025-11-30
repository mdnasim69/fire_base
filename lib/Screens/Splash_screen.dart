import 'dart:async' show Timer;

import 'package:fire_base/Screens/Login_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Counter();

      MoveToNextScreen();

    super.initState();
  }

  RxInt counter = 5.obs;

  Future<void> Counter() async {
    Timer.periodic(Duration(seconds: 1), (time) {
      if (counter.value == 0) {
        time.cancel();
      } else {
        counter--;
      }
    });
  }

  Future<void> MoveToNextScreen() async {
   await Future.delayed(Duration(seconds: 5));
    if(!mounted)return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LoginScreen();
        },
      ),
      (v) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Splash Screen"),
            Obx(() {
              return Text(counter.toString());
            }),
          ],
        ),
      ),
    );
  }
}
