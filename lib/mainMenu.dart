import 'package:IIIT_Surat_Connect/Assignment/assignment.dart';
import 'package:IIIT_Surat_Connect/Profile/profile.dart';
import 'package:IIIT_Surat_Connect/bulletin/eventPage.dart';
import 'package:IIIT_Surat_Connect/homePage.dart';
import 'package:flutter/material.dart';

import 'Utils/constants.dart';
import 'buySell/eCommerce.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

int _selectedIndex = 0;

List<Widget> _widgetOptions = <Widget>[
  HomePage(),
  Assignment(),
  EventPage(),
  Profile(),
];

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: bc,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment),
              title: Text('E-Commerce'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.new_releases),
              title: Text('Events'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile'),
            ),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
