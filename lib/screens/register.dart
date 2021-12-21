import 'dart:async';

import 'package:aplikasi_kas/screens/home/home.dart';
import 'package:aplikasi_kas/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';



class RegisterScreen extends StatefulWidget {
  const RegisterScreen({ Key? key }) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

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
                        child: Text('Lets Join with Us!', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700)),
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
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => const Home()),
                              // );
                              try {
                                auth.createUserWithEmailAndPassword(email: _email, password: _password);
                                const CircularProgressIndicator();
                                Timer(const Duration(seconds: 3), () => Get.offAll(Login()));
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'weak-password') {
                                  print('The password provided is too weak.');
                                  SnackBar(
                                    content: const Text('The password provided is too weak.'),
                                  );
                                } else if (e.code == 'email-already-in-use') {
                                  print('The account already exists for that email.');
                                }
                              } catch (e) {
                                print(e);
                              }
                            },
                            child: Text('Register', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700))
                        ),
                      ),
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