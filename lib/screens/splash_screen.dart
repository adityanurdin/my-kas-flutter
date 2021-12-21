import 'dart:async';

import 'package:aplikasi_kas/moduls/bottom_navigation.dart';
import 'package:aplikasi_kas/screens/home/home.dart';
import 'package:aplikasi_kas/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  timer() {
    // Timer(const Duration(seconds: 3), () => Get.offAll(const Login()));
    Timer(const Duration(seconds: 3), () {
      FirebaseAuth.instance
          .authStateChanges()
          .listen((User? user) {
        if (user == null) {
          Get.offAll(const Login());
        } else {
          Get.offAll(const BottomNavigation());
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    timer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/Currency Crush Currency.png', width: 232, height: 204,),
              const SizedBox(height: 37),
              Text('E-KAS', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700)),
              const SizedBox(height: 37),
              CircularProgressIndicator()
            ],
          ),
        ),
      ),
    );
  }
}
