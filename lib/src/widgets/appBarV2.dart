/*
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trip_tales/src/utils/device_info.dart';
import '../constants/color.dart';
import '../widgets/menu_bar_tale.dart';

class CustomAppBar extends StatefulWidget {
  // final Widget body_tale;

  CustomAppBar({
    Key? key,
    // required this.body_tale,
  }) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return
        //AppBar(
        //  actions: [
        Scaffold(
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverAppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, '/loginPage'),
            ),
            backgroundColor: cmain1,
            automaticallyImplyLeading: true,
            expandedHeight: 30,
            floating: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: cmain2,
              ),
              /*
              title: Row(
                children: <Widget>[
                  const Center(
                    child: Text(
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
              //   ],
              */
            ),
          ),
          SliverToBoxAdapter(
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(height: 800, color: cmain1)))),
        ],
      ),
      //    ),
      //  ],
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
*/