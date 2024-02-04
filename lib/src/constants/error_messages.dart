import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_tales/src/constants/color.dart';
import 'package:trip_tales/src/constants/error_messages.dart';
import '../models/user_model.dart';

class ErrorController {
  static const String login = "Wrong email or password";
  static const String loginGmail = "Problem with google login";
  static const String loginFacebook = "Problem with facebook login";
  static const String register = "Registration not completed";
  static const String updateUser = "Problem with user update";
  static const String updateUserImage = "Failed to upload image";
  static const String updateUserPass = "Failed to update password";
  static const String createImage = "Problem with image creation";
  static const String createVideo = "Problem with video creation";
  static const String createText = "Problem with text creation";
  static const String deleteCard = "Problem with deleting memory";
  static const String deleteAccount = "Problem with deleting account";
  static const String resetCardPosition = "Cannot reset card position";
  static const String createTale = "No image selected";
  static const String changePassword = "Cannot change password";
  static void showSnackBarError(String errorMsg){
    Get.snackbar('Oops!', errorMsg, backgroundColor: AppColors.main3, borderWidth: 3, borderColor: Colors.black26);
  }
}

