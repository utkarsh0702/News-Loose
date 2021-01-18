import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'home.dart';
import 'category/categories.dart';
import 'owner.dart';
import 'profile.dart';
import 'search/search.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final HomePage homepage = HomePage();
  final Categories categories = new Categories();
  final Owner owner = new Owner();
  final Profile profile = new Profile();
  final Search search = new Search();

  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            homepage,
            categories,
            search,
            owner,
            profile,
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        containerHeight: 60,
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 20,
        curve: Curves.easeIn,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              title: Center(
                  child: Text(
                'Home',
                style: TextStyle(fontSize: 18.0),
              )),
              icon: Icon(Icons.home)),
          BottomNavyBarItem(
              title: Center(
                  child: Text(
                'Category',
                style: TextStyle(fontSize: 18.0),
              )),
              icon: Icon(Icons.category)),
          BottomNavyBarItem(
              title: Center(
                  child: Text(
                'Search',
                style: TextStyle(fontSize: 18.0),
              )),
              icon: Icon(Icons.search)),
          BottomNavyBarItem(
              title: Center(
                  child: Text(
                'News',
                style: TextStyle(fontSize: 18.0),
              )),
              icon: Icon(Icons.accessibility_new)),
          BottomNavyBarItem(
              title: Center(
                  child: Text(
                'Profile',
                style: TextStyle(fontSize: 18.0),
              )),
              icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}
