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

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
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
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => route.isFirst);
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
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    DeviceInfo device = DeviceInfo();
    device.computeDeviceInfo(context);
    return buildBody(context);
    //   Scaffold(
    //   body: CustomAppBar(
    //     bodyTale: buildBody(context),
    //     showIcon: false,
    //   ),
    // );
  }

  Widget buildBody(context) {
    DeviceInfo device = DeviceInfo();
    device.computeDeviceInfo(context);
    bool isTablet = device.isTablet;
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
          fit: FlexFit.tight,
          flex: 25,
          child: isTablet && isLandscape
              ? Center(child: buildScreenLandScape())
              : buildScreen(),
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
              // color: AppColors.main3,
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
                    }).then((value) => {
                      setState(() {
                        File imageFile = mediaController.getImage()!;
                        _authService
                            .updateUserImage(imageFile,
                                _appManager.getCurrentUser() + ".png")
                            .then((value) => {});
                        user = Future.value(UserModel(
                          id: _appManager.getCurrentUser(),
                          email: _emailController.text,
                          name: _nameController.text,
                          surname: _surnameController.text,
                          birthDate: _birthDateController.text,
                          phoneNumber: _phoneNumberController.text,
                          bio: _bioController.text,
                          gender: _selectedGender,
                          profileImage: _appManager.getProfileImage(),
                        ));
                        showDialog(
                            context: context,
                            builder: (context) {
                              _controller.reset();
                              _controller.forward();
                              return AlertDialog(
                                content: Lottie.asset(
                                  "assets/animations/loading.json",
                                  width: 400,
                                  height: 400,
                                  controller: _controller,
                                ),
                              );
                            });
                        Future.delayed(Duration(seconds: 3), () {
                          print("hiii");
                          Navigator.of(context).pop();
                          refreshPage();
                        });
                      }),
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

  Widget buildScreenLandScape() {
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: CustomTextField(
                                                      isTablet: isTablet,
                                                      key: const Key(
                                                          'nameCustomTextFieldKey'),
                                                      readOnly:
                                                          readOnlyTextField,
                                                      controller:
                                                          _nameController,
                                                      labelText: 'Name',
                                                      hintText:
                                                          'Enter your Name',
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
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: CustomTextField(
                                                      isTablet: isTablet,
                                                      key: const Key(
                                                          'surnameCustomTextFieldKey'),
                                                      readOnly:
                                                          readOnlyTextField,
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
                                                  hintText: _selectedDate !=
                                                          null
                                                      ? DateFormat('yyyy-MM-dd')
                                                          .format(
                                                              _selectedDate!)
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
                                                  keyboardType: TextInputType
                                                      .emailAddress,
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
                                                  selectedValue:
                                                      _selectedGender,
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
                                                  controller:
                                                      _passwordController,
                                                  labelText: 'Password',
                                                  hintText:
                                                      'Enter your password',
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
                                                              builder:
                                                                  (context) {
                                                                return const ChangePasswordDialog();
                                                              })
                                                          : null,
                                                  onTap: () =>
                                                      !readOnlyTextField
                                                          ? showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) {
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

  Widget buildScreen() {
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
          print("==================================================");
          if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
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
                  SizedBox(height: isTablet ? 40 : 20),
                  CustomTextField(
                    isTablet: isTablet,
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
                    isTablet: isTablet,
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
                    isTablet: isTablet,
                    key: const Key('bioCustomTextFieldKey'),
                    maxLines: 1,
                    readOnly: readOnlyTextField,
                    controller: _bioController,
                    labelText: 'Bio',
                    hintText: 'Enter your Bio',
                    prefixIcon: Icons.textsms_rounded,
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.newline,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    isTablet: isTablet,
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
                    isTablet: isTablet,
                    key: const Key('emailCustomTextFieldKey'),
                    readOnly: true,
                    textColor: AppColors.text3,
                    controller: _emailController,
                    labelText: 'Email',
                    hintText: 'Enter your Email',
                    prefixIcon: Icons.email,
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: _validator.emailValidator,
                  ),
                  const SizedBox(height: 20),
                  CustomDropdownButton(
                    isTablet: isTablet,
                    selectedValue: _selectedGender,
                    readOnly: readOnlyTextField,
                    label: 'Gender',
                    items: genderOptions,
                    icon: Icons.list,
                    onValueChanged: _handleGenderValueChanged,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    isTablet: isTablet,
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
                  CustomTextField(
                    isTablet: isTablet,
                    key: const Key('passwordCustomTextField'),
                    controller: _passwordController,
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    prefixIcon: Icons.password,
                    suffixIcon: Icons.edit,
                    isEditableOnOtherWindow: true,
                    isPassword: true,
                    readOnly: true,
                    isPasswordVisible: false,
                    onVisibilityPressed: () => !readOnlyTextField
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
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    isTablet: isTablet,
                    key: const Key('editSaveCustomButtonKey'),
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
                                text: "Profile modified correctly", duration: 1)
                            .show(context);
                      } else {
                        setState(
                          () {
                            readOnlyTextField = !readOnlyTextField;
                          },
                        );
                        DialogPopup(text: "Modify your profile", duration: 1)
                            .show(context);
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomButton(
                        isTablet: isTablet,
                        key: const Key('LogoutCustomButtonKey'),
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
                        isTablet: isTablet,
                        key: const Key('DeleteAccountCustomButtonKey'),
                        fontSize: isTablet ? 15 : 12,
                        height: isTablet ? 15 : 12,
                        width: isTablet ? 18 : 15,
                        text: "Delete",
                        textColor: Colors.white,
                        backgroundColor: AppColors.main3,
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const DeleteAccountDialog();
                              }).then((value) => () {
                                if (value == true) logout();
                              });
                        },
                      ),
                    ],
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
    bool isTablet = device.isTablet;
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
            height: isTablet ? 8 : 5,
            width: isTablet ? 35 : 30,
            fontSize: isTablet ? 15 : 12,
            backgroundColor: AppColors.main3,
            text: "close",
            textColor: Colors.white,
            onPressed: () => Navigator.of(context).pop())
      ],
    );
  }

  Widget buildProfileBody(DeviceInfo device) {
    DeviceInfo device = DeviceInfo();
    device.computeDeviceInfo(context);
    bool isTablet = device.isTablet;
    return SingleChildScrollView(
      child: Container(
        height: isTablet ? 300 : 200,
        width: device.width,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Flexible(
                flex: 5,
                fit: FlexFit.tight,
                child: Container(
                  height: isTablet ? 410 : 310,
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
                        height: isTablet ? 20 : 18,
                        width: isTablet ? 210 : 200,
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
