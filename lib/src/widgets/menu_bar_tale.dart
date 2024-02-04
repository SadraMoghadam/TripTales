import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:trip_tales/src/constants/color.dart';
import 'package:trip_tales/src/pages/favorite_tales.dart';
import 'package:trip_tales/src/pages/my_tales.dart';
import 'package:trip_tales/src/pages/profile.dart';
import 'package:trip_tales/src/utils/device_info.dart';

import '../utils/app_manager.dart';
import 'app_bar_tale.dart';

class CustomMenu extends StatefulWidget {
  late int index;

  CustomMenu({super.key, required this.index});
  @override
  _CustomMenuState createState() => _CustomMenuState();
}

class _CustomMenuState extends State<CustomMenu> with TickerProviderStateMixin {
  final screens = [MyTalesPage(), FavoriteTalesPage(), ProfilePage()];
  final AppManager _appManager = Get.put(AppManager());
  late final AnimationController _controller;
  bool isTablet = false;

  Future<void> fetchData() async {
    if(widget.index == 0){
      await Future.delayed(Duration(seconds: 3));
    }
  }

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 4));

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DeviceInfo device = DeviceInfo();
    device.computeDeviceInfo(context);
    isTablet = device.isTablet;
    return Scaffold(
      body: _buildScreenContent(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _buildScreenContent() {
    widget.index = _appManager.getMenuIndex();
    if(widget.index > 3){
      widget.index = 0;
    }
    if (widget.index == 0) {
      return FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            _controller.reset();
            _controller.forward();
            return Center(
              child: Lottie.asset(
                "assets/animations/loading.json",
                width: 400,
                height: 400,
                controller: _controller,
              ),);
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching data'));
          } else {
            return CustomAppBar(
              bodyTale: screens[widget.index],
              showIcon: false,
            );
          }
        },
      );
    } else {
      return CustomAppBar(
        bodyTale: screens[widget.index],
        showIcon: false,
      );
    }
  }

  _bottomNavigationBar() {
    String profileImageUrl = _appManager.getProfileImage() ?? '';
    return isTablet
        ? Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [buildNavigationBar(profileImageUrl)])
        : buildNavigationBar(profileImageUrl);
  }

  Widget buildNavigationBar(String profileImageUrl) {


    return NavigationBar(
      backgroundColor: Colors.white,
      animationDuration: const Duration(seconds: 1),
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      height: 48,
      selectedIndex: widget.index,
      onDestinationSelected: (index) => setState(() => {
        widget.index = index,
        _appManager.setMenuIndex(index),
      }),
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
            backgroundImage: (profileImageUrl.isEmpty || profileImageUrl == "")
                ? AssetImage('assets/images/profile_pic.png') as ImageProvider<Object>?
                : NetworkImage(profileImageUrl) as ImageProvider<Object>?,
          ),
          label: 'Profile',
          tooltip: "Profile Settings",
        ),
      ],
    );
  }
}
