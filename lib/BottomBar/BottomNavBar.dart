import 'package:flutter/material.dart';

import 'AllPages/HomePage.dart';
import 'AllPages/MainPeoplePage.dart';
import 'AllPages/QuizePage.dart';
import 'AllPages/SettingsPage.dart';

class BottomNavBar extends StatefulWidget {
  final int page;

  const BottomNavBar({Key? key, required this.page}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState(selectedIndex: page);
}

class _BottomNavBarState extends State<BottomNavBar> {
  _BottomNavBarState({required this.selectedIndex});
  int selectedIndex;
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    MainPeoplePage(),
    QuizPage(),
    SettingPage()

  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor:  Color(0xff2a2e4d),
            icon: Icon(Icons.home,size: 30,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            backgroundColor:  Color(0xff2a2e4d),
            icon: Icon(Icons.person,size: 30,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: Icon(Icons.request_page_rounded,size: 30,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            backgroundColor:  Color(0xff2a2e4d),
            icon: Icon(Icons.settings,size: 30,
            ),
            label: '',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        selectedItemColor: Color(0xff494FC7),
        unselectedItemColor: Colors.grey,
        // selectedIconTheme: const IconThemeData(color: Colors.white),
        onTap: _onItemTapped,

      ),

      body: Center(
        child: _widgetOptions.elementAt(selectedIndex),
      ),
    );
  }
}
