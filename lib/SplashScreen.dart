import 'dart:async';
import 'package:classroom/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(Duration(seconds: 4),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset("assets/Animated/splashScreen1.json",width: 60.w,height: 60.h),
              AnimatedTextKit(animatedTexts: [
                WavyAnimatedText("Pacxus Private Limited", textStyle: TextStyle(fontSize: 15.sp, color: Colors.grey, fontFamily: "Poppins"),speed: Duration(milliseconds: 300)),
                // WavyAnimatedText("Loading...", textStyle: TextStyle(fontSize: 20)),
              ]),
              Text("Version 1.0.0", style: TextStyle(fontSize: 12.sp,color: Colors.grey, fontFamily: "Poppins"),)
            ],
          )
      ),
    );
  }
}