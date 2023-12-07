import 'package:flutter/material.dart';
import 'package:trip_tales/src/utils/validator.dart';
import 'package:trip_tales/src/widgets/button_slider.dart';
import 'package:trip_tales/src/widgets/tale_card.dart';
import '../constants/color.dart';
import '../utils/device_info.dart';
import '../utils/password_strength_indicator.dart';
import '../utils/validator.dart';
import '../widgets/button.dart';
import '../widgets/text_field.dart';
import '../widgets/tale_card.dart';
import '../widgets/menu_bar_tale.dart';
import '../widgets/app_bar_tale.dart';

class TalePage extends StatelessWidget {
  const TalePage({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CustomAppBar(
          body_tale: buildBody(),
        ));
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
            child: buildAddMemory(),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: buildFooter(),
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

  Widget buildFooter() {
    return CustomMenu();
  }
}


