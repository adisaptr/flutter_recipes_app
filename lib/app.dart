import 'package:flutter/material.dart';

import 'features/presentation/pages/article/main.dart';
import 'features/presentation/pages/favorite/main.dart';
import 'features/presentation/pages/home/main.dart';
import 'features/presentation/pages/search/main.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    Home(),
    SearchRecipe(),
    ArticleRecipe(),
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
      // body: _pages[_selectedIndex],
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          Home(),
          SearchRecipe(),
          ArticleRecipe(),
          FavoriteRecipe()
        ],
      ),
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
            icon: Icon(Icons.article),
            label: 'Article',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
        ],
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF16c79e),
        onTap: _onItemTapped,
      ),
    );
  }
}
