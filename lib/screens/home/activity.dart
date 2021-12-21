import 'package:aplikasi_kas/moduls/card_profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  Widget build(BuildContext context) {

    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    var currentUser = FirebaseAuth.instance.currentUser!;
    var email = currentUser.email;

    return Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              const CardProfileModule(title: 'My Activities'),
              // const SizedBox(height: 40),
              // Center(
              //   child: Text('My Activities',style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
              // ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('transactions')
                        .where('email', isEqualTo: email)
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
                                  width: 345,
                                  height: 79,
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
                ),
              )
            ],
          ),
        ),
    );
  }
}
