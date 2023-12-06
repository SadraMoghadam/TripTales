import 'package:flutter/material.dart';
import 'package:trip_tales/src/utils/validator.dart';
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

class MyTalesPage extends StatefulWidget {
  @override
  _MyTalesPage createState() => _MyTalesPage();
}

class _MyTalesPage extends State<MyTalesPage> {
  @override
  Widget build(BuildContext context) {
    DeviceInfo device = DeviceInfo();
    device.computeDeviceInfo(context);
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
            child: buildCards(),
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

  Widget buildCards() {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomTale(
            talePath: 'assets/images/createTale_background.jpg',
            taleName: '+ Create Tale',
            talePos: true,
          ),
          CustomTale(
            talePath: 'assets/images/tale_sample.jpg',
            taleName: 'Summer Holidays',
            talePos: false,
          ),
          CustomTale(
            talePath: 'assets/images/winter_tale.jpg',
            taleName: 'Winter holidays 2023',
            talePos: true,
          ),
          CustomTale(
            talePath: 'assets/images/london_tale.jpg',
            taleName: 'London vibes',
            talePos: false,
          ),
          CustomTale(
            talePath: 'assets/images/tale_sample.jpg',
            taleName: 'Summer holidays',
            talePos: true,
          ),
          CustomTale(
            talePath: 'assets/images/tale_sample.jpg',
            taleName: 'Summer holidays',
            talePos: false,
          ),
          CustomTale(
            talePath: 'assets/images/tale_sample.jpg',
            taleName: 'Summer holidays',
            talePos: true,
          ),
          CustomTale(
            talePath: 'assets/images/tale_sample.jpg',
            taleName: 'Summer holidays',
            talePos: false,
          ),
          CustomTale(
            talePath: 'assets/images/tale_sample.jpg',
            taleName: 'Summer holidays',
            talePos: true,
          ),
          CustomTale(
            talePath: 'assets/images/tale_sample.jpg',
            taleName: 'Summer holidays',
            talePos: false,
          ),
          // Spacer(flex: 1),
          CustomTale(
            talePath: 'assets/images/tale_sample.jpg',
            taleName: 'Summer holidays',
            talePos: true,
          ),
        ],
      ),
    );
  }

  Widget buildFooter() {
    return CustomMenu();
  }
}
