import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trip_tales/src/pages/Login.dart';
import 'package:trip_tales/src/pages/create_tale_page.dart';
import 'package:trip_tales/src/pages/my_tales.dart';
import 'package:trip_tales/src/pages/register.dart';
import 'package:trip_tales/src/utils/device_info.dart';
import '../constants/color.dart';

class CustomMenu extends StatefulWidget {
  const CustomMenu({Key? key}) : super(key: key);

  @override
  _CustomMenuState createState() => _CustomMenuState();
}

class _CustomMenuState extends State<CustomMenu> {
  int _currentIndex = 0;
  // List pages = [MyTalesPage(), CreateTalePage(), RegisterPage()];

  void onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavigationBar(),
      //body: pages[_currentIndex],
    );
  }

  _bottomNavigationBar() {
    return NavigationBar(
      backgroundColor: Colors.white,
      animationDuration: const Duration(seconds: 1),
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      height: 60,
      // selectedIndex: MyTalesPage();
      // _currentIndex,
      onDestinationSelected: onTap,
      destinations: const [
        NavigationDestination(
          selectedIcon: Icon(Icons.home),
          icon: Icon(Icons.home),
          label: "Home",
        ),
        NavigationDestination(
          icon: Icon(Icons.add_circle_outline_rounded),
          label: "Add",
        ),
        NavigationDestination(
          icon: Icon(Icons.search),
          label: "Search",
        ),
      ],
    );
  }
/*
  _getPages() {
    switch (_currentIndex) {
      case 0:
        return MyTalesPage();
      case 1:
        return LoginPage(); // Create Tale Page
      case 2:
        return RegisterPage(); // Search tale in current page
    }
  }
}
*/
  /*
     MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(),

        color: Color.fromARGB(255, 255, 255, 255),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: Center(
                child: IconButton(
                    icon: Icon(
                      Icons.home,
                      color: ctext2,
                    ), //
                    onPressed: () {
                      // Implement action for Home button
                    }),
              ),
            ),
            Expanded(
              child: Center(
                child: IconButton(
                    icon: Icon(
                      Icons.add_circle_outline,
                      color: ctext2,
                    ), //
                    onPressed: () {
                      // Implement action for Home button
                    }),
              ),
            ),
            Expanded(
              child: Center(
                child: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: ctext2,
                    ), //
                    onPressed: () {
                      // Implement action for Home button
                    }),
              ),
            ),
          ],
        ),
      ),
    );
    */
}
