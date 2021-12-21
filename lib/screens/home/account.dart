import 'dart:async';

import 'package:aplikasi_kas/moduls/card_profile.dart';
import 'package:aplikasi_kas/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  late String _password;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    var currentUser = FirebaseAuth.instance.currentUser!;
    var email = currentUser.email;

    // set up the buttons
    Widget cancelButton = TextButton(
        child: Text("Cancel"),
        onPressed:  () {
          Navigator.of(context, rootNavigator: true).pop();
        },
      );
      Widget continueButton = TextButton(
        child: Text("Yes"),
        onPressed:  () async {
          await currentUser.delete().then((value) {
            Fluttertoast.showToast(
                msg: "Successfully delete, good bye :)",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.grey,
                textColor: Colors.black,
                fontSize: 16.0
            );
            auth.signOut();
            Get.offAll(() => Login());
          }).catchError((error) {
            print('Error: $error');
            if (error.code == 'requires-recent-login') {
              Fluttertoast.showToast(
                  msg: "Error while delete, please login again",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.grey,
                  textColor: Colors.black,
                  fontSize: 16.0
              );
              auth.signOut();
              Get.offAll(() => Login());
            } else {
              Fluttertoast.showToast(
                  msg: "Error while delete user",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.grey,
                  textColor: Colors.black,
                  fontSize: 16.0
              );
            }
          });
        },
      );


    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CardProfileModule(title: 'My Account'),
            const SizedBox(height: 40),
            Text('Edit Profile', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600)),
            const SizedBox(height: 25),
            Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.only(left: 19, right: 19),
                    child: Column(
                      children: [
                        /*Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Email', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          initialValue: email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          onChanged: ((String value) {
                            setState(() {
                              _email = value;
                            });
                          }),
                        ),
                        const SizedBox(height: 10),*/
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('New Password', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          onChanged: ((String value) {
                            setState(() {
                              _password = value;
                            });
                          }),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          height: 54,
                          width: 255,
                          child: TextButton(
                              style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff6F6CD9)),
                              ),
                              onPressed: () async {

                                await currentUser.updatePassword(_password).then((value) {
                                  print('sukses');
                                  Fluttertoast.showToast(
                                      msg: "Successfully update password",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.grey,
                                      textColor: Colors.black,
                                      fontSize: 16.0
                                  );
                                }).catchError((error) {
                                  print('Error: $error');
                                  if (error.code == 'requires-recent-login') {
                                    Fluttertoast.showToast(
                                        msg: "Error while update password, please login again",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.grey,
                                        textColor: Colors.black,
                                        fontSize: 16.0
                                    );
                                    auth.signOut();
                                    Get.offAll(() => Login());
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Error while update password",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.grey,
                                        textColor: Colors.black,
                                        fontSize: 16.0
                                    );
                                  }
                                });

                              },
                              child: Text('Save Change', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700))
                          ),
                        ),

                        const SizedBox(height: 70),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  auth.signOut();
                                  Get.offAll(() => Login());
                                },
                                child: Text('Logout', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
                              ),
                              const SizedBox(width: 15),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Delete User Confirm'),
                                        content: Text('Are you sure for delete this user ?'),
                                        actions: [
                                          cancelButton,
                                          continueButton,
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Text('Delete Account', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
                              ),
                            ],
                          )
                        ),
                      ],
                    ),
                  ),
                ),
            ),
          ],
        ),
      )
    );
  }
}
