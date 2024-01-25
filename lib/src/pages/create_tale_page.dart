import 'package:flutter/material.dart';
import 'package:trip_tales/src/screen/set_photo_screen.dart';
import 'package:trip_tales/src/widgets/canvas_card.dart';
import '../constants/color.dart';
import '../utils/device_info.dart';
import '../widgets/button.dart';
import '../widgets/text_field.dart';
import '../widgets/app_bar_tale.dart';

class CreateTalePage extends StatefulWidget {
  @override
  _CreateTalePage createState() => _CreateTalePage();
}

class _CreateTalePage extends State<CreateTalePage> {
  late final TextEditingController _taleNameController;
  final _formKey = GlobalKey<FormState>();
  int selectedIndex = -1;

  static const backgroundNum = 6;
  static const backgroundPaths = ['assets/images/canvas1.jpg', 'assets/images/canvas2.jpg', 'assets/images/canvas3.jpg', 'assets/images/canvas4.jpg', 'assets/images/canvas5.jpg', 'assets/images/canvas6.jpg'];
  static const backgroundNames = ['Nostalgic', 'Village', 'Cities', 'Winter', 'Summer', 'Spring'];

  void _submit() {
    final isValid = _formKey.currentState?.validate();
    if (isValid == null || !isValid) {
      return;
    }
    _formKey.currentState?.save();
    Navigator.of(context).pushNamed('/talePage');
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
    return Scaffold(
      body: CustomAppBar(
        bodyTale: buildBody(),
        showIcon: true,
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
      ],
    );
  }

  Widget buildScreen() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 320,
            child: SetPhotoScreen(),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 60,
            width: 330,
            child: CustomTextField(
              key: const Key('taleNameCustomTextFieldKey'),
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
          //SizedBox(
          // height: 305,
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  '  Choose your canvas:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.main1,
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
              key: const Key('startCreatingCustomButtonKey'),
              fontSize: 18,
              padding: 2,
              backgroundColor: AppColors.main2,
              textColor: Colors.white,
              text: "Start Creating",
              onPressed: () => _submit(),
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
            for (int i = 0; i < backgroundNum; i++)
              CustomCanvas(
                talePath: backgroundPaths[i],
                taleName: backgroundNames[i],
                onTap: () {
                  setState(() {
                    selectedIndex = i; // Mark this item as selected
                  });
                },
                isSelected: selectedIndex == i, // Check if this item is selected
              ),
          ],
        ),
      ),
    );
  }
}
