import 'package:flutter/material.dart';
import 'package:trip_tales/src/widgets/app_bar_tale.dart';
import 'package:trip_tales/src/widgets/tale_card.dart';
import '../utils/device_info.dart';

class MyTalesPage extends StatefulWidget {
  @override
  _MyTalesPage createState() => _MyTalesPage();
}

class _MyTalesPage extends State<MyTalesPage> {
  @override
  Widget build(BuildContext context) {
    DeviceInfo device = DeviceInfo();
    device.computeDeviceInfo(context);
    return Scaffold(
      //debugShowCheckedModeBanner: false,
      body: CustomAppBar(
        bodyTale: buildBody(),
        showIcon: false,
      ),
    );
    //  );
  }

  Widget buildBody() {
    return Container(
      /*
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background_tale.jpg'),
              fit: BoxFit.cover,
              opacity: 0.3)),
              */
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            fit: FlexFit.tight,
            flex: 14,
            child: buildCards(),
          ),
          /*
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: buildFooter(),
          ),
          */
        ],
      ),
    );
  }

  Widget buildCards() {
    return SingleChildScrollView(
      child: Column(
        children: [
          /*
          CustomButton(
            text: '+ Create Tale',
            fontSize: 40,
            textColor: Colors.white,
            width: 280,
            height: 200,
            // onPressed: () => Navigator.of(context).pushNamed('/createTalePage'),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => CreateTalePage())),
          ),
          */
          CustomTale(
            talePath: 'assets/images/createTale_background.jpg',
            taleName: 'Create new Tale',
            talePos: true,
            index: 0,
            //taleOnPressed :
          ),
          CustomTale(
            talePath: 'assets/images/tale_sample.jpg',
            taleName: 'Summer Holidays',
            talePos: false,
            index: 1,
          ),
          CustomTale(
            talePath: 'assets/images/winter_tale.jpg',
            taleName: 'Winter holidays 2022',
            talePos: true,
            index: 2,
          ),
          CustomTale(
            talePath: 'assets/images/london_tale.jpg',
            taleName: 'London vibes',
            talePos: false,
            index: 3,
          ),
          CustomTale(
            talePath: 'assets/images/roadTrip_tale.jpg',
            taleName: 'RoadTrip 2021',
            talePos: true,
            index: 4,
          ),
          CustomTale(
            talePath: 'assets/images/china_tale.jpg',
            taleName: 'Shanghai',
            talePos: false,
            index: 5,
          ),
          CustomTale(
            talePath: 'assets/images/solo_tale.jpg',
            taleName: 'Backpack solo trip',
            talePos: true,
            index: 6,
          ),
        ],
      ),
    );
  }
}
