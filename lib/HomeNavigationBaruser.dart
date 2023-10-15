import 'package:coltech/add_post/NewsFeed/HomePage.dart';
import 'package:coltech/expert/expertHomePage.dart';
import 'package:coltech/profile/profile_screen.dart';
import 'package:coltech/userprofile.dart';
import 'package:coltech/userprofile2.dart';
import 'package:coltech/users/userHomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ExpertPage.dart';

class UserNav extends StatefulWidget {
  const UserNav({super.key});

  @override
  State<UserNav> createState() => _UserNavState();
}

class _UserNavState extends State<UserNav> {
  int _selectedIndex = 0;
  var pages = [UserHomePage(), NewsFeed(), UserProfile()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.question_mark), label: 'Feed'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildPage(int index) {
    if (index == 0) {
      return UserHomePage();
    } else if (index == 1) {
      return NewsFeed();
    } else {
      return UserProfile(); // Default to UserHomePage.
    }
  }
}
