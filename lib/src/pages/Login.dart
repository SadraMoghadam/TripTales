import 'package:flutter/material.dart';

import '../widgets/button.dart';
import '../widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                  const Text('Welcome Back',
                      style: TextStyle(
                        color: Colors.black38,
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
                    flex: 1,
                    child: CustomTextField(
                      controller: _usernameController,
                      labelText: 'username',
                      hintText: 'Enter your username',
                      prefixIcon: Icons.person,
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
                    fit: FlexFit.tight,
                    flex: 1,
                    child: CustomTextField(
                      controller: _passwordController,
                      labelText: 'password',
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
                              width: 140,
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
