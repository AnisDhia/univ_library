// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:univ_library/screens/bookmarks_screen.dart';
import 'package:univ_library/screens/browse_screen.dart';
import 'package:univ_library/screens/home_screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:univ_library/screens/profile_screen.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  late PageController _controller;
  int _selectedIndex = 0;
  final _pages = const <Widget>[
    HomeScreen(),
    BookmarksScreen(),
    BrowseScreen(),
    ProfileScreen()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _controller.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // extendBody: true,
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          children: _pages,
          controller: _controller,
        ),
        bottomNavigationBar: SalomonBottomBar(
          items: [
            SalomonBottomBarItem(
                icon: const Icon(Icons.home), title: const Text('Home')),
            SalomonBottomBarItem(
                icon: const Icon(Icons.bookmark),
                title: const Text('Bookmarks')),
            SalomonBottomBarItem(
                icon: const Icon(Icons.search), title: const Text('Search')),
            SalomonBottomBarItem(
                icon: const Icon(Icons.person), title: const Text('Profile')),
          ],
          currentIndex: _selectedIndex,
          onTap: _onTap,
        )
        // CurvedNavigationBar(
        //   height: 60,
        //   index: _selectedIndex,
        //   backgroundColor: Colors.transparent,
        //   buttonBackgroundColor: Colors.transparent,
        //   color: Colors.blue,
        //   items: const [
        //     Icon(Icons.home, size: 30),
        //     Icon(Icons.library_books, size: 30,),
        //   ],
        // onTap: (index) {
        //   setState(() {
        //     _selectedIndex = index;
        //   });
        //   _controller.jumpToPage(index);
        // },
        // ),
        );
  }
}
