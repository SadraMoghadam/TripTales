import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:trip_tales/src/constants/error_messages.dart';
import 'package:trip_tales/src/controllers/auth_controller.dart';
import 'package:trip_tales/src/services/auth_service.dart';
import 'package:trip_tales/src/services/card_service.dart';
import 'package:trip_tales/src/utils/app_manager.dart';
import '../constants/color.dart';
import '../widgets/button.dart';

class DeleteAccountDialog extends StatefulWidget {

  const DeleteAccountDialog({super.key});

  @override
  _DeleteAccountDialog createState() => _DeleteAccountDialog();
}

class _DeleteAccountDialog extends State<DeleteAccountDialog> {
  final AuthController _authController = Get.find<AuthController>();
  final AppManager _appManager = Get.put(AppManager());

  void _submit() async {
    bool result = await _authController.deleteUser(_appManager.getCurrentUser());
    if (result) {
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
      title: const Text(
        'Delete Account',
        style: TextStyle(
            color: AppColors.main1, fontSize: 25, fontWeight: FontWeight.w700),
      ),
      content: const Text(
        'Are you sure you want to delete this account?',
        style: TextStyle(
            color: AppColors.text1, fontSize: 17, fontWeight: FontWeight.normal),
      ),
      actions: [
        CustomButton(
            height: 5,
            width: 20,
            fontSize: 12,
            padding: 10,
            backgroundColor: AppColors.main2,
            text: "Delete",
            textColor: Colors.white,
            onPressed: () => _submit()),
        CustomButton(
            height: 5,
            width: 20,
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
