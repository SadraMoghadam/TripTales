import 'package:flutter/material.dart';

import '../widgets/button.dart';
import '../widgets/text_field.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 100, bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Text(
                  'Create your account for free',
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                      fontWeight: FontWeight.w900),
                ),
              ),
              Flexible(
                  fit: FlexFit.loose,
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: CustomTextField(
                        controller: _nameController,
                        labelText: 'Name',
                        hintText: 'Enter your name',
                        prefixIcon: Icons.person,
                        obscureText: false,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name is required';
                          }
                          return null;
                        },
                      ))),
              Flexible(
                  fit: FlexFit.loose,
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: CustomTextField(
                        controller: _surnameController,
                        labelText: 'Surname',
                        hintText: 'Enter your Surname',
                        prefixIcon: Icons.person,
                        obscureText: false,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Surname is required';
                          }
                          return null;
                        },
                      ))),
              Flexible(
                  fit: FlexFit.loose,
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: CustomTextField(
                        controller: _emailController,
                        labelText: 'Email',
                        hintText: 'Enter your username',
                        prefixIcon: Icons.email,
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                          return null;
                        },
                      ))),
              Flexible(
                  fit: FlexFit.loose,
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: CustomTextField(
                        controller: _birthDateController,
                        labelText: 'Date of birth',
                        hintText: 'Enter your Surname',
                        prefixIcon: Icons.person,
                        obscureText: false,
                        keyboardType: TextInputType.datetime,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Surname is required';
                          }
                          return null;
                        },
                      ))),
              Flexible(
                  fit: FlexFit.loose,
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
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
                      ))),
              Flexible(
                  fit: FlexFit.loose,
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: CustomTextField(
                        controller: _confirmPasswordController,
                        labelText: 'Confirm Password',
                        hintText: 'Enter your password again',
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
                      ))),
              Flexible(
                fit: FlexFit.tight,
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(20),

                  child:Column(children: [
                    OverflowBar(
                      overflowAlignment: OverflowBarAlignment.start,
                      alignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CustomButton(
                            height: 20,
                            width: 200,
                            text: "Create Account",
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, '/Register');
                            })
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/register');
                      },
                      child: const Text('Already have an account?',
                          style: TextStyle(
                              color: Colors.black87,
                              decoration: TextDecoration.underline)),
                    ),
                  ]),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
