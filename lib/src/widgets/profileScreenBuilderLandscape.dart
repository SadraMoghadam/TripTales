import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:trip_tales/src/models/user_model.dart';
import 'package:trip_tales/src/utils/device_info.dart';
import 'package:trip_tales/src/widgets/text_field.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:trip_tales/src/models/user_model.dart';
import 'package:trip_tales/src/screen/set_photo_screen.dart';
import 'package:trip_tales/src/services/auth_service.dart';
import 'package:trip_tales/src/utils/validator.dart';
import 'package:trip_tales/src/widgets/app_bar_tale.dart';
import 'package:trip_tales/src/widgets/change_password.dart';
import 'package:trip_tales/src/widgets/delete_user_dialog.dart';
import 'package:trip_tales/src/widgets/dialog_popup.dart';
import 'package:trip_tales/src/widgets/menu_bar_tale.dart';
import '../constants/color.dart';
import '../constants/error_messages.dart';
import '../controllers/media_controller.dart';
import '../utils/app_manager.dart';
import '../utils/device_info.dart';
import '../utils/validator.dart';
import '../widgets/button.dart';
import '../widgets/dropdown_button.dart';
import '../widgets/text_field.dart';
import '../utils/validator.dart';


/*
Widget buildScreenLandScape(BuildContext context, Future<UserModel?> user) {
  final AuthService _authService = Get.find<AuthService>();
  final MediaController mediaController = Get.put(MediaController());
  late Future<UserModel?> user;
  final AppManager _appManager = Get.put(AppManager());
  final Validator _validator = Validator();
  final _formKey = GlobalKey<FormState>();
  Key _futureBuilderKey = UniqueKey();
  late final TextEditingController _nameController;
  late final TextEditingController _surnameController;
  late final TextEditingController _emailController;
  late final TextEditingController _birthDateController;
  late final TextEditingController _phoneNumberController;
  late final TextEditingController _bioController;
  late final TextEditingController _passwordController;

  ImageProvider<Object>? _profileImage;
  late final AnimationController _controller;

  bool readOnlyTextField = true;
  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasDigits = false;
  bool hasSpecialCharacters = false;
  DateTime? _selectedDate;
  String _selectedGender = '--Choose Your Gender--';
  List<String> genderOptions = const [
    '--Choose Your Gender--',
    'Male',
    'Female',
    'Other'
  ];

  DeviceInfo device = DeviceInfo();
  device.computeDeviceInfo(context);
  bool isTablet = device.isTablet;
  return FutureBuilder<UserModel?>(
      key: _futureBuilderKey,
      future: user,
      builder: (BuildContext context, AsyncSnapshot<UserModel?> snapshot) {
        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return CircularProgressIndicator();
        // }
        if (snapshot.hasData) {
          UserModel userData = snapshot.data!;
          print(userData.email);
          print(userData.gender);
          _nameController.text = userData.name ?? '';
          _surnameController.text = userData.surname ?? '';
          _emailController.text = userData.email ?? '';
          _birthDateController.text = userData.birthDate ?? '';
          _selectedGender = userData.gender == ''
              ? '--Choose Your Gender--'
              : userData.gender;
          _bioController.text = userData.bio ?? '';
          _phoneNumberController.text = userData.phoneNumber ?? '';
          if (userData.profileImage != '') {
            print(userData.profileImage);
            _profileImage = NetworkImage(userData.profileImage);
          } else {
            _profileImage = const AssetImage('assets/images/profile_pic.png');
          }

          return Row(children: [
            Padding(
              padding: const EdgeInsets.all(70.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [buildHeader(context)],
              ),
            ),
            Center(
                child: SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            //crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: CustomTextField(
                                                    isTablet: isTablet,
                                                    key: const Key(
                                                        'nameCustomTextFieldKey'),
                                                    readOnly: readOnlyTextField,
                                                    controller: _nameController,
                                                    labelText: 'Name',
                                                    hintText: 'Enter your Name',
                                                    prefixIcon:
                                                        Icons.abc_rounded,
                                                    obscureText: false,
                                                    keyboardType:
                                                        TextInputType.name,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    validator: _validator
                                                        .nameValidator,
                                                  )),
                                              const SizedBox(height: 20),
                                              Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: CustomTextField(
                                                    isTablet: isTablet,
                                                    key: const Key(
                                                        'surnameCustomTextFieldKey'),
                                                    readOnly: readOnlyTextField,
                                                    controller:
                                                        _surnameController,
                                                    labelText: 'Surname',
                                                    hintText:
                                                        'Enter your Surname',
                                                    prefixIcon:
                                                        Icons.abc_rounded,
                                                    obscureText: false,
                                                    keyboardType:
                                                        TextInputType.name,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    validator: _validator
                                                        .nameValidator,
                                                  ))
                                            ])),
                                    const SizedBox(height: 20),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: CustomTextField(
                                                isTablet: isTablet,
                                                key: const Key(
                                                    'bioCustomTextFieldKey'),
                                                maxLines: 1,
                                                readOnly: readOnlyTextField,
                                                controller: _bioController,
                                                labelText: 'Bio',
                                                hintText: 'Enter your Bio',
                                                prefixIcon:
                                                    Icons.textsms_rounded,
                                                obscureText: false,
                                                keyboardType:
                                                    TextInputType.text,
                                                textInputAction:
                                                    TextInputAction.newline,
                                              )),
                                          const SizedBox(height: 20),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: CustomTextField(
                                                isTablet: isTablet,
                                                key: const Key(
                                                    'birthDateCustomTextFieldKey'),
                                                readOnly: readOnlyTextField,
                                                controller:
                                                    _birthDateController,
                                                labelText: 'Date of birth',
                                                hintText: _selectedDate != null
                                                    ? DateFormat('yyyy-MM-dd')
                                                        .format(_selectedDate!)
                                                    : 'Select date',
                                                onTap: () =>
                                                    _selectDate(context),
                                                prefixIcon:
                                                    Icons.date_range_rounded,
                                                obscureText: false,
                                                keyboardType:
                                                    TextInputType.datetime,
                                                textInputAction:
                                                    TextInputAction.next,
                                                validator:
                                                    _validator.dateValidator,
                                              ))
                                        ]),
                                    const SizedBox(height: 20),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: CustomTextField(
                                                isTablet: isTablet,
                                                key: const Key(
                                                    'emailCustomTextFieldKey'),
                                                readOnly: true,
                                                textColor: AppColors.text3,
                                                controller: _emailController,
                                                labelText: 'Email',
                                                hintText: 'Enter your Email',
                                                prefixIcon: Icons.email,
                                                obscureText: false,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                textInputAction:
                                                    TextInputAction.next,
                                                validator:
                                                    _validator.emailValidator,
                                              )),
                                          const SizedBox(height: 20),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: CustomDropdownButton(
                                                isTablet: isTablet,
                                                selectedValue: _selectedGender,
                                                readOnly: readOnlyTextField,
                                                label: 'Gender',
                                                items: genderOptions,
                                                icon: Icons.list,
                                                onValueChanged:
                                                    _handleGenderValueChanged,
                                              ))
                                        ]),
                                    const SizedBox(height: 20),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: CustomTextField(
                                                isTablet: isTablet,
                                                key: const Key(
                                                    'phoneNumberCustomTextFieldKey'),
                                                readOnly: readOnlyTextField,
                                                controller:
                                                    _phoneNumberController,
                                                labelText: 'Phone Number',
                                                hintText:
                                                    'Enter your phone number',
                                                prefixIcon:
                                                    Icons.local_phone_rounded,
                                                obscureText: false,
                                                keyboardType:
                                                    TextInputType.number,
                                                textInputAction:
                                                    TextInputAction.next,
                                                validator: _validator
                                                    .phoneNumberValidator,
                                              )),
                                          const SizedBox(height: 20),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: CustomTextField(
                                                isTablet: isTablet,
                                                key: const Key(
                                                    'passwordCustomTextField'),
                                                controller: _passwordController,
                                                labelText: 'Password',
                                                hintText: 'Enter your password',
                                                prefixIcon: Icons.password,
                                                suffixIcon: Icons.edit,
                                                isEditableOnOtherWindow: true,
                                                isPassword: true,
                                                readOnly: true,
                                                isPasswordVisible: false,
                                                onVisibilityPressed: () =>
                                                    !readOnlyTextField
                                                        ? showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return const ChangePasswordDialog();
                                                            })
                                                        : null,
                                                onTap: () => !readOnlyTextField
                                                    ? showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return const ChangePasswordDialog();
                                                        })
                                                    : null,
                                                obscureText: true,
                                                keyboardType: TextInputType
                                                    .visiblePassword,
                                                textInputAction:
                                                    TextInputAction.next,
                                              ))
                                        ]),
                                    const SizedBox(height: 20),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomButton(
                                            key: const Key(
                                                'editSaveCustomButtonKey'),
                                            fontSize: isTablet ? 20 : 15,
                                            height: isTablet ? 15 : 12,
                                            width: isTablet ? 25 : 20,
                                            text: readOnlyTextField
                                                ? "Edit Profile"
                                                : "Save modifications",
                                            textColor: Colors.white,
                                            onPressed: () {
                                              if (!readOnlyTextField) {
                                                _submit();
                                                DialogPopup(
                                                        text:
                                                            "Profile modified correctly",
                                                        duration: 1)
                                                    .show(context);
                                              } else {
                                                setState(
                                                  () {
                                                    readOnlyTextField =
                                                        !readOnlyTextField;
                                                  },
                                                );
                                                DialogPopup(
                                                        text:
                                                            "Modify your profile",
                                                        duration: 1)
                                                    .show(context);
                                              }
                                            },
                                          )
                                        ]),
                                    const SizedBox(height: 20),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CustomButton(
                                            key: const Key(
                                                'LogoutCustomButtonKey'),
                                            fontSize: isTablet ? 15 : 12,
                                            height: isTablet ? 15 : 12,
                                            width: isTablet ? 18 : 15,
                                            text: "Logout",
                                            textColor: Colors.white,
                                            backgroundColor: AppColors.main3,
                                            onPressed: () {
                                              logout();
                                            },
                                          ),
                                          const SizedBox(width: 20),
                                          CustomButton(
                                            key: const Key(
                                                'DeleteAccountCustomButtonKey'),
                                            fontSize: isTablet ? 15 : 12,
                                            height: isTablet ? 15 : 12,
                                            width: isTablet ? 28 : 15,
                                            text: "Delete",
                                            textColor: Colors.white,
                                            backgroundColor: AppColors.main3,
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return const DeleteAccountDialog();
                                                  });
                                            },
                                          ),
                                        ])
                                  ])
                            ]))))
            //)
          ]);
        } else if (snapshot.hasError) {
          // print(snapshot.error);
          return Text("Error: ${snapshot.error}");
        } else {
          return Container();
        }
      });
}

void _submit() async {
  final isValid = _formKey.currentState?.validate();
  if (isValid == null || !isValid) {
    print("not valid");
    // return;
  }
  UserModel userData = UserModel(
    id: _appManager.getCurrentUser(),
    email: _emailController.text,
    name: _nameController.text,
    surname: _surnameController.text,
    birthDate: _birthDateController.text,
    phoneNumber: _phoneNumberController.text,
    bio: _bioController.text,
    gender: _selectedGender,
    profileImage: _appManager.getProfileImage(),
  );
  int? result =
      await _authService.updateUser(_appManager.getCurrentUser(), userData);
  if (result == 200) {
    // _formKey.currentState?.save();
    // user = _authService.getUserById(_appManager.getCurrentUser());
    setState(() {
      user = Future.value(userData);
      readOnlyTextField = !readOnlyTextField;
    });
    // refreshPage();
  } else {
    ErrorController.showSnackBarError(ErrorController.updateUser);
    return;
  }
}

void logout() {
  _authService.signOut();
  _appManager.reset();
  DialogPopup(text: "Logging out ...", duration: 2).show(context);
  Future.delayed(Duration(seconds: 2), () {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  });
}

void refreshPage() {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
        builder: (context) => CustomMenu(
              index: 2,
            )),
  );
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
  _birthDateController.text =
      DateFormat('yyyy-MM-dd').format(_selectedDate!).toString();
}

void _handleGenderValueChanged(String? newValue) {
  _selectedGender = newValue!;
}

@override
void initState() {
  super.initState();
  user = _authService.getUserById(_appManager.getCurrentUser());
  _nameController = TextEditingController()..addListener(() {});
  _surnameController = TextEditingController()..addListener(() {});
  _emailController = TextEditingController()..addListener(() {});
  _birthDateController = TextEditingController()..addListener(() {});
  _phoneNumberController = TextEditingController()..addListener(() {});
  _bioController = TextEditingController()..addListener(() {});
  _passwordController = TextEditingController()..addListener(() {});
  _passwordController.text = "Password";
  _controller =
      AnimationController(vsync: this, duration: Duration(seconds: 4));
  // _profileImage = const AssetImage('assets/images/profile_pic.png');
}

@override
void dispose() {
  _nameController.dispose();
  _surnameController.dispose();
  _emailController.dispose();
  _birthDateController.dispose();
  _phoneNumberController.dispose();
  _bioController.dispose();
  _passwordController.dispose();
  _controller.dispose();
  super.dispose();
}
*/