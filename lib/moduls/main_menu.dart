import 'package:aplikasi_kas/screens/payment_sucess.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainMenuModule extends StatefulWidget {
  const MainMenuModule({Key? key}) : super(key: key);
  @override
  State<MainMenuModule> createState() => _MainMenuModuleState();
}

class _MainMenuModuleState extends State<MainMenuModule> {

  late String _nominal;

  // FirebaseDatabase database = FirebaseDatabase.instance;
  // final transactionDao = TransactionDao();

  @override
  Widget build(BuildContext context) {

    // CollectionReference transactions = FirebaseFirestore.instance.collection('transactions');
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    var currentUser = FirebaseAuth.instance.currentUser!;
    var email = currentUser.email;

    return Container(
        margin: const EdgeInsets.only(left: 30),
        child: Row(
          children: [
            // Menu keamanan Start
            GestureDetector(
              onTap: (){
                showModalBottomSheet<void>(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    builder: (BuildContext context) {
                      return Container(
                        margin: const EdgeInsets.only(top: 22),
                        child: Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/icons/Currency Crush Shield.png', width: 35),
                                  const SizedBox(width: 8),
                                  Text('Keamanan', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600))
                                ],
                              ),
                              const SizedBox(height: 45),

                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Masukan Nominal: ', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
                              ),

                              const SizedBox(height: 20),

                              TextField(
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ], // Only numbers can be entered
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: ((String nominal) {
                                  setState(() {
                                    _nominal = nominal;
                                  });
                                }),
                              ),

                              const SizedBox(height: 50),

                              SizedBox(
                                height: 54,
                                width: 355,
                                child: TextButton(
                                    style: ButtonStyle(
                                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                      backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff6F6CD9)),
                                    ),
                                    onPressed: () {
                                      // final transaction = Transactions('adityanurdin0@gmail.com', '1234', DateTime.now());
                                      // transactionDao.saveTransaction(transaction);
                                      // print(transaction);

                                      CollectionReference transactions = firestore.collection('transactions');
                                      transactions.add({
                                        'email': email,
                                        'type': 'keamanan',
                                        'icon': 'assets/icons/Currency Crush Shield.png',
                                        'nominal': _nominal,
                                        'date': DateTime.now()
                                      })
                                          .then((value) {
                                          Fluttertoast.showToast(
                                              msg: "Payment Success",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.grey,
                                              textColor: Colors.black,
                                              fontSize: 16.0
                                          );
                                          Get.to(() => PaymentSuccessScreen(nominal: _nominal, type: 'Keamanan'));
                                      })
                                          .catchError((error) => print("Failed to add transaction: $error"));

                                    },
                                    child: Text('Bayar', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700))
                                ),
                              ),



                            ],
                          ),
                        ),
                      );
                    }
                );
              },
              child: Container(
                width: 90,
                height: 90,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 21, top: 15, right: 20,),
                      child: Image.asset('assets/icons/Currency Crush Shield.png', width: 39),
                    ),
                    const SizedBox(height: 5),
                    Text('Keamanan', style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w600))
                  ],
                ),
                decoration: BoxDecoration(
                    color:  Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
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
            ),
            // Menu keamanan End

            const SizedBox(width: 25),

            // Menu Kebersihan Start
            GestureDetector(
              onTap: (){
                showModalBottomSheet<void>(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    builder: (BuildContext context) {
                      return Container(
                        margin: const EdgeInsets.only(top: 22),
                        child: Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/icons/Currency Crush Pushcart.png', width: 35),
                                  const SizedBox(width: 8),
                                  Text('Kebersihan', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600))
                                ],
                              ),
                              const SizedBox(height: 45),

                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Masukan Nominal: ', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
                              ),

                              const SizedBox(height: 20),

                              TextField(
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ], // Only numbers can be entered
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: ((String nominal) {
                                  setState(() {
                                    _nominal = nominal;
                                  });
                                }),
                              ),

                              const SizedBox(height: 50),

                              SizedBox(
                                height: 54,
                                width: 355,
                                child: TextButton(
                                    style: ButtonStyle(
                                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                      backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff6F6CD9)),
                                    ),
                                    onPressed: () {
                                      // final transaction = Transactions('adityanurdin0@gmail.com', '1234', DateTime.now());
                                      // transactionDao.saveTransaction(transaction);
                                      // print(transaction);

                                      CollectionReference transactions = firestore.collection('transactions');
                                      transactions.add({
                                        'email': email,
                                        'type': 'kebersihan',
                                        'icon': 'assets/icons/Currency Crush Pushcart.png',
                                        'nominal': _nominal,
                                        'date': DateTime.now()
                                      })
                                          .then((value) {
                                        Fluttertoast.showToast(
                                            msg: "Payment Success",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.grey,
                                            textColor: Colors.black,
                                            fontSize: 16.0
                                        );
                                        Get.to(() => PaymentSuccessScreen(nominal: _nominal, type: 'Kebersihan'));
                                      })
                                          .catchError((error) => print("Failed to add transaction: $error"));

                                    },
                                    child: Text('Bayar', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700))
                                ),
                              ),



                            ],
                          ),
                        ),
                      );
                    }
                );
              },
              child: Container(
                width: 90,
                height: 90,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 21, top: 15, right: 20,),
                      child: Image.asset('assets/icons/Currency Crush Pushcart.png', width: 39),
                    ),
                    const SizedBox(height: 5),
                    Text('Kebersihan', style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w600))
                  ],
                ),
                decoration: BoxDecoration(
                    color:  Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
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
            ),
            // Menu Kebersihan End

            const SizedBox(width: 25),

            // Menu Sumbangan Start
            GestureDetector(
              onTap: (){
                showModalBottomSheet<void>(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    builder: (BuildContext context) {
                      return Container(
                        margin: const EdgeInsets.only(top: 22),
                        child: Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/icons/Currency Crush Secured Folder.png', width: 35),
                                  const SizedBox(width: 8),
                                  Text('Sumbangan', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600))
                                ],
                              ),
                              const SizedBox(height: 45),

                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Masukan Nominal: ', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
                              ),

                              const SizedBox(height: 20),

                              TextField(
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ], // Only numbers can be entered
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: ((String nominal) {
                                  setState(() {
                                    _nominal = nominal;
                                  });
                                }),
                              ),

                              const SizedBox(height: 50),

                              SizedBox(
                                height: 54,
                                width: 355,
                                child: TextButton(
                                    style: ButtonStyle(
                                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                      backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff6F6CD9)),
                                    ),
                                    onPressed: () {
                                      // final transaction = Transactions('adityanurdin0@gmail.com', '1234', DateTime.now());
                                      // transactionDao.saveTransaction(transaction);
                                      // print(transaction);

                                      CollectionReference transactions = firestore.collection('transactions');
                                      transactions.add({
                                        'email': email,
                                        'type': 'sumbangan',
                                        'icon': 'assets/icons/Currency Crush Secured Folder.png',
                                        'nominal': _nominal,
                                        'date': DateTime.now()
                                      })
                                          .then((value) {
                                        Fluttertoast.showToast(
                                            msg: "Payment Success",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.grey,
                                            textColor: Colors.black,
                                            fontSize: 16.0
                                        );
                                        Get.to(() => PaymentSuccessScreen(nominal: _nominal, type: 'Sumbangan'));
                                      })
                                          .catchError((error) => print("Failed to add transaction: $error"));

                                    },
                                    child: Text('Bayar', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700))
                                ),
                              ),



                            ],
                          ),
                        ),
                      );
                    }
                );
              },
              child: Container(
                width: 90,
                height: 90,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 21, top: 15, right: 20,),
                      child: Image.asset('assets/icons/Currency Crush Secured Folder.png', width: 39),
                    ),
                    const SizedBox(height: 5),
                    Text('Sumbangan', style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w600))
                  ],
                ),
                decoration: BoxDecoration(
                    color:  Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
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
            ),
            // Menu Sumbangan End
          ],
        ),
      );
    // Home Menu End;
  }
}
