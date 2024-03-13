import 'dart:async';

import 'package:classroom/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class ForgetPassword extends StatefulWidget {
  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController forgetPasswordController = TextEditingController();

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _isFirst = true;

  @override
  void initState() {
    super.initState();

    Timer(Duration(milliseconds: 300), () {
      reload();
    });
  }

  void reload() {
    setState(() {
      _isFirst = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: AnimatedCrossFade(
          duration: Duration(milliseconds: 300),
          firstChild: Container(
            color: Colors.grey.shade200,
          ),
          secondChild: SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 40.h, // Using sizer to make it responsive
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF035ea8),
                              Color(0xFF004e92)
                            ],
                            begin: Alignment.bottomLeft, // Start from bottom-left
                            end: Alignment.topRight, // End in top-right
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(175),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 500),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.white.withOpacity(0.2),
                                      Colors.transparent,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(175),
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Lottie.asset(
                                'assets/Animated/forget.json', // Replace with your animation file path
                                width: 50.w, // Using sizer to make it responsive
                                height: 30.h, // Using sizer to make it responsive
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: forgetPasswordController,
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.black
                              ),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  size: 18.sp,
                                  color: Color(0xFF035ea8),
                                ),
                                labelText: "Email Address",
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Color(0xFF035ea8)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Color(0xFF035ea8)),
                                ),
                              ),
                              validator: (val) {
                                return RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(val!)
                                    ? null
                                    : "Please enter a valid email";
                              },
                            ),
                            SizedBox(height: 5.h),
                            SizedBox(
                              width: 85.w,
                              height: 7.h,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  backgroundColor: Color(0xFF035ea8),
                                ),
                                onPressed: () async {
                                  validateEmail();
                                  var forgetEmail =
                                  forgetPasswordController.text.trim();

                                  try {
                                    await FirebaseAuth.instance
                                        .sendPasswordResetEmail(
                                      email: forgetEmail,
                                    )
                                        .then((value) {
                                      print("Email Sent");
                                      _showEmailSentDialog(); // Show dialog when email is sent
                                      Get.off(() => LoginScreen());
                                    });
                                  } on FirebaseAuthException catch (e) {
                                    print("Error $e");
                                  }
                                },
                                child: Text(
                                  "Reset Password",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 2.h),
                            TextButton(
                              onPressed: () async {
                                await Get.off(() => LoginScreen());
                              },
                              child: Text(
                                "Back to Login",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Color(0xFF035ea8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          crossFadeState: _isFirst
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
        ),
      ),
    );
  }

  validateEmail() {
    if (_formkey.currentState!.validate()) {}
  }

  // Function to show the dialog when email is sent
  void _showEmailSentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Email Sent"),
          content: Text("Please check your email for password reset instructions."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
