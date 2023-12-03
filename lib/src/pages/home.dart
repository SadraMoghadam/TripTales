import 'package:flutter/material.dart';
import 'package:trip_tales/src/widgets/button.dart';

import '../utils/device_info.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    DeviceInfo device = DeviceInfo();
    device.computeDeviceInfo(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          height: device.height - 20,
          width: device.width - 20,
          alignment: Alignment.center,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Flexible(fit: FlexFit.loose, flex: 7, child: buildHome()),
              Flexible(
                  fit: FlexFit.tight, flex: 1, child: buildButtons(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHome() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 40.0,
                bottom: 170,
              ),
              child: Image.asset(
                'assets/images/TripTales_logo.png',
                height: 250.0,
                fit: BoxFit.cover,
              ),
            ),
            const Positioned(
              left: 2,
              bottom: 100,
              child: Text(
                'Live',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const Positioned(
              left: 2,
              // Adjust the value to move the text outside the box
              bottom: 50,
              child: Text(
                'Feel',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.redAccent,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const Positioned(
              left: 2,
              bottom: 0,
              child: Text(
                'Discover',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.orangeAccent,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget buildButtons(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(children: [
          OverflowBar(
            overflowAlignment: OverflowBarAlignment.start,
            alignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CustomButton(
                  text: "Login",
                  onPressed: () => Navigator.pushReplacementNamed(context, '/loginPage'))
            ],
          ),
          TextButton(
            onPressed: () => Navigator.pushReplacementNamed(context, '/registerPage'),
            child: const Text('Create Account',
                style: TextStyle(
                    color: Colors.black87,
                    decoration: TextDecoration.underline)),
          ),
        ]),
      ],
    );
  }
}
