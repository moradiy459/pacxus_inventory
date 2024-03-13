import 'dart:async';
import 'package:classroom/ForgetPassword.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:classroom/HomeScreen.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var obscureText = true;

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool _isLoading = false;
  late final message;
  bool _isBackPressed = false; // Keep track of back button press

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_isBackPressed) {
          // Exit the app when back button is pressed twice
          return true;
        } else {
          // Set _isBackPressed to true and wait for 2 seconds
          _isBackPressed = true;
          Timer(Duration(seconds: 2), () {
            _isBackPressed = false; // Reset _isBackPressed after 2 seconds
          });
          // Show a snackbar to inform the user
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Press back again to exit'),
              duration: Duration(seconds: 2),
            ),
          );
          return false;
        }
      },
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 40.h, // Using Sizer to make it responsive
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF035ea8),
                                      Color(0xFF004e92),
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
                                      child: SizedBox(
                                        width: 80.w, // Using Sizer to make it responsive
                                        height: 80.w, // Using Sizer to maintain aspect ratio
                                        child: Lottie.asset(
                                          'assets/Animated/loginscreen.json', // Replace with your animation file path
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Container(
                              child: Form(
                                key: formkey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: loginEmailController,
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.person,
                                            size: 18,
                                            color: Color(0XFF035ea8),
                                          ),
                                          labelText: "Email Address",
                                          fillColor: Colors.grey,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide:
                                                BorderSide(color: Color(0XFF035ea8)),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Color(0XFF035ea8)))),
                                      validator: (val) {
                                        return RegExp(
                                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                .hasMatch(val!)
                                            ? null
                                            : "Please enter a valid email";
                                      },
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    TextFormField(
                                      controller: loginPasswordController,
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                      keyboardType: TextInputType.text,
                                      obscureText: obscureText,
                                      decoration: InputDecoration(
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                obscureText = !obscureText;
                                              });
                                            },
                                            child: obscureText
                                                ? Icon(
                                                    Icons.visibility_off,
                                                    color: Color(0XFF035ea8),
                                                  )
                                                : Icon(
                                                    Icons.visibility,
                                                    color: Color(0XFF035ea8),
                                                  ),
                                          ),
                                          prefixIcon: Icon(
                                            Icons.lock_outline,
                                            size: 18,
                                            color: Color(0XFF035ea8),
                                          ),
                                          labelText: "Password",
                                          fillColor: Colors.grey,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide:
                                                BorderSide(color: Color(0XFF035ea8)),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Color(0XFF035ea8)))),
                                      validator: (val) {
                                        if (val!.length < 6) {
                                          return "Password must be at least 6 characters";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    SizedBox(height: 0.1.h),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                            onPressed: () async {
                                              await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ForgetPassword()));
                                            },
                                            child: Text(
                                              "Forget Password ?",
                                              style: TextStyle(color: Colors.black87),
                                            ))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    SizedBox(
                                      width: 85.w,
                                      height: 7.h,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          backgroundColor: Color(0XFF035ea8),
                                        ),
                                        onPressed: () async {
                                          login();
                                          var loginEmail = loginEmailController.text.trim();
                                          var loginPassword = loginPasswordController.text.trim();

                                          setState(() {
                                            _isLoading = true; // Show loading animation
                                          });

                                          try {
                                            final UserCredential userCredential =
                                            await FirebaseAuth.instance.signInWithEmailAndPassword(
                                              email: loginEmail,
                                              password: loginPassword,
                                            );

                                            // If user is successfully authenticated
                                            if (userCredential.user != null) {
                                              // Show a dialog with success message
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    backgroundColor: Color(0XFF035ea8),
                                                    title: Text("Success",style: TextStyle(color: Colors.white),),
                                                    content: Text("Login Successful!",style: TextStyle(color: Colors.white),),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context).pop();
                                                          // Navigate to home screen after dialog is dismissed
                                                          Get.to(() => HomeScreen());
                                                        },
                                                        child: Text("OK",style: TextStyle(color: Colors.white),),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            } else {
                                              // Show an alert dialog for incorrect credentials
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text("Error"),
                                                    content: Text("Incorrect email or password"),
                                                    actions: [
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
                                          } on FirebaseAuthException catch (e) {
                                            print("Error $e");

                                            String errorMessage = "An error occurred";

                                            if (e.code == 'user-not-found') {
                                              errorMessage = 'No user found with this email address';
                                            } else if (e.code == 'wrong-password') {
                                              errorMessage = 'Incorrect password';
                                            }

                                            // Show an alert dialog with the error message
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text("Error"),
                                                  content: Text(errorMessage),
                                                  actions: [
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
                                          } finally {
                                            setState(() {
                                              _isLoading = false; // Hide loading animation
                                            });
                                          }
                                        },
                                        child: _isLoading
                                            ? Theme(
                                          data: ThemeData(
                                            primaryColor: Colors.white,
                                          ),
                                              child: CupertinoActivityIndicator(
                                                                                        radius: 15.0,
                                                                                      ),
                                            ) // Show loading indicator
                                            : Text(
                                          "Login",
                                          style: TextStyle(color: Colors.white,fontSize: 14.sp),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
              ),
      ),
    );
  }

  login() {
    if (formkey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
    }
  }
}
