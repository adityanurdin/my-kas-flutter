import 'dart:ui';

import 'package:aplikasi_kas/moduls/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class PaymentSuccessScreen extends StatelessWidget {

  final String nominal;
  final String type;

  const PaymentSuccessScreen({Key? key, required this.nominal, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            width: double.infinity,
            color: Color(0xffD0F1EB),
            child: Column(
              children: [
                const SizedBox(height: 100),
                Image.asset('assets/images/Currency Crush Spakling Bitcoin.png', width: 260),
                const SizedBox(height: 30),
                Text('Payment Success!', style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.w700)),
                const SizedBox(height: 20),
                Text('Rp. $nominal', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600)),
                const SizedBox(height: 10),
                Text('For "Pembayaran $type"', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w400)),
                const SizedBox(height: 40),
                SizedBox(
                  height: 54,
                  width: 255,
                  child: TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff6F6CD9)),
                      ),
                      onPressed: () {
                        Get.offAll(() => const BottomNavigation());
                      },
                      child: Text('Back to Home', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700))
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
