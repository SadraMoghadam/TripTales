import 'package:flutter/material.dart';
import 'package:trip_tales/src/widgets/button.dart';
import '../constants/color.dart';
import '../utils/device_info.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    DeviceInfo device = DeviceInfo();
    device.computeDeviceInfo(context);
    bool isTablet = device.isTablet;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          key: const Key('container1Key'),
          height: device.height,
          width: device.width,
          alignment: Alignment.center,
          child: buildBody(context),
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    DeviceInfo device = DeviceInfo();
    device.computeDeviceInfo(context);
    bool isTablet = device.isTablet;
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Column(
      children: <Widget>[
        Flexible(
            fit: FlexFit.tight,
            flex: 7,
            child: isTablet && isLandscape
                ? buildHomeLandScape(context)
                //coverage:ignore-line
                : buildHome(context)),
        Flexible(fit: FlexFit.tight, flex: 2, child: buildButtons(context)),
      ],
    );
  }

  Widget buildHome(context) {
    DeviceInfo device = DeviceInfo();
    device.computeDeviceInfo(context);
    bool isTablet = device.isTablet;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 50,
                bottom: 170,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  key: const Key('logoKey'),
                  'assets/images/TripTales_logo.png',
                  height: isTablet ? 250.0 : 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              left: 2,
              bottom: 100,
              child: Text(
                'Live',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: isTablet ? 50 : 40,
                  color: AppColors.main1,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Positioned(
              left: 2,
              // Adjust the value to move the text outside the box
              bottom: 50,
              child: Text(
                'Feel',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: isTablet ? 50 : 40,
                  color: AppColors.main3,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Positioned(
              left: 2,
              bottom: 0,
              child: Text(
                'Discover',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: isTablet ? 50 : 40,
                  color: AppColors.main2,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget buildHomeLandScape(context) {
    DeviceInfo device = DeviceInfo();
    device.computeDeviceInfo(context);
    bool isTablet = device.isTablet;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Logo
        Padding(
            padding: const EdgeInsets.only(
                right: 16.0), // Adjust the padding as needed
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                'assets/images/TripTales_logo.png',
                height: isTablet ? 300.0 : 200,
                fit: BoxFit.cover,
              ),
            )),
        const SizedBox(height: 20),
        // Texts
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Live',
              style: TextStyle(
                fontSize: isTablet ? 50 : 40,
                color: AppColors.main1,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'Feel',
              style: TextStyle(
                fontSize: isTablet ? 50 : 40,
                color: AppColors.main3,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'Discover',
              style: TextStyle(
                fontSize: isTablet ? 50 : 40,
                color: AppColors.main2,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildButtons(BuildContext context) {
    DeviceInfo device = DeviceInfo();
    device.computeDeviceInfo(context);
    bool isTablet = device.isTablet;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(children: [
          OverflowBar(
            overflowAlignment: OverflowBarAlignment.start,
            alignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CustomButton(
                  height: isTablet ? 30 : 20,
                  width: isTablet ? 300 : 200,
                  fontSize: isTablet ? 20 : 18,
                  key: const Key('loginCustomButtonKey'),
                  textColor: Colors.white,
                  text: "Login",
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/loginPage'))
            ],
          ),
          TextButton(
            onPressed: () =>
                Navigator.pushReplacementNamed(context, '/registerPage'),
            child: Text('Create Account',
                key: const Key('createAccountCustomButtonKey'),
                style: TextStyle(
                    fontSize: isTablet ? 15 : 12,
                    color: Colors.black87,
                    decoration: TextDecoration.underline)),
          ),
        ]),
      ],
    );
  }
}
