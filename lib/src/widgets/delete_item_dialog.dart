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
import '../services/tale_service.dart';
import '../utils/device_info.dart';
import '../widgets/button.dart';
import '../widgets/text_field.dart';

class DeleteItemDialog extends StatefulWidget {
  final String name;
  final bool isTale;

  const DeleteItemDialog({super.key, required this.name, this.isTale = false});

  @override
  _DeleteItemDialogState createState() => _DeleteItemDialogState();
}

class _DeleteItemDialogState extends State<DeleteItemDialog> {
  final CardService _cardService = Get.find<CardService>();
  final AppManager _appManager = Get.put(AppManager());
  final TaleService _taleService = Get.find<TaleService>();

  void _submit() async {
    int result;
    if(widget.isTale){
      String taleId = await _taleService.getTaleId(widget.name);
      result = await _taleService.deleteTaleById(taleId);
    }
    else{
      String taleId = _appManager.getCurrentTaleId();
      result = await _cardService.deleteCardByName(taleId, widget.name);
      _appManager.setCurrentTaleLocations(await _taleService.getTaleLocations(taleId));
    }
    if (result == 200) {
      Navigator.of(context).pop(true);
    } else {
      ErrorController.showSnackBarError(ErrorController.deleteCard);
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
      title: Text(
        widget.isTale ? 'Delete Tale' : 'Delete Card',
        style: const TextStyle(
            color: AppColors.main1, fontSize: 25, fontWeight: FontWeight.w700),
      ),
      content: Text(
        widget.isTale ? 'Are you sure you want to delete this tale?' : 'Are you sure you want to delete this card?',
        style: const TextStyle(
            color: AppColors.text1, fontSize: 17, fontWeight: FontWeight.normal),
      ),
      actions: [
        CustomButton(
            height: 40,
            width: 100,
            fontSize: 12,
            backgroundColor: AppColors.main2,
            text: "Delete",
            textColor: Colors.white,
            onPressed: () => _submit()),
        CustomButton(
            height: 40,
            width: 100,
            fontSize: 12,
            backgroundColor: AppColors.main3,
            text: "close",
            textColor: Colors.white,
            onPressed: () => Navigator.of(context).pop(false)),

      ],
    );
  }
}
