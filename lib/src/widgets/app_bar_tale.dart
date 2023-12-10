import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trip_tales/src/utils/device_info.dart';
import '../constants/color.dart';
import '../widgets/menu_bar_tale.dart';

class CustomAppBar extends StatefulWidget {
  final Widget body_tale;

  CustomAppBar({
    Key? key,
    required this.body_tale,
  }) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            pinned: false,
            backgroundColor: cmain1,
            automaticallyImplyLeading: true,
            title: Row(
              children: <Widget>[
                // ignore: prefer_const_constructors
                Center(
                  child: const Text(
                    'Trip Tales',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      //      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: buildHeader(),
                ),
              ],
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, '/loginPage'),
            ),
          ),
        ],
        body: widget.body_tale,
      ),
    );
  }

  Widget buildHeader() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        CircleAvatar(
          radius: 22.0,
          backgroundImage: AssetImage(
            'assets/images/profile_pic.png',
          ),
        ),
      ],
    );
  }
}
