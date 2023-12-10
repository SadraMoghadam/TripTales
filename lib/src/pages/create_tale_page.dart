import 'package:flutter/material.dart';
import 'package:trip_tales/src/screen/set_photo_screen.dart';
import 'package:trip_tales/src/widgets/canvas_card.dart';
import '../constants/color.dart';
import '../utils/device_info.dart';
import '../widgets/button.dart';
import '../widgets/text_field.dart';
import '../widgets/menu_bar_tale.dart';
import '../widgets/app_bar_tale.dart';

class CreateTalePage extends StatefulWidget {
  @override
  _CreateTalePage createState() => _CreateTalePage();
}

class _CreateTalePage extends State<CreateTalePage> {
  //final Validator _validator = Validator();
  late final TextEditingController _taleNameController;
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    final isValid = _formKey.currentState?.validate();
    if (isValid == null || !isValid) {
      return;
    }
    _formKey.currentState?.save();
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  void initState() {
    _taleNameController = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _taleNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DeviceInfo device = DeviceInfo();
    device.computeDeviceInfo(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CustomAppBar(
        body_tale: buildBody(),
      ),
    );
  }

  Widget buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Flexible(
          fit: FlexFit.tight,
          flex: 11,
          child: buildScreen(),
        ),
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: buildFooter(),
        ),
      ],
    );
  }

  Widget buildScreen() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          const SizedBox(
            height: 310,
            child: SetPhotoScreen(),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 60,
            child: CustomTextField(
              controller: _taleNameController,
              labelText: 'Tale Name',
              hintText: 'Enter your Tale Name',
              prefixIcon: Icons.abc,
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 305,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  '  Choose your canvas:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: cmain1,
                    fontSize: 20,
                  ),
                ),
                buildCanvasList(),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 50,
            child: CustomButton(
              fontSize: 30,
              padding: 2,
              onPressed: () => _submit,
              backgroundColor: cmain2,
              textColor: Colors.white,
              text: "Start Creating",
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget buildCanvasList() {
    return SizedBox(
      height: 280,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            CustomCanvas(
              talePath: 'assets/images/canvas1.jpg',
              taleName: 'Nostalgic',
            ),
            CustomCanvas(
              talePath: 'assets/images/canvas2.jpg',
              taleName: 'Village',
            ),
            CustomCanvas(
              talePath: 'assets/images/canvas3.jpg',
              taleName: 'Cities',
            ),
            CustomCanvas(
              talePath: 'assets/images/canvas4.jpg',
              taleName: 'Winter',
            ),
            CustomCanvas(
              talePath: 'assets/images/canvas5.jpg',
              taleName: 'Summer',
            ),
            CustomCanvas(
              talePath: 'assets/images/canvas6.jpg',
              taleName: 'Spring',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFooter() {
    return const CustomMenu();
  }
}
