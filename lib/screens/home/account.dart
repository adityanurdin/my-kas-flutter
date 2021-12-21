import 'package:aplikasi_kas/moduls/card_profile.dart';
import 'package:aplikasi_kas/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CardProfileModule(title: 'My Account'),
            const SizedBox(height: 40),
            Center(
              child: SizedBox(
                height: 54,
                width: 255,
                child: TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff6F6CD9)),
                    ),
                    onPressed: () {
                      auth.signOut();
                      Get.offAll(() => Login());
                    },
                    child: Text('Logout', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700))
                ),
              ),
            ),
            // Center(
            //   child: InkWell(
            //     onTap: () {
            //       auth.signOut();
            //       Get.to(() => Login());
            //     },
            //     child: Text('Logout', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400)),
            //   ),
            // ),
          ],
        ),
      )
    );
  }
}
