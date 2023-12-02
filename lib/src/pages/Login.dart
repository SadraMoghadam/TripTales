import 'package:flutter/material.dart';

import '../widgets/button.dart';
import '../widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
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
                  const Text('Welcome Back',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 25,
                        fontWeight: FontWeight.w900
                      ),
                  ),
                ],
              ),
            ),
            Flexible(
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
                      obscureText: true,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }
                        return null;
                      },
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                    )),
                Flexible(
                    fit: FlexFit.loose,
                    flex: 1,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/register');
                      },
                      child: const Text('Forgot Password?',
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
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/login');
                              })
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/register');
                        },
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
      ),
    );
  }
}
