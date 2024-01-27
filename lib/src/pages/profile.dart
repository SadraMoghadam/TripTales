import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:trip_tales/src/models/user_model.dart';
import 'package:trip_tales/src/screen/set_photo_screen.dart';
import 'package:trip_tales/src/services/auth_service.dart';
import 'package:trip_tales/src/utils/validator.dart';
import 'package:trip_tales/src/widgets/app_bar_tale.dart';
import '../constants/color.dart';
import '../constants/error_messages.dart';
import '../utils/app_manager.dart';
import '../utils/device_info.dart';
import '../utils/password_strength_indicator.dart';
import '../utils/validator.dart';
import '../widgets/button.dart';
import '../widgets/dropdown_button.dart';
import '../widgets/text_field.dart';
import '../utils/validator.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _authService = Get.find<AuthService>();
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

  // late final TextEditingController _passwordController;

  // late final TextEditingController _genderController;
  // late final TextEditingController _confirmPasswordController;
  ImageProvider<Object>? _profileImage;

  bool readOnlyTextField = true;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
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

  // ImageProvider<Object>? _getImage() {
  //   return _profileImage; // Return the selected profile image or null
  // }
  //
  // void _changeProfilePicture() async {
  //   final selectedImage = await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => SetPhotoScreen(
  //         isImage: true,
  //         contDef: true,
  //         // containerWidget: _profilePictureContainer(),
  //       ),
  //     ),
  //   );
  //
  //   if (selectedImage != null && selectedImage is File) {
  //     setState(() {
  //       _profileImage = FileImage(selectedImage);
  //     });
  //   }
  // }
  //
  // Widget _profilePictureContainer() {
  //   return CircleAvatar(
  //     radius: 70,
  //     backgroundImage: _getImage(),
  //     backgroundColor: AppColors.main2,
  //   );
  // }

  void _submit() async {
    final isValid = _formKey.currentState?.validate();
    if (isValid == null || !isValid) {
      print("not valid");
      // return;
    }
    UserModel userData = UserModel(
      id: "1",
      email: _emailController.text,
      name: _nameController.text,
      surname: _surnameController.text,
      birthDate: _birthDateController.text,
      phoneNumber: _phoneNumberController.text,
      bio: _bioController.text,
      gender: _selectedGender,
    );
    int? result = await _authService.updateUser("1", userData);
    if (result == 200) {
      // _formKey.currentState?.save();
      // user = _authService.getUserById("1");
      setState(
              () {
                user = Future.value(userData);
            readOnlyTextField = !readOnlyTextField;
          });
      // refreshPage();
    } else {
      ErrorController.showSnackBarError(ErrorController.updateUser);
      return;
    }
  }

  void refreshPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ProfilePage()),
    );
  }

  // void checkPasswordStrength(String value) {
  //   setState(() {
  //     // Reset criteria
  //     hasUppercase = false;
  //     hasLowercase = false;
  //     hasDigits = false;
  //     hasSpecialCharacters = false;
  //
  //     // Check criteria for password strength
  //     hasUppercase = value.contains(RegExp(r'[A-Z]'));
  //     hasLowercase = value.contains(RegExp(r'[a-z]'));
  //     hasDigits = value.contains(RegExp(r'[0-9]'));
  //     hasSpecialCharacters = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  //   });
  // }
  //
  // void onPasswordVisibilityPressed() {
  //   setState(() {
  //     _isPasswordVisible = !_isPasswordVisible;
  //   });
  // }
  //
  // void onConfirmPasswordVisibilityPressed() {
  //   setState(() {
  //     _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
  //   });
  // }

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
    user = _authService.getUserById("1");
    _nameController = TextEditingController()
      ..addListener(() {
      });
    _surnameController = TextEditingController()
      ..addListener(() {
      });
    _emailController = TextEditingController()
      ..addListener(() {
      });
    _birthDateController = TextEditingController()
      ..addListener(() {
      });
    _phoneNumberController = TextEditingController()
      ..addListener(() {
      });
    _bioController = TextEditingController()
      ..addListener(() {
      });
    // _profileImage = const AssetImage('assets/images/profile_pic.png');

  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    _birthDateController.dispose();
    // _passwordController.dispose();
    // _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DeviceInfo device = DeviceInfo();
    device.computeDeviceInfo(context);
    return Scaffold(
      body: CustomAppBar(
        bodyTale: buildBody(context),
        showIcon: false,
      ),
    );
  }

  Widget buildBody(context) {
    DeviceInfo device = DeviceInfo();
    device.computeDeviceInfo(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
          fit: FlexFit.tight,
          flex: 25,
          child: buildScreen(),
        ),
      ],
    );
  }

  Widget buildHeader(context) {
    return Center(
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(
              color: AppColors.main3,
              border: Border(
                  top: BorderSide(color: AppColors.main2, width: 4),
                  right: BorderSide(color: AppColors.main2, width: 4),
                  bottom: BorderSide(color: AppColors.main2, width: 4),
                  left: BorderSide(color: AppColors.main2, width: 4),
              ),
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              radius: 65,
              backgroundImage: _profileImage,
              backgroundColor: AppColors.main1.shade200,
            ),
          ),
          Positioned(
            width: 50,
            height: 50,
            bottom: 0,
            right: 0,
            child: FloatingActionButton(
              backgroundColor: AppColors.main2,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return modifyProfileImage();
                    });
                //  _changeProfilePicture(); // Invoke method to change profile picture
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28.0),
              ),
              child: const Icon(
                Icons.camera_alt_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildScreen() {
    return FutureBuilder<UserModel?>(
      key: _futureBuilderKey,
        future: user,
        builder: (BuildContext context, AsyncSnapshot<UserModel?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          else if (snapshot.hasData) {
            UserModel userData = snapshot.data!;
            _nameController.text = userData.name;
            _surnameController.text = userData.surname;
            _emailController.text = userData.email;
            _birthDateController.text = userData.birthDate;
            _selectedGender = userData.gender;
            _bioController.text = userData.bio;
            _phoneNumberController.text = userData.phoneNumber;
            if(userData.profileImage != ''){
              _profileImage = NetworkImage(userData.profileImage);
            }
            else {
              _profileImage = const AssetImage('assets/images/profile_pic.png');
            }

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                    key: Key('abc'),
                  ),
                  buildHeader(context),
                  const SizedBox(height: 20),
                  CustomTextField(
                    key: const Key('nameCustomTextFieldKey'),
                    readOnly: readOnlyTextField,
                    controller: _nameController,
                    labelText: 'Name',
                    hintText: 'Enter your Name',
                    prefixIcon: Icons.abc_rounded,
                    obscureText: false,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    validator: _validator.nameValidator,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    key: const Key('surnameCustomTextFieldKey'),
                    readOnly: readOnlyTextField,
                    controller: _surnameController,
                    labelText: 'Surname',
                    hintText: 'Enter your Surname',
                    prefixIcon: Icons.abc_rounded,
                    obscureText: false,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    validator: _validator.nameValidator,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    key: const Key('bioCustomTextFieldKey'),
                    maxLines: 5,
                    readOnly: readOnlyTextField,
                    controller: _bioController,
                    labelText: 'Bio',
                    hintText: 'Enter your Bio',
                    prefixIcon: Icons.textsms_rounded,
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    key: const Key('birthDateCustomTextFieldKey'),
                    readOnly: readOnlyTextField,
                    controller: _birthDateController,
                    labelText: 'Date of birth',
                    hintText: _selectedDate != null
                        ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
                        : 'Select date',
                    onTap: () => _selectDate(context),
                    prefixIcon: Icons.date_range_rounded,
                    obscureText: false,
                    keyboardType: TextInputType.datetime,
                    textInputAction: TextInputAction.next,
                    validator: _validator.dateValidator,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    key: const Key('emailCustomTextFieldKey'),
                    readOnly: readOnlyTextField,
                    controller: _emailController,
                    labelText: 'Email',
                    hintText: 'Enter your Email',
                    prefixIcon: Icons.email,
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: _validator.emailValidator,
                  ),
                  // const SizedBox(height: 20),
                  // CustomTextField(
                  //   key: const Key('passwordCustomTextFieldKey'),
                  //   readOnly: readOnlyTextField,
                  //   controller: _passwordController,
                  //   labelText: 'Password',
                  //   hintText: 'Enter your Password',
                  //   prefixIcon: Icons.password,
                  //   isPassword: true,
                  //   isPasswordVisible: _isPasswordVisible,
                  //   onVisibilityPressed: onPasswordVisibilityPressed,
                  //   obscureText: !_isPasswordVisible,
                  //   keyboardType: TextInputType.visiblePassword,
                  //   textInputAction: TextInputAction.next,
                  //   validator: _validator.passwordValidator,
                  // ),
                  const SizedBox(height: 20),
                  CustomDropdownButton(
                    selectedValue: _selectedGender,
                    readOnly: readOnlyTextField,
                    label: 'Gender',
                    items: genderOptions,
                    icon: Icons.list,
                    onValueChanged: _handleGenderValueChanged,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    key: const Key('phoneNumberCustomTextFieldKey'),
                    readOnly: readOnlyTextField,
                    controller: _phoneNumberController,
                    labelText: 'Phone Number',
                    hintText: 'Enter your phone number',
                    prefixIcon: Icons.local_phone_rounded,
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    validator: _validator.phoneNumberValidator,
                  ),

                  const SizedBox(height: 20),
                  CustomButton(
                    key: const Key('editSaveCustomButtonKey'),
                    fontSize: 15,
                    height: 12,
                    width: 20,
                    text: readOnlyTextField
                        ? "Edit Profile"
                        : "Save modifications",
                    textColor: Colors.white,
                    onPressed: () {
                      if (!readOnlyTextField) {
                        _submit();
                      }
                      else {
                        setState(
                              () {
                            readOnlyTextField = !readOnlyTextField;
                          },
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            // print(snapshot.error);
            return Text("Error: ${snapshot.error}");
          } else {
            return Container();
          }
        });
  }

  Widget modifyProfileImage() {
    DeviceInfo device = DeviceInfo();
    device.computeDeviceInfo(context);
    return AlertDialog(
      key: const Key('alertDialogKey'),
      elevation: 10,
      shadowColor: Colors.grey,
      insetPadding: const EdgeInsets.all(10),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0))),
      content: buildProfileBody(device),
      actions: <Widget>[
        CustomButton(
            key: const Key('closeCustomButtonKey'),
            height: 5,
            width: 30,
            fontSize: 12,
            backgroundColor: AppColors.main3,
            text: "close",
            textColor: Colors.white,
            onPressed: () => Navigator.of(context).pop())
      ],
    );
  }

  Widget buildProfileBody(DeviceInfo device) {
    return SingleChildScrollView(
      child: Container(
        height: 200,
        width: device.width,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Flexible(
                flex: 8,
                fit: FlexFit.tight,
                child: Container(
                  height: 310,
                  child: SetPhotoScreen(
                    isImage: true,
                    contDef: true,
                  ),
                ),
              ),
              Flexible(
                flex: 5,
                fit: FlexFit.tight,
                child: Center(
                    child: CustomButton(
                        key: const Key('deleteCustomButtonKey'),
                        height: 18,
                        width: 200,
                        text: "Delete",
                        textColor: Colors.white,
                        onPressed: () => Navigator.of(context).pop())),
              )
            ],
          ),
        ),
      ),
    );
  }
}
