import 'package:aplikasi_kas/screens/home/account.dart';
import 'package:aplikasi_kas/screens/home/activity.dart';
import 'package:aplikasi_kas/screens/home/home.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {


  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    ActivityScreen(),
    AccountScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xff6F6CD9),
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              // icon: ImageIcon(AssetImage('assets/icons/Icon.png'), size: 24,),
              label: 'Home'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long),
              label: 'My Activities'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
