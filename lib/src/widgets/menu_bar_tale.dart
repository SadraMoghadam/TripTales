import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trip_tales/src/pages/Login.dart';
import 'package:trip_tales/src/pages/create_tale_page.dart';
import 'package:trip_tales/src/pages/favorite_tales.dart';
import 'package:trip_tales/src/pages/my_tales.dart';
import 'package:trip_tales/src/pages/register.dart';
import 'package:trip_tales/src/utils/device_info.dart';
import '../constants/color.dart';

class CustomMenu extends StatefulWidget {
  @override
  _CustomMenuState createState() => _CustomMenuState();
}

class _CustomMenuState extends State<CustomMenu> {
  int index = 0;
  final screens = [MyTalesPage(), FavoriteTales(const []), LoginPage()];

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
          selectedIcon: Icon(Icons.home),
          label: "Home",
          tooltip: "Home Page",
        ),
        NavigationDestination(
          icon: Icon(Icons.favorite_border_rounded),
          selectedIcon: Icon(Icons.favorite),
          label: "Favorite",
          tooltip: "Favorite Tales",
        ),
        NavigationDestination(
          icon: CircleAvatar(
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
