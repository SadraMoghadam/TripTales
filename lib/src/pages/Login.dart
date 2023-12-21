import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:trip_tales/src/utils/validator.dart';
import '../constants/color.dart';
import '../controllers/auth_controller.dart';
import '../utils/device_info.dart';
import '../utils/password_strength_indicator.dart';
import '../utils/validator.dart';
import '../widgets/button.dart';
import '../widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Validator _validator = Validator();
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final AuthController authController = Get.find<AuthController>();


  bool _isPasswordVisible = false;
  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasDigits = false;
  bool hasSpecialCharacters = false;

  void _submit() async {
    final isValid = _formKey.currentState?.validate();
    if (isValid == null || !isValid) {
      return;
    }
    int result = await authController.signInWithEmailAndPassword(
      _emailController.text,
      _passwordController.text,
    );
    if(result == 200) {
      Navigator.pushReplacementNamed(context, '/customMenu');
      _formKey.currentState?.save();
    }
    else{
      print("Wrong credentials");
      return;
    }
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

  void onVisibilityPressed() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  void initState() {
    _emailController = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    _passwordController = TextEditingController()
      ..addListener(() {
        checkPasswordStrength(_passwordController.text);
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DeviceInfo device = DeviceInfo();
    device.computeDeviceInfo(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
          child: Container(
        height: device.height,
        width: device.width,
        alignment: Alignment.center,
        child: Form(
              key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              flex: 4,
              child: buildHeader(),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 3,
              child: buildBody(),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: buildFooter(),
            ),
          ],
        ),
      )),
      //   ),
    ),);
  }

  Widget buildHeader() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'assets/images/TripTales_logo.png',
              height: 200.0,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const Text(
          'Welcome Back',
          style: TextStyle(
              color: AppColors.text1,
              fontSize: 25,
              fontWeight: FontWeight.w900),
        ),
      ],
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        Flexible(
            fit: FlexFit.tight,
            flex: 3,
            child: CustomTextField(
              key: const Key('emailCustomTextField'),
              controller: _emailController,
              labelText: 'Email',
              hintText: 'Enter your email',
              prefixIcon: Icons.email,
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: _validator.emailValidator,
            )),
        Flexible(
            fit: FlexFit.tight,
            flex: 3,
            child: CustomTextField(
              key: const Key('passwordCustomTextField'),
              controller: _passwordController,
              labelText: 'Password',
              hintText: 'Enter your password',
              prefixIcon: Icons.password,
              isPassword: true,
              isPasswordVisible: _isPasswordVisible,
              onVisibilityPressed: onVisibilityPressed,
              obscureText: !_isPasswordVisible,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.next,
              validator: _validator.passwordValidator,
            )),
        Flexible(
          fit: FlexFit.tight,
          flex: 4,
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              const Text(
                key: Key('passwordStrengthKey'),
                'Pasword Strength',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: AppColors.text2,
                ),
              ),
              PasswordStrengthIndicator(
                hasUppercase: hasUppercase,
                hasLowercase: hasLowercase,
                hasDigits: hasDigits,
                hasSpecialCharacters: hasSpecialCharacters,
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Forgot Password',
                    key: Key('forgotPasswordKey'),
                    style: TextStyle(
                        color: AppColors.text2,
                        decoration: TextDecoration.underline)),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget buildFooter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(children: [
          OverflowBar(
            overflowAlignment: OverflowBarAlignment.start,
            alignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CustomButton(
                  key: const Key('loginButtonKey'),
                  height: 20,
                  width: 200,
                  text: "Login",
                  textColor: Colors.white,
                  onPressed: _submit)
            ],
          ),
          TextButton(
            onPressed: () =>
                Navigator.pushReplacementNamed(context, '/registerPage'),
            child: const Text(
              'Create Account',
              key: Key('createAccountButtonKey'),
              style: TextStyle(
                  color: AppColors.text2, decoration: TextDecoration.underline),
            ),
          ),
        ]),
      ],
    );
  }
}
