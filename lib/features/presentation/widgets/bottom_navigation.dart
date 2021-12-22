import 'package:flutter/material.dart';

import '../pages/favorite/main.dart';
import '../pages/home/main.dart';
import '../pages/search/main.dart';

class BottomNavigationApp extends StatefulWidget {
  const BottomNavigationApp({Key? key}) : super(key: key);

  @override
  _BottomNavigationAppState createState() => _BottomNavigationAppState();
}

class _BottomNavigationAppState extends State<BottomNavigationApp> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    Home(),
    SearchRecipe(),
    FavoriteRecipe(),
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
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.history),
          //   label: 'History',
          // ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
    // return BottomNavigationBar(
    //   items: const <BottomNavigationBarItem>[
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.home),
    //       label: 'Home',
    //     ),
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.search),
    //       label: 'Search',
    //     ),
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.favorite),
    //       label: 'Favorite',
    //     ),
    //     // BottomNavigationBarItem(
    //     //   icon: Icon(Icons.history),
    //     //   label: 'History',
    //     // ),
    //   ],
    //   currentIndex: _selectedIndex,
    //   selectedItemColor: Colors.blue,
    //   onTap: _onItemTapped,
    // );
  }
}
