import 'package:aplikasi_kas/moduls/card_profile.dart';
import 'package:aplikasi_kas/moduls/main_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Home extends StatefulWidget {

  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // @override
  // void setState(VoidCallback fn) {
  //   final firebaseUser = FirebaseAuth.instance.currentUser!;
  //   print(firebaseUser);
  //   super.setState(fn);
  // }

  @override
  Widget build(BuildContext context) {

    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    var currentUser = FirebaseAuth.instance.currentUser!;
    var email = currentUser.email;


    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [

            // Card Profile Start
            const CardProfileModule(title: 'Welcome Back',),
            // Card Profile End

            const SizedBox(height: 48),

            const MainMenuModule(),

            const SizedBox(height: 48),
            Container(
              margin: const EdgeInsets.only(left: 30, bottom: 25),
              alignment: Alignment.centerLeft,
              child: Text('Your last activities', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600)),
            ),
            Container(
              // margin: const EdgeInsets.only(left: 30),
              alignment: Alignment.centerLeft,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('transactions')
                          .where('email', isEqualTo: email)
                          .limit(4)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        final data = snapshot.requireData;

                        if (data.size < 1) {
                          return Center(
                            child: Container(
                              width: 315,
                              height: 59,
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('No Activity Yet', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ),
                              decoration: const BoxDecoration(
                                color:  Color(0xffF4F7FA),
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                          );
                        } else {
                          return ListView.builder(
                            primary: false,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: data.size,
                            itemBuilder: (context, index) {
                              // print(data.docs[index].get('email'));
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[

                                  Container(
                                    width: 315,
                                    height: 59,
                                    child: Container(
                                      margin: const EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Image.asset(data.docs[index].get('icon'), width: 39),
                                          Text(data.docs[index].get('type'), style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
                                          Text('Rp. ${data.docs[index].get('nominal')}', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w400)),
                                        ],
                                      ),
                                    ),
                                    decoration: const BoxDecoration(
                                      color:  Color(0xffF4F7FA),
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                ],
                              );
                            },
                          );
                        }
                      },
                    ),
                  ],
                )
              )
            )
          ],
        ),
      ),
    );
  }
}
