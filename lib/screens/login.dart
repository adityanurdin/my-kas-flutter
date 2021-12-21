import 'dart:async';

import 'package:aplikasi_kas/moduls/bottom_navigation.dart';
import 'package:aplikasi_kas/screens/home/home.dart';
import 'package:aplikasi_kas/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';



class Login extends StatefulWidget {
  const Login({ Key? key }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  late String _email, _password;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 89),
              Align(
                alignment: Alignment.center,
                child: Image.asset('assets/images/Currency Crush Currency.png', width: 177, height: 145,),
              ),
              const SizedBox(height: 64),
              Container(
                margin: const EdgeInsets.only(left: 19, right: 19),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Welcome Back!', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700)),
                    ),
                    const SizedBox(height: 13),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Email', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      onChanged: ((String email) {
                        setState(() {
                          _email = email;
                        });
                      }),
                    ),
                    const SizedBox(height: 13),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Password', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      onChanged: ((String password) {
                        setState(() {
                          _password = password;
                        });
                      }),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      height: 54,
                      width: 355,
                      child: TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff6F6CD9)),
                          ),
                          onPressed: () async {
                            try {
                              await auth.signInWithEmailAndPassword(email: _email, password: _password);
                              Get.offAll(() => BottomNavigation());
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                print('No user found for this email.');
                                Fluttertoast.showToast(
                                    msg: "No user found for this email",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.grey,
                                    textColor: Colors.black,
                                    fontSize: 16.0
                                );
                              } else if (e.code == 'wrong-password') {
                                print('Wrong password provided for that user.');
                                Fluttertoast.showToast(
                                    msg: "Wrong password provided for that user.",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.grey,
                                    textColor: Colors.black,
                                    fontSize: 16.0
                                );
                              }
                            }
                          },
                          child: Text('Login', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700))
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        Get.to(() => RegisterScreen());
                      },
                      child: Text('Register', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400)),
                    )
                  ],
                ),
              )

            ],
          ),
        ),
      )
    );
  }
}