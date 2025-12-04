import 'dart:async' show Timer;

import 'package:fire_base/Screens/SignIn.dart';
import 'package:fire_base/Screens/SignUp_screen.dart';
import 'package:fire_base/Screens/home_screen.dart';
import 'package:fire_base/auth/saveUserUID.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseAuth auth =FirebaseAuth.instance;
  @override
  void initState() {
    asyncInit();
      Counter();
      MoveToNextScreen();
    super.initState();
  }

  asyncInit()async{
    await UserUID.getData();
  }

  RxInt counter = 5.obs;

  Future<void> Counter() async {
   await Timer.periodic(Duration(seconds: 1), (time) {
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
          bool res =IsTokenAva();
          if(!res){
            return SignInScreen();
          }else{
            return Home();
          }
        },
      ),
      (v) => false,
    );
  }

  bool IsTokenAva(){
    User? token =auth.currentUser ;
    if(token==null){
      return false;
    }else{
      return true;
    }
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
