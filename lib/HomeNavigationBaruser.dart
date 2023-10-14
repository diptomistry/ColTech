import 'package:coltech/expert/expertHomePage.dart';
import 'package:coltech/profile/profile_screen.dart';
import 'package:coltech/users/userHomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserNav extends StatefulWidget {
  const UserNav({super.key});

  @override
  State<UserNav> createState() => _UserNavState();
}

class _UserNavState extends State<UserNav> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    expertHomePage(),
    expertHomePage(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    print(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}
