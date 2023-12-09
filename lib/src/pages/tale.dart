import 'package:flutter/material.dart';
import 'package:trip_tales/src/widgets/app_bar_tale.dart';
import 'package:trip_tales/src/widgets/button_slider.dart';
import 'package:trip_tales/src/widgets/container_movement_handler.dart';
import '../constants/color.dart';
import '../widgets/menu_bar_tale.dart';

class TalePage extends StatelessWidget {
  const TalePage({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CustomAppBar(
          body_tale: buildBody(),
          isPinned: true,
        )
    );
  }

  Widget buildBody() {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background_tale.jpg'),
              fit: BoxFit.cover,
              opacity: 0.3)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            fit: FlexFit.tight,
            flex: 14,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: ContainerMovementHandler(),
                ),
                buildAddMemory(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMemories()
  {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildAddMemory()
        ],
      ),
    );
  }

  Widget buildAddMemory()
  {
    return ButtonSlider();
  }
}



