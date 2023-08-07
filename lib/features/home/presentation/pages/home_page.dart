import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kazokku_technical_test/features/likes/presentation/pages/likes_page.dart';
import 'package:kazokku_technical_test/resources/colors.dart';

import '../../../explorer/presentation/pages/explorer_page.dart';
import '../../../users/presentation/pages/users_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Scaffold(
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: const <Widget>[
              UsersPage(),
              ExplorerPage(),
              LikesPage(),
              // ExplorerPage(),
              // LikesPage(),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
          ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: GNav(
              gap: 0,
              activeColor: Colors.white,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              duration: const Duration(milliseconds: 800),
              tabBackgroundColor: AppColors.deepSkyBlue,
              tabs: const [
                GButton(
                  icon: CupertinoIcons.person,
                  text: 'Users',
                ),
                GButton(
                  icon: CupertinoIcons.home,
                  text: 'Explorer',
                ),
                GButton(
                  icon: CupertinoIcons.heart,
                  text: 'Likes',
                ),
              ],
              selectedIndex: _currentIndex,
              onTabChange: (index) {
                setState(() => _currentIndex = index);
                _pageController!.jumpToPage(index);
              },
            ),
          ),
        ),
      ),
    );
  }
}
