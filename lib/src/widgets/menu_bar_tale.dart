import 'package:flutter/material.dart';
import 'package:trip_tales/src/constants/color.dart';
import 'package:trip_tales/src/pages/favorite_tales.dart';
import 'package:trip_tales/src/pages/my_tales.dart';
import 'package:trip_tales/src/pages/profile.dart';

class CustomMenu extends StatefulWidget {
  @override
  _CustomMenuState createState() => _CustomMenuState();
}

class _CustomMenuState extends State<CustomMenu> {
  int index = 0;
  final screens = [MyTalesPage(), FavoriteTalesPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) => Scaffold(
        body: screens[index],
        bottomNavigationBar: _bottomNavigationBar(),
      );

  _bottomNavigationBar() {
    return NavigationBar(
      backgroundColor: Colors.white,
      animationDuration: const Duration(seconds: 1),
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      height: 48,
      selectedIndex: index,
      onDestinationSelected: (index) => setState(() => this.index = index),
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(
            Icons.home,
            color: AppColors.main1,
          ),
          label: "Home",
          tooltip: "Home Page",
        ),
        NavigationDestination(
          icon: Icon(Icons.favorite_border_rounded),
          selectedIcon: Icon(
            Icons.favorite,
            color: AppColors.main1,
          ),
          label: "Favorite",
          tooltip: "Favorite Tales",
        ),
        NavigationDestination(
          icon: CircleAvatar(
            backgroundColor: AppColors.main1,
            radius: 15.0,
            backgroundImage: AssetImage(
              'assets/images/profile_pic.png',
            ),
          ),
          label: 'Profile',
          tooltip: "Profile Settings",
        ),
/*
          icon: Icon(Icons.search),
          selectedIcon: Icon(Icons.saved_search),
          label: "Search",
         
        ),  */
      ],
    );
  }
}
