import 'package:flutter/material.dart';
import 'package:trip_tales/src/screen/set_photo_screen.dart';
import 'package:trip_tales/src/utils/validator.dart';
import '../constants/color.dart';
import '../utils/device_info.dart';
import '../utils/password_strength_indicator.dart';
import '../widgets/button.dart';
import '../widgets/text_field.dart';

class CreateImagePage extends StatefulWidget {
  @override
  _CreateImagePageState createState() => _CreateImagePageState();
}

class _CreateImagePageState extends State<CreateImagePage> {
  final Validator _validator = Validator();
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;

  // late final TextEditingController _passwordController;

  void _submit() {
    final isValid = _formKey.currentState?.validate();
    // if (isValid == null || !isValid) {
    //   return;
    // }
    _formKey.currentState?.save();
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    _nameController = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DeviceInfo device = DeviceInfo();
    device.computeDeviceInfo(context);
    return AlertDialog(
      elevation: 10,
      shadowColor: Colors.grey,
      title: const Center(
          child: Text(
        'Add new image',
        style: TextStyle(
            color: AppColors.main1, fontSize: 25, fontWeight: FontWeight.w700),
      )),
      insetPadding: const EdgeInsets.all(10),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      content: buildBody(device),
      actions: <Widget>[
        CustomButton(
            height: 5,
            width: 30,
            fontSize: 12,
            backgroundColor: AppColors.main3,
            text: "close",
            textColor: Colors.white,
            onPressed: () => Navigator.of(context).pop())
      ],
    );
  }

  Widget buildBody(DeviceInfo device) {
    return SingleChildScrollView(
      child: Container(
        height: device.height - 240,
        width: device.width,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: Center(
                    child: CustomTextField(
                      controller: _nameController,
                      labelText: 'Image name',
                      hintText: 'Enter your image name',
                      prefixIcon: Icons.abc,
                      obscureText: false,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      validator: _validator.nameValidator,
                    ),
                  )),
              Flexible(
                flex: 11,
                fit: FlexFit.tight,
                child: Container(
                  height: 310,
                  child: SetPhotoScreen(isImage: true),
                ),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Center(
                    child: CustomButton(
                        height: 20,
                        width: 200,
                        text: "Delete",
                        textColor: Colors.white,
                        onPressed: () => Navigator.of(context).pop())),
              )
            ],
          ),
        ),
      ),
    );
  }
}
