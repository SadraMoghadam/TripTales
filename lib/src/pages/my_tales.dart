import 'package:flutter/material.dart';
import 'package:trip_tales/src/utils/validator.dart';
import 'package:trip_tales/src/widgets/tale.dart';
import '../constants/color.dart';
import '../utils/device_info.dart';
import '../utils/password_strength_indicator.dart';
import '../utils/validator.dart';
import '../widgets/button.dart';
import '../widgets/text_field.dart';
import '../widgets/tale.dart';

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
      appBar: AppBar(
          backgroundColor: cmain1,
          bottomOpacity: 0.5,
          automaticallyImplyLeading: true,
          title: Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: buildHeader(),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          )),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Container(
        alignment: Alignment.topLeft,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background_tale.jpg'),
                fit: BoxFit.cover,
                opacity: 0.3)),
        //  height: device.height - 10,
        //  width: device.width - 10,
        //padding: EdgeInsets.all(10),
        //margin: EdgeInsets.all(10),
        //  key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: buildHeader(),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 10,
              child: buildBody(),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: buildFooter(),
            ),
          ],
        ),
      )),
    );
  }

//header of the page => go back, Your name , profile picture
  Widget buildHeader() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(
          'Your Name',
          style: TextStyle(
              color: ctext1, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        Flexible(
          flex: 1,
          child: CircleAvatar(
              radius: 50.0,
              backgroundImage: AssetImage(
                'assets/images/profile_pic.png',
              )),
        ),
      ],
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTale(
            imagePath: 'assets/images/tale_sample.jpg',
            text: 'Summer holidays',
          ),
          CustomTale(
            imagePath: 'assets/images/tale_sample.jpg',
            text: 'Summer holidays',
          ),
          CustomTale(
            imagePath: 'assets/images/tale_sample.jpg',
            text: 'Summer holidays',
          ),
          CustomTale(
            imagePath: 'assets/images/tale_sample.jpg',
            text: 'Summer holidays',
          ),
          CustomTale(
            imagePath: 'assets/images/tale_sample.jpg',
            text: 'Summer holidays',
          ),
          CustomTale(
            imagePath: 'assets/images/tale_sample.jpg',
            text: 'Summer holidays',
          ),
          CustomTale(
            imagePath: 'assets/images/tale_sample.jpg',
            text: 'Summer holidays',
          ),
          CustomTale(
            imagePath: 'assets/images/tale_sample.jpg',
            text: 'Summer holidays',
          ),
          CustomTale(
            imagePath: 'assets/images/tale_sample.jpg',
            text: 'Summer holidays',
          ),
          CustomTale(
            imagePath: 'assets/images/tale_sample.jpg',
            text: 'Summer holidays',
          ),
          CustomTale(
            imagePath: 'assets/images/tale_sample.jpg',
            text: 'Summer holidays',
          ),
          // Flexible(
          //     fit: FlexFit.tight,
          //     flex: 3,
          //     child: CustomTale(
          //       imagePath: 'assets/images/tale_sample.jpg',
          //       text: 'Summer holidays',
          //     )),
          // Spacer(flex: 1),
          // Flexible(
          //     fit: FlexFit.tight,
          //     flex: 3,
          //     child: CustomTale(
          //       imagePath: 'assets/images/TripTales_logo.png',
          //       text: 'Summer holidays',
          //     )),
          // Spacer(flex: 1),
          // Flexible(
          //     fit: FlexFit.tight,
          //     flex: 3,
          //     child: CustomTale(
          //       imagePath: 'assets/images/tale_sample.jpg',
          //       text: 'Summer holidays',
          //     )),
          // Flexible(
          //     fit: FlexFit.tight,
          //     flex: 5,
          //     child: CustomTale(
          //       imagePath: 'assets/images/tale_sample.jpg',
          //       text: 'Summer holidays',
          //     )),
          // Flexible(
          //     fit: FlexFit.tight,
          //     flex: 5,
          //     child: CustomTale(
          //       imagePath: 'assets/images/tale_sample.jpg',
          //       text: 'Summer holidays',
          //     )),
          // Flexible(
          //     fit: FlexFit.tight,
          //     flex: 5,
          //     child: CustomTale(
          //       imagePath: 'assets/images/tale_sample.jpg',
          //       text: 'Summer holidays',
          //     )),
          // Flexible(
          //     fit: FlexFit.tight,
          //     flex: 5,
          //     child: CustomTale(
          //       imagePath: 'assets/images/tale_sample.jpg',
          //       text: 'Summer holidays',
          //     )),
        ],
      ),
    );
  }

  Widget buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
            child: Text(
          'Your Name',
          style: TextStyle(
              color: ctext1, fontSize: 18, fontWeight: FontWeight.w500),
        )),
        Spacer(),
        Container(
            child: Text(
          'ADD',
          style: TextStyle(
              color: ctext1, fontSize: 18, fontWeight: FontWeight.w500),
        )),
        Spacer(),
        Container(
            child: Text(
          'Your Name',
          style: TextStyle(
              color: ctext1, fontSize: 18, fontWeight: FontWeight.w500),
        )),
      ],
    );
  }
}
