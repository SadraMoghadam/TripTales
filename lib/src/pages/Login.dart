import 'package:flutter/material.dart';
import 'package:trip_tales/src/utils/validator.dart';


import '../utils/password_strength_indicator.dart';
import '../utils/validator.dart';
import '../widgets/button.dart';
import '../widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Validator _validator = new Validator();
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasDigits = false;
  bool hasSpecialCharacters = false;

  void _submit() {
    final isValid = _formKey.currentState?.validate();
    if (isValid == null || !isValid) {
      print("byeeee");
      return;
    }
    print("hiiii");
    _formKey.currentState?.save();
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
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Flexible(
                fit: FlexFit.tight,
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Image.asset(
                        'assets/images/TripTales_logo.png',
                        height: 200.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Text(
                      'Welcome Back',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 25,
                          fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 2,
                  child: Column(
                    children: [
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 2,
                          child: CustomTextField(
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
                          flex: 2,
                          child: CustomTextField(
                            controller: _passwordController,
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            prefixIcon: Icons.password,
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.next,
                            validator: _validator.passwordValidator,
                          )),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                          child: PasswordStrengthIndicator(
                            hasUppercase: hasUppercase,
                            hasLowercase: hasLowercase,
                            hasDigits: hasDigits,
                            hasSpecialCharacters: hasSpecialCharacters,
                          ),
                      ),
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/register');
                            },
                            child: const Text('Forgot Password',
                                style: TextStyle(
                                    color: Colors.black87,
                                    decoration: TextDecoration.underline)),
                          )),
                    ],
                  )),
              Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(children: [
                        OverflowBar(
                          overflowAlignment: OverflowBarAlignment.start,
                          alignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            CustomButton(
                                height: 20,
                                width: 200,
                                text: "Login",
                                onPressed: _submit
                            )
                          ],
                        ),
                        TextButton(
                          onPressed: _submit,
                          child: const Text('Create Account',
                              style: TextStyle(
                                  color: Colors.black87,
                                  decoration: TextDecoration.underline)),
                        ),
                      ]),
                    ],
                  )),
            ],
          ),
        )

      ),
    );
  }
}
