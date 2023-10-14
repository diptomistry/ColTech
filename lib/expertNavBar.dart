import 'package:coltech/add_post/NewsFeed/HomePage.dart';
import 'package:coltech/expert/expertHomePage.dart';
import 'package:coltech/profile/profile_screen.dart';
import 'package:coltech/userprofile.dart';
import 'package:coltech/users/userHomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'expertprofile.dart';

class ExpertNav extends StatefulWidget {
  const ExpertNav({super.key});

  @override
  State<ExpertNav> createState() => _ExpertNavState();
}

class _ExpertNavState extends State<ExpertNav> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    expertHomePage(),
    ExpertProfile(),
  ];

  void _onItemTapped(int index) {
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
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}
