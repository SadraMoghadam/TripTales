import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trip_tales/src/utils/device_info.dart';

import '../constants/color.dart';
import '../utils/password_strength_indicator.dart';
import '../utils/validator.dart';
import '../widgets/button.dart';
import '../widgets/text_field.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final Validator _validator = Validator();
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _surnameController;
  late final TextEditingController _emailController;
  late final TextEditingController _birthDateController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasDigits = false;
  bool hasSpecialCharacters = false;
  DateTime? _selectedDate;

  void _submit() {
    final isValid = _formKey.currentState?.validate();
    if (isValid == null || !isValid) {
      print("byeeee");
      return;
    }
    _formKey.currentState?.save();
    Navigator.pushReplacementNamed(context, '/loginPage');
  }

  void checkPasswordStrength(String value) {
    setState(() {
      // Reset criteria
      hasUppercase = false;
      hasLowercase = false;
      hasDigits = false;
      hasSpecialCharacters = false;

      // Check criteria for password strength
      hasUppercase = value.contains(RegExp(r'[A-Z]'));
      hasLowercase = value.contains(RegExp(r'[a-z]'));
      hasDigits = value.contains(RegExp(r'[0-9]'));
      hasSpecialCharacters = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
    _birthDateController.text = DateFormat('yyyy-MM-dd').format(_selectedDate!).toString();
  }

  @override
  void initState() {
    _nameController = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    _surnameController = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    _emailController = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    _birthDateController = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    _passwordController = TextEditingController()
      ..addListener(() {
        checkPasswordStrength(_passwordController.text);
        setState(() {});
      });
    _confirmPasswordController = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    _birthDateController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

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
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(fit: FlexFit.tight, flex: 1, child: buildHeader()),
                Flexible(fit: FlexFit.tight, flex: 11, child: buildBody()),
                Spacer(
                  flex: 1,
                ),
                Flexible(fit: FlexFit.tight, flex: 2, child: buildFooter())
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHeader() {
    return const Text(
      'Create your account for free',
      style: TextStyle(
          color: ctext1, fontSize: 20, fontWeight: FontWeight.w900),
    );
  }

  Widget buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: CustomTextField(
              controller: _nameController,
              labelText: 'Name',
              hintText: 'Enter your name',
              prefixIcon: Icons.person,
              obscureText: false,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              validator: _validator.nameValidator,
            )),
        Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: CustomTextField(
              controller: _surnameController,
              labelText: 'Surname',
              hintText: 'Enter your Surname',
              prefixIcon: Icons.person,
              obscureText: false,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              validator: _validator.nameValidator,
            )),
        Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: CustomTextField(
              controller: _emailController,
              labelText: 'Email',
              hintText: 'Enter your username',
              prefixIcon: Icons.email,
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: _validator.emailValidator,
            )),
        Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: CustomTextField(
              controller: _birthDateController,
              labelText: 'Date of birth',
              hintText: _selectedDate != null
                  ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
                  : 'Select date',
              readOnly: true,
              onTap: () => _selectDate(context),
              prefixIcon: Icons.date_range_sharp,
              obscureText: false,
              keyboardType: TextInputType.datetime,
              textInputAction: TextInputAction.next,
              validator: _validator.dateValidator,
            )),
        Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: CustomTextField(
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
            )),
        Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: CustomTextField(
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
            ),),
        Flexible(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              children: [
                const Text(
                  'Pasword Strength',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: ctext2,
                  ),
                ),
                PasswordStrengthIndicator(
                  hasUppercase: hasUppercase,
                  hasLowercase: hasLowercase,
                  hasDigits: hasDigits,
                  hasSpecialCharacters: hasSpecialCharacters,
                ),
              ],
            ))
      ],
    );
  }

  Widget buildFooter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OverflowBar(
          overflowAlignment: OverflowBarAlignment.start,
          alignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CustomButton(
              text: "Create Account",
              onPressed: _submit,
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/loginPage');
          },
          child: const Text('Already have an account?',
              style: TextStyle(
                  color: ctext2, decoration: TextDecoration.underline)),
        ),
      ],
    );
  }
}
