import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:trip_tales/src/utils/validator.dart';
import '../constants/color.dart';
import '../controllers/auth_controller.dart';
import '../utils/device_info.dart';
import '../utils/password_strength_indicator.dart';
import '../widgets/button.dart';
import '../widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Validator _validator = Validator();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final AuthController authController = Get.find<AuthController>();

  bool _isPasswordVisible = false;
  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasDigits = false;
  bool hasSpecialCharacters = false;

  // Login methods: 1(with email and password), 2(with Gmail), 3(with Facebook)
  void _submit(int loginMethod) async {
    int result = 400;
    if (loginMethod == 1) {
      final isValid = _formKey.currentState?.validate();
      if (isValid == null || !isValid) {
        return;
      }
      result = await authController.signInWithEmailAndPassword(
        _emailController.text,
        _passwordController.text,
      );
    } else if (loginMethod == 2) {
      result = await authController.signInWithGoogle();
    }
    // else if(loginMethod == 3){
    //   result = await authController.signInWithFacebook();
    // }
    if (result == 200) {
      Navigator.pushReplacementNamed(context, '/customMenu');
      _formKey.currentState?.save();
    } else {
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
    bool isTablet = device.isTablet;
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
            height: device.height,
            width: device.width,
            alignment: Alignment.center,
            child: Form(
              key: _formKey,
              child: isTablet && isLandscape
                  ? Row(
                      // Use Row for landscape mode on tablet
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 4,
                          child: buildHeader(context),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 6, // Adjust flex values as needed
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const Flexible(
                                fit: FlexFit.tight,
                                flex: 1,
                                child: SizedBox(height: 50),
                              ),
                              Flexible(
                                fit: FlexFit.tight,
                                flex: 3,
                                child: buildBody(context),
                              ),
                              Flexible(
                                fit: FlexFit.tight,
                                flex: 2,
                                child: buildFooter(context),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Column(
                      // Use Column for portrait mode or non-tablet devices
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 4,
                          child: buildHeader(context),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 3,
                          child: buildBody(context),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 2,
                          child: buildFooter(context),
                        ),
                      ],
                    ),
            )),
      ),
    );
  }

/*
  @override
  Widget build(BuildContext context) {
    DeviceInfo device = DeviceInfo();
    device.computeDeviceInfo(context);
    bool isTablet = device.isTablet;
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
//    if (isTablet && isLandscape) {
//      return buildLandScape(context);
//    } else {
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 4,
                    child: buildHeader(context),
                  ),
                  //buildHeader(context),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 3,
                    child: buildBody(context),
                  ),
                  //buildBody(context),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 2,
                    child: buildFooter(context),
                  )
                  //buildFooter(context),
                ],
              ),
            )),
        //   ),
      ),
    );
  }

/*
  Widget buildLandScape(BuildContext context) {
    DeviceInfo device = DeviceInfo();
    device.computeDeviceInfo(context);
    bool isTablet = device.isTablet;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
            key: const Key('container1Key'),
            height: device.height,
            width: device.width,
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Flexible(
                  fit: FlexFit.tight,
                  flex: 10,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        // First Column for Logo and Text
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  'assets/images/TripTales_logo.png',
                                  height: isTablet ? 250 : 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Text(
                              'Welcome Back',
                              style: TextStyle(
                                color: AppColors.text1,
                                fontSize: isTablet ? 30 : 25,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                        Column(
                            //  mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              buildBody(),
                              buildFooter(),
                            ]),
                      ]),
                )
              ],
            )),
      ),
    );
  }
  */
*/
  Widget buildHeader(context) {
    DeviceInfo device = DeviceInfo();
    device.computeDeviceInfo(context);
    bool isTablet = device.isTablet;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'assets/images/TripTales_logo.png',
              height: isTablet ? 300 : 200,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(
          'Welcome Back',
          style: TextStyle(
              color: AppColors.text1,
              fontSize: isTablet ? 30 : 25,
              fontWeight: FontWeight.w900),
        ),
      ],
    );
  }

  Widget buildBody(context) {
    DeviceInfo device = DeviceInfo();
    device.computeDeviceInfo(context);
    bool isTablet = device.isTablet;
    return Column(
      children: [
        Flexible(
            fit: FlexFit.tight,
            flex: 3,
            child: CustomTextField(
              isTablet: isTablet,
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
              isTablet: isTablet,
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
              Text(
                key: const Key('passwordStrengthKey'),
                'Password Strength',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: isTablet ? 18.0 : 15.0,
                  color: AppColors.text2,
                ),
              ),
              PasswordStrengthIndicator(
                hasUppercase: hasUppercase,
                hasLowercase: hasLowercase,
                hasDigits: hasDigits,
                hasSpecialCharacters: hasSpecialCharacters,
                isTablet: isTablet,
              ),
              TextButton(
                onPressed: () {},
                child: Text('Forgot Password',
                    key: const Key('forgotPasswordKey'),
                    style: TextStyle(
                        fontSize: isTablet ? 15 : 10,
                        color: AppColors.text2,
                        decoration: TextDecoration.underline)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildAuthOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Image.asset(
            'assets/images/google_icon.png', // Replace with the path to your image
            height: 40,
            width: 40,
          ),
          onPressed: () => _submit(2),
        ),
        // IconButton(
        //   icon: Image.asset(
        //     'assets/images/fb_icon.png', // Replace with the path to your image
        //     height: 40,
        //     width: 40,
        //   ),
        //   onPressed: () => _submit(3),
        // ),
        // SignInButton(
        //   Buttons.Facebook,
        //   onPressed: () => _submit(2),
        // ),
        // ElevatedButton(
        //   onPressed: () async {
        //     int? result = await authController.signInWithGoogle();
        //     if(result == 200) {
        //       Navigator.pushReplacementNamed(context, '/customMenu');
        //       _formKey.currentState?.save();
        //     }
        //     else{
        //       print("Wrong credentials");
        //       return;
        //     }
        //   },
        //   child: Text("Login with Google"),
        // ),

        // ElevatedButton(
        //   onPressed: () async {
        //     int? result = await authController.signInWithFacebook();
        //     if(result == 200) {
        //       Navigator.pushReplacementNamed(context, '/customMenu');
        //       _formKey.currentState?.save();
        //     }
        //     else{
        //       print("Wrong credentials");
        //       return;
        //     }
        //   },
        //   child: Text("Login with Facebook"),
        // )
      ],
    );
  }

  Widget buildFooter(context) {
    DeviceInfo device = DeviceInfo();
    device.computeDeviceInfo(context);
    bool isTablet = device.isTablet;
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
                  height: isTablet ? 30 : 20,
                  width: isTablet ? 300 : 200,
                  fontSize: isTablet ? 20 : 18,
                  text: "Login",
                  textColor: Colors.white,
                  onPressed: () => _submit(1))
            ],
          ),
          buildAuthOptions(),
          TextButton(
            onPressed: () =>
                Navigator.pushReplacementNamed(context, '/registerPage'),
            child: Text(
              'Create Account',
              key: const Key('createAccountButtonKey'),
              style: TextStyle(
                  fontSize: isTablet ? 16 : 12,
                  color: AppColors.text2,
                  decoration: TextDecoration.underline),
            ),
          ),
        ]),
      ],
    );
  }
}
