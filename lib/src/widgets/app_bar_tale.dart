import 'package:flutter/material.dart';
import '../constants/color.dart';

class CustomAppBar extends StatelessWidget {
  final Widget bodyTale;
  final bool showIcon;
  final bool isScrollable;
  final String? navigationPath;

  const CustomAppBar({
    Key? key,
    required this.bodyTale,
    required this.showIcon,
    this.isScrollable = true,
    this.navigationPath = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: NestedScrollView(
        physics: isScrollable
            ? const AlwaysScrollableScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        // physics: const NeverScrollableScrollPhysics(),
        headerSliverBuilder: (context, isScrolled) => [
          SliverAppBar(
            // toolbarHeight: isScrollable ? 50.0 : 0,
            pinned: false,
            toolbarHeight: 60,
            backgroundColor: AppColors.main1,
            shadowColor: Colors.grey,
            centerTitle: true,
            // flexibleSpace: const FlexibleSpaceBar(
            //   title: Text(
            //     'Trip Tales',
            //     textAlign: TextAlign.center,
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontSize: 20,
            //     ),
            //   ),
            // ),
            title:const Text(
              'Trip Tales',
              textAlign: TextAlign.center,
              style: TextStyle(
                // letterSpacing: 5,
                color: Colors.white,
                fontSize: 43,
                fontWeight: FontWeight.w100,
                fontFamily: "Playball",
              ),
            ),

            // Container(
            //   alignment: Alignment.center,
            //   height: 60,
            //   margin: EdgeInsets.all(10),
            //   child:
            // ),

            leading: showIcon
                ? Builder(
                    builder: (context) => IconButton(
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // coverage:ignore-start
                        if (navigationPath! == '/pop') {
                          Navigator.maybePop(context);
                        } else if(navigationPath! != ''){
                          Navigator.of(context).pushReplacementNamed(navigationPath!);
                        } else {
                          Navigator.of(context).pushNamed(navigationPath!);
                        }
                        // coverage:ignore-end
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
}
