import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trip_tales/src/screen/set_photo_screen.dart';
import 'package:trip_tales/src/utils/validator.dart';
import 'package:trip_tales/src/widgets/app_bar_tale.dart';
import '../constants/color.dart';
import '../utils/device_info.dart';
import '../utils/password_strength_indicator.dart';
import '../utils/validator.dart';
import '../widgets/button.dart';
import '../widgets/text_field.dart';
import '../utils/validator.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Validator _validator = Validator();
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _surnameController;
  late final TextEditingController _emailController;
  late final TextEditingController _birthDateController;
  late final TextEditingController _phoneNumberController;
  late final TextEditingController _bioController;
  late final TextEditingController _passwordController;
  late final TextEditingController _genderController;
  late final TextEditingController _confirmPasswordController;
  ImageProvider<Object>? _profileImage;

  bool readOnlyTextField = true;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasDigits = false;
  bool hasSpecialCharacters = false;
  DateTime? _selectedDate;

  ImageProvider<Object>? _getImage() {
    return _profileImage; // Return the selected profile image or null
  }

  void _changeProfilePicture() async {
    final selectedImage = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SetPhotoScreen(
          isImage: true,
          contDef: true,
          // containerWidget: _profilePictureContainer(),
        ),
      ),
    );

    if (selectedImage != null && selectedImage is File) {
      setState(() {
        _profileImage = FileImage(selectedImage);
      });
    }
  }

  Widget _profilePictureContainer() {
    return CircleAvatar(
      radius: 70,
      backgroundImage: _getImage(),
      backgroundColor: AppColors.main2,
    );
  }

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
    _birthDateController.text =
        DateFormat('yyyy-MM-dd').format(_selectedDate!).toString();
  }

  @override
  void initState() {
    _nameController = TextEditingController(text: "Angelo")
      ..addListener(() {
        setState(() {
          // _nameController.text = "myText";
        });
      });
    _surnameController = TextEditingController(text: "Tulbure")
      ..addListener(() {
        setState(() {});
      });
    _emailController = TextEditingController(text: "angelotulbure@gmail.com")
      ..addListener(() {
        setState(() {});
      });
    _birthDateController = TextEditingController(text: "2000-01-29")
      ..addListener(() {
        setState(() {});
      });
    _passwordController = TextEditingController(text: "At123")
      ..addListener(() {
        checkPasswordStrength(_passwordController.text);
        setState(() {});
      });
    _phoneNumberController = TextEditingController(text: "+39 3203298110")
      ..addListener(() {
        setState(() {});
      });
    _genderController = TextEditingController(text: "Male")
      ..addListener(() {
        setState(() {});
      });
    _bioController =
        TextEditingController(text: "Live a Life you will remember")
          ..addListener(() {
            setState(() {});
          });
    _profileImage = const AssetImage('assets/images/profile_pic.png');
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
      body: CustomAppBar(
        bodyTale: buildBody(context),
        showIcon: false,
      ),
    );
  }

  Widget buildBody(context) {
    DeviceInfo device = DeviceInfo();
    device.computeDeviceInfo(context);
    return /*Container(
      height: device.height - 15,
      width: device.width - 15,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: Form(
        key: _formKey,
        child:*/
        Column(
      mainAxisAlignment: MainAxisAlignment.center,
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        /*
        Flexible(
          fit: FlexFit.tight,
          flex: 5,
          child: buildHeader(),
        ),
        */
        Flexible(
          fit: FlexFit.tight,
          flex: 25,
          child: buildScreen(),
        ),
      ],
      //    ),
      // ),
    );
  }

  Widget buildHeader(context) {
    return Center(
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(
                3), // Adjust the padding to control the width of the border
            decoration: const BoxDecoration(
              color: AppColors.main2, // Set the color of the border
              shape: BoxShape.circle, // Ensure the container is circular
            ),
            child: CircleAvatar(
              radius: 65,
              backgroundImage: _profileImage,
              backgroundColor: AppColors.main2,
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
              child: const Icon(
                Icons.camera_alt_rounded,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildScreen() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          buildHeader(context),
          const SizedBox(height: 20),
          /* Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: */
          CustomTextField(
            readOnly: readOnlyTextField,
            controller: _nameController,
            labelText: 'Name',
            // hintText: 'Angelo',
            prefixIcon: Icons.abc_rounded,
            obscureText: false,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: _validator.emailValidator,
          ),
          // ),
          const SizedBox(height: 20),
          /* Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: */
          CustomTextField(
            readOnly: readOnlyTextField,
            controller: _surnameController,
            labelText: 'Surname',
            // hintText: 'Tulbure',
            prefixIcon: Icons.abc_rounded,
            obscureText: false,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: _validator.emailValidator,
          ),
          // ),
          const SizedBox(height: 20),
          /* Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: */
          CustomTextField(
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
          //  ),
          const SizedBox(height: 20),
          /*  Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: */
          CustomTextField(
            // textInputAction: 'angelomaximilian.tulbure@mail.polimi.it',
            readOnly: readOnlyTextField,
            controller: _emailController,
            labelText: 'Email',
            hintText: 'at@gmail.com',
            prefixIcon: Icons.email,
            obscureText: false,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: _validator.emailValidator,
          ),
          //),
          const SizedBox(height: 20),
          /* Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: */
          CustomTextField(
            readOnly: readOnlyTextField,
            controller: _passwordController,
            labelText: 'Password',
            hintText: 'At123',
            prefixIcon: Icons.password,
            isPassword: true,
            isPasswordVisible: _isPasswordVisible,
            onVisibilityPressed: onPasswordVisibilityPressed,
            obscureText: !_isPasswordVisible,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.next,
            validator: _validator.passwordValidator,
          ),
          //   ),
          const SizedBox(height: 20),
          /*Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: */
          CustomTextField(
            readOnly: readOnlyTextField,
            controller: _phoneNumberController,
            labelText: 'Phone Number',
            // hintText: '+39 3203298110',
            prefixIcon: Icons.local_phone_rounded,
            obscureText: false,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: _validator.emailValidator,
          ),
          // ),
          const SizedBox(height: 20),
          /*Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child:*/
          CustomTextField(
            readOnly: readOnlyTextField,
            controller: _genderController,
            labelText: 'Gender',
            // hintText: 'Male',
            prefixIcon: Icons.male_rounded,
            obscureText: false,
            keyboardType: TextInputType.emailAddress,
            //textInputAction: TextInputAction.next,
            validator: _validator.emailValidator,
          ),
          // ),
          const SizedBox(height: 20),
          /* Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: */
          CustomTextField(
            readOnly: readOnlyTextField,
            controller: _bioController,
            labelText: 'Bio',
            // hintText: 'Live a Life you will remember',
            prefixIcon: Icons.textsms_rounded,
            obscureText: false,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: _validator.emailValidator,
          ),
          // ),
          const SizedBox(height: 20),
          /*
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: */
          CustomButton(
            fontSize: 15,
            height: 12,
            width: 20,
            text: "Edit Profile",
            textColor: Colors.white,
            onPressed: () {
              setState(
                () {
                  readOnlyTextField = !readOnlyTextField;
                },
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget modifyProfileImage() {
    DeviceInfo device = DeviceInfo();
    device.computeDeviceInfo(context);
    return AlertDialog(
      elevation: 10,
      shadowColor: Colors.grey,
      insetPadding: const EdgeInsets.all(10),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      content: buildProfileBody(device),
      actions: <Widget>[
        CustomButton(
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
