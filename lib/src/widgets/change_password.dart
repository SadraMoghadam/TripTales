import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:trip_tales/src/constants/error_messages.dart';
import 'package:trip_tales/src/constants/memory_card_type.dart';
import 'package:trip_tales/src/models/card_model.dart';
import 'package:trip_tales/src/screen/set_photo_screen.dart';
import 'package:trip_tales/src/services/auth_service.dart';
import 'package:trip_tales/src/services/card_service.dart';
import 'package:trip_tales/src/utils/app_manager.dart';
import 'package:trip_tales/src/utils/validator.dart';
import '../constants/color.dart';
import '../controllers/media_controller.dart';
import '../utils/device_info.dart';
import '../utils/password_strength_indicator.dart';
import '../widgets/button.dart';
import '../widgets/text_field.dart';

class ChangePasswordDialog extends StatefulWidget {
  const ChangePasswordDialog({
    super.key,
  });

  @override
  _ChangePasswordDialog createState() => _ChangePasswordDialog();
}

class _ChangePasswordDialog extends State<ChangePasswordDialog> {
  //coverage:ignore-start
  final AuthService _authService = Get.find<AuthService>();
  final AppManager _appManager = Get.put(AppManager());
  //coverage:ignore-end

  final Validator _validator = Validator();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasDigits = false;
  bool hasSpecialCharacters = false;
  bool hasMinLength = false;

  void checkPasswordStrength(String value) {
    setState(() {
      // Reset criteria
      hasUppercase = false;
      hasLowercase = false;
      hasDigits = false;
      hasSpecialCharacters = false;
      hasMinLength = false;

      // Check criteria for password strength
      hasUppercase = value.contains(RegExp(r'[A-Z]'));
      hasLowercase = value.contains(RegExp(r'[a-z]'));
      hasDigits = value.contains(RegExp(r'[0-9]'));
      hasSpecialCharacters = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
      hasMinLength = value.length >= 6;
    });
  }

  void onPasswordVisibilityPressed() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void onConfirmPasswordVisibilityPressed() {
    setState(() {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    });
  }

  @override
  void initState() {
    super.initState();
    // user = _authService.getUserById(_appManager.getCurrentUser());
    _passwordController = TextEditingController()
      ..addListener(() {
        checkPasswordStrength(_passwordController.text);
      });
    _confirmPasswordController = TextEditingController()..addListener(() {});
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() async {
    final isValid = _formKey.currentState?.validate();
    if (isValid == null || !isValid) {
      return;
    }
    bool result = await _authService.updatePassword(_passwordController.text);
    if (result) {
      Navigator.of(context).pop(true);
    } else {
      ErrorController.showSnackBarError(ErrorController.changePassword);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    DeviceInfo device = DeviceInfo();
    device.computeDeviceInfo(context);
    bool isTablet = device.isTablet;
    return AlertDialog(
      key: const Key('changePassAlertDialogKey'),
      title: const Text(
        'Change Password',
        style: TextStyle(
            color: AppColors.main1, fontSize: 25, fontWeight: FontWeight.w700),
      ),
      elevation: 10,
      shadowColor: Colors.grey,
      insetPadding: const EdgeInsets.all(10),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0))),
      content: SingleChildScrollView(
        child: Container(
          height: 300,
          width: 500,
          alignment: Alignment.center,
          child: buildChangePassBody(device),
        ),
      ),
      actions: [
        CustomButton(
            height: isTablet ? 45 : 40,
            width: isTablet ? 120 : 100,
            fontSize: isTablet ? 15 : 12,
            backgroundColor: AppColors.main2,
            text: "Change",
            textColor: Colors.white,
            onPressed: () => _submit()),
        CustomButton(
            height: isTablet ? 45 : 40,
            width: isTablet ? 120 : 100,
            fontSize: isTablet ? 15 : 12,
            backgroundColor: AppColors.main3,
            text: "Close",
            textColor: Colors.white,
            onPressed: () => Navigator.of(context).pop(false)),
      ],
    );
  }

  Widget buildChangePassBody(DeviceInfo device) {
    bool isTablet = device.isTablet;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: CustomTextField(
                isTablet: isTablet,
                key: const Key('passwordCustomTextFieldKey'),
                controller: _passwordController,
                labelText: 'Password',
                hintText: 'Enter your password',
                prefixIcon: Icons.password,
                isPassword: true,
                isPasswordVisible: _isPasswordVisible,
                onVisibilityPressed: onPasswordVisibilityPressed,
                obscureText: !_isPasswordVisible,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                validator: _validator.passwordValidator,
              ),
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: CustomTextField(
                isTablet: isTablet,
                key: const Key('confirmPasswordCustomTextFieldKey'),
                controller: _confirmPasswordController,
                labelText: 'Confirm Password',
                hintText: 'Enter your password again',
                prefixIcon: Icons.password,
                isPassword: true,
                isPasswordVisible: _isConfirmPasswordVisible,
                onVisibilityPressed: onConfirmPasswordVisibilityPressed,
                obscureText: !_isConfirmPasswordVisible,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                validator: (value) => _validator.confirmPasswordValidator(
                    value, _passwordController.text),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                children: [
                  const Text(
                    'Password Strength',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: AppColors.text2,
                    ),
                  ),
                  PasswordStrengthIndicator(
                    isTablet: isTablet,
                    hasUppercase: hasUppercase,
                    hasLowercase: hasLowercase,
                    hasDigits: hasDigits,
                    hasSpecialCharacters: hasSpecialCharacters,
                    hasMinLength: hasMinLength,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
