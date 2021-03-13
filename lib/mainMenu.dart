import 'package:flutter/material.dart';
import 'package:IIIT_Surat_Connect/homePage.dart';
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
  ECommerce(),
  ECommerce(),
  //Profile(),
  ECommerce()
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
              title: Text('Assignment'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.new_releases),
              title: Text('Bulletin'),
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