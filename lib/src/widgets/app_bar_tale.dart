import 'package:flutter/material.dart';
import '../constants/color.dart';

class CustomAppBar extends StatelessWidget {
  final Widget bodyTale;
  final bool showIcon;

  const CustomAppBar({
    Key? key,
    required this.bodyTale,
    required this.showIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) => [
          SliverAppBar(
            pinned: false,
            backgroundColor: cmain1,
            shadowColor: Colors.grey,
            centerTitle: true,
            title: const Text(
              'Trip Tales',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            leading: showIcon
                ? Builder(
                    builder: (context) => IconButton(
                      icon: const Icon(Icons.arrow_back_rounded),
                      onPressed: () {
                        Navigator.maybePop(context);
                      },
                    ),
                  )
                : null,
            /*
            actions: [
              if (showIcon) buildHeader(context), // Pass context here
            ],
            */
          ),
        ],
        body: bodyTale,
      ),
    );
  }
  /*
  Widget buildHeader(BuildContext context) {
    return IconButton(
      onPressed: () {
        // Add header's onPressed logic here
      },
      icon: const CircleAvatar(
        radius: 22.0,
        backgroundImage: AssetImage(
          'assets/images/profile_pic.png',
        ),
      ),
    );
  }
  */
}

















/*
class CustomAppBar extends StatefulWidget {
  Widget body_tale;
  String go_back_path;
  bool show_icon;

  CustomAppBar({
    Key? key,
    required this.body_tale,
    required this.go_back_path,
    required this.show_icon,
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
        headerSliverBuilder: (context, bool isScrolled) => [
          SliverAppBar(
            pinned: false,
            backgroundColor: cmain1,
            shadowColor: Colors.grey,
            centerTitle: true,
            title: Row(
              children: <Widget>[
                const Expanded(
                  child: Center(
                    child: Text(
                      'Trip Tales',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.show_icon,
                  child: buildHeader(),
                ),
              ],
            ),
            leading: widget.show_icon
                ? IconButton(
                    icon: const Icon(Icons.arrow_back_rounded),
                    onPressed: () {
                      Navigator.of(context).pop(); // Use Navigator.of(context)
                    },
                  )
                : null,
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



class CustomAppBar extends StatefulWidget {
  Widget body_tale;
  String go_back_path;
  bool show_icon;

  CustomAppBar({
    Key? key,
    required this.body_tale,
    required this.go_back_path,
    required this.show_icon,
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
        headerSliverBuilder: (context, bool isScrolled) => [
          SliverAppBar(
            pinned: false,
            backgroundColor: cmain1,
            shadowColor: Colors.grey,
            //automaticallyImplyLeading: true,
            centerTitle: true,
            title: Row(
              children: <Widget>[
                const Expanded(
                  child: Center(
                    child: Text(
                      'Trip Tales',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        //   fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.show_icon,
                  child: Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: buildHeader(),
                  ),
                ),
              ],
            ),

            leading: widget.show_icon
                ? IconButton(
                    icon: const Icon(Icons.arrow_back_rounded),
                    onPressed: () => Navigator.of(context).pop())
                : null,
            //onPressed: () => Navigator.of(context).pushNamed('/myTalesPage'),
            // onTap: (){ Navigator.of(context).pushNamed('medical-choose')};
            //  }
          ),
          //   ),
        ],
        body: widget.body_tale,
      ),

      //   ),
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