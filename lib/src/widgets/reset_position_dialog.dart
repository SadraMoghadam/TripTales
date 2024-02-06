import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:trip_tales/src/constants/error_messages.dart';
import 'package:trip_tales/src/constants/memory_card_type.dart';
import 'package:trip_tales/src/controllers/card_controller.dart';
import 'package:trip_tales/src/models/card_model.dart';
import 'package:trip_tales/src/screen/set_photo_screen.dart';
import 'package:trip_tales/src/services/card_service.dart';
import 'package:trip_tales/src/utils/app_manager.dart';
import 'package:trip_tales/src/utils/validator.dart';
import '../constants/color.dart';
import '../controllers/media_controller.dart';
import '../utils/device_info.dart';
import '../widgets/button.dart';
import '../widgets/text_field.dart';

class ResetPositionDialog extends StatefulWidget {
  final String name;

  const ResetPositionDialog({super.key, required this.name});

  @override
  _ResetPositionDialog createState() => _ResetPositionDialog();
}

class _ResetPositionDialog extends State<ResetPositionDialog> {
  final CardService _cardService = Get.find<CardService>();
  final AppManager _appManager = Get.put(AppManager());

  void _submit() async {
    int result = await _cardService.updateCardTransform(_appManager.getCurrentTaleId(), widget.name, Matrix4.identity());
    if (result == 200) {
      Navigator.of(context).pop(true);
    } else {
      ErrorController.showSnackBarError(ErrorController.resetCardPosition);
      return;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // shadowColor: Colors.red,
      title: const Text(
        'Reset Card Position',
        style: TextStyle(
            color: AppColors.main1, fontSize: 25, fontWeight: FontWeight.w700),
      ),
      content: const Text(
        'Are you sure you want to reset the position of this card?',
        style: TextStyle(
            color: AppColors.text1, fontSize: 17, fontWeight: FontWeight.normal),
      ),
      actions: [
        CustomButton(
            height: 40,
            width: 100,
            fontSize: 12,
            padding: 10,
            backgroundColor: AppColors.main2,
            text: "reset",
            textColor: Colors.white,
            onPressed: () => _submit()),
        CustomButton(
            height: 40,
            width: 100,
            padding: 10,
            fontSize: 12,
            backgroundColor: AppColors.main3,
            text: "close",
            textColor: Colors.white,
            onPressed: () => Navigator.of(context).pop(false)),

      ],
    );
  }
}
