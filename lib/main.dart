import 'package:classroom/HomeScreen.dart';
import 'package:classroom/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:classroom/SplashScreen.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }
  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType) {
          return GetMaterialApp(
            title: 'Pacxus Inventory System',
            theme: ThemeData(
            ),
            home: user != null ? HomeScreen() : SplashScreen(),
            debugShowCheckedModeBanner: false,
          );
        }
    );
  }
}

