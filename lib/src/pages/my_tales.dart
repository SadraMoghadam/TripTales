import 'package:flutter/material.dart';
import 'package:trip_tales/src/pages/create_tale_page.dart';
import 'package:trip_tales/src/widgets/app_bar_tale.dart';
import 'package:trip_tales/src/widgets/button.dart';
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
    return Column(
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
            index: 0,
            //taleOnPressed :
          ),
          for (int i = 0; i < taleNum; i++)
            CustomTale(
              talePath: 'assets/images/tale_sample.jpg',
              taleName: 'Summer Holidays',
              index: i + 1,
            ),
        ],
      ),
    );
  }
}
