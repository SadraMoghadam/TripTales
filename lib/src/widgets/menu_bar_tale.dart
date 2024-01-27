import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_tales/src/constants/color.dart';
import 'package:trip_tales/src/pages/favorite_tales.dart';
import 'package:trip_tales/src/pages/my_tales.dart';
import 'package:trip_tales/src/pages/profile.dart';

import '../utils/app_manager.dart';

class CustomMenu extends StatefulWidget {
  late int index;

  CustomMenu({super.key, this.index = 0});
  @override
  _CustomMenuState createState() => _CustomMenuState();
}

class _CustomMenuState extends State<CustomMenu> {
  final screens = [MyTalesPage(), FavoriteTalesPage(), ProfilePage()];
  final AppManager _appManager = Get.put(AppManager());

  @override
  Widget build(BuildContext context) => Scaffold(
        body: screens[widget.index],
        bottomNavigationBar: _bottomNavigationBar(),
      );

  _bottomNavigationBar() {

    String profileImageUrl = _appManager.getProfileImage();
    return NavigationBar(
      backgroundColor: Colors.white,
      animationDuration: const Duration(seconds: 1),
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      height: 48,
      selectedIndex: widget.index,
      onDestinationSelected: (index) => setState(() => widget.index = index),
      destinations: [
        const NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(
            Icons.home,
            color: AppColors.main1,
          ),
          label: "Home",
          tooltip: "Home Page",
        ),
        const NavigationDestination(
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
            backgroundColor: Colors.transparent,
            radius: 15.0,
            backgroundImage: profileImageUrl.isNotEmpty
                ? NetworkImage(profileImageUrl) as ImageProvider<Object>?
                : AssetImage('assets/images/profile_pic.png') as ImageProvider<Object>?,
          ),
          label: 'Profile',
          tooltip: "Profile Settings",
        ),
      ],
    );
  }
}
