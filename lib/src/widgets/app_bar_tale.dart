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
            backgroundColor: AppColors.main1,
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
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                      ),
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
}
