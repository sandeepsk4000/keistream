import 'package:flutter/material.dart';
import 'package:project1/screens/home_screen.dart';
import 'package:project1/screens/playlist_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:project1/screens/search_screen.dart';

import 'favourite_screen.dart';

class BottomNavigationBar1 extends StatefulWidget {
  const BottomNavigationBar1({super.key});

  @override
  State<BottomNavigationBar1> createState() => _BottomNavigationBar1State();
}

class _BottomNavigationBar1State extends State<BottomNavigationBar1> {
  int _selectedIndex = 0;
  void _navigatebottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const HomeScreen(),
    //const RecentPlayedScreen(),
    const SearchScreen(),
    const FavouriteScreen(),
    const PlaylistScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: Container(
          //decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black,),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.black),
          
          child:
              Padding(padding: const EdgeInsets.all(14),
              child: GNav(padding: const EdgeInsets.all(14),
              tabBorderRadius: 30.0,
              iconSize:25,
              backgroundColor: Colors.black,
              color: Colors.white,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.grey.shade800,
             
              tabs: const [
                GButton(icon: Icons.home),
               // GButton(icon: Icons.auto_awesome_motion),
               GButton(icon: Icons.search),
                GButton(icon: Icons.favorite),
                GButton(icon: Icons.playlist_add),
      
              ],
              onTabChange: _navigatebottomBar,
      
              
      
      
               ),
        ),),
      ),
    );
  }
}
