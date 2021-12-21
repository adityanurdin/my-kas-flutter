import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardProfileModule extends StatelessWidget {

   final String title;

  const CardProfileModule({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // greeting = 'Welcome Back';
    var currentUser = FirebaseAuth.instance.currentUser!;
    var email = currentUser.email;

    return // Card Profile Start
      SizedBox(
        height: 137,
        child: Container(
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, right: 15),
                child: Image.asset('assets/images/Profile Pic.png', width: 65),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Text('Hi, $email!',style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
                  Text(title,style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w400)),
                ],
              )
            ],
          ),
          decoration: BoxDecoration(
              color: const Color(0xffD0F1EB),
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                )
              ]
          ),
        ),
      );
    // Card Profile End
  }
}
