import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trip_tales/src/utils/device_info.dart';
import '../constants/color.dart';

class CustomMenu extends StatefulWidget {
  /*
  final String talePath;
  final String taleName;
  final bool talePos;
*/

  CustomMenu({
    Key? key,
    /*
    required this.talePath,
    required this.taleName,
    required this.talePos,
    */
  }) : super(key: key);

  @override
  _CustomMenuState createState() => _CustomMenuState();
}

class _CustomMenuState extends State<CustomMenu> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
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
  }
}
