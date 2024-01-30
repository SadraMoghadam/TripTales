import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:trip_tales/src/screen/set_photo_screen.dart';
import 'package:trip_tales/src/utils/validator.dart';
import '../constants/color.dart';
import '../constants/error_messages.dart';
import '../constants/memory_card_type.dart';
import '../controllers/media_controller.dart';
import '../models/card_model.dart';
import '../services/card_service.dart';
import '../utils/app_manager.dart';
import '../utils/device_info.dart';
import '../utils/password_strength_indicator.dart';
import '../widgets/button.dart';
import '../widgets/text_field.dart';

class CreateVideoPage extends StatefulWidget {
  @override
  _CreateVideoPageState createState() => _CreateVideoPageState();
}

class _CreateVideoPageState extends State<CreateVideoPage> {
  final Validator _validator = Validator();
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  final MediaController mediaController = Get.put(MediaController());
  final AppManager _appManager = Get.put(AppManager());
  final CardService _cardService = Get.find<CardService>();

  // late final TextEditingController _passwordController;

  void _submit() async {
    final isValid = _formKey.currentState?.validate();
    if (isValid == null || !isValid) {
      return;
    }
    CardModel videoCardData = CardModel(
        // id: _appManager.getCurrentUser(),
        order: _appManager.getCardsNum(),
        type: MemoryCardType.video,
        transform: Matrix4.identity(),
        name: '${_nameController.text}.mp4');
    int result = await _cardService.addVideoCard(
        _appManager.getCurrentTale(), videoCardData, mediaController.getVideo()!);
    if (result == 200) {
      Timer(Duration(seconds: 2), () {
        _formKey.currentState?.save();
        Navigator.of(context).pop(true);
      });
    } else {
      ErrorController.showSnackBarError(ErrorController.createImage);
      return;
    }
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
        'Add new video',
        style: TextStyle(
            color: AppColors.main1, fontSize: 25, fontWeight: FontWeight.w700),
      )),
      insetPadding: EdgeInsets.all(10),
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
                      labelText: 'Video name',
                      hintText: 'Enter your video name',
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
                  child: SetPhotoScreen(isImage: false),
                ),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Center(
                    child: CustomButton(
                        height: 20,
                        width: 200,
                        text: "Submit",
                        textColor: Colors.white,
                        onPressed: () => _submit())),
              )
            ],
          ),
        ),
      ),
    );
  }
}
