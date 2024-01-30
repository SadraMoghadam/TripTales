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
    this.navigationPath = '/customMenu',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: NestedScrollView(
        physics: isScrollable ? const AlwaysScrollableScrollPhysics() : const NeverScrollableScrollPhysics(),
        // physics: const NeverScrollableScrollPhysics(),
        headerSliverBuilder: (context, isScrolled) => [
          SliverAppBar(
            // toolbarHeight: isScrollable ? 50.0 : 0,
            pinned: false,
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
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // Navigator.maybePop(context);
                        Navigator.of(context).pushNamed(navigationPath!);
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
