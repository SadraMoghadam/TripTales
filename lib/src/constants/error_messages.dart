import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_tales/src/constants/color.dart';
import 'package:trip_tales/src/constants/error_messages.dart';
import '../models/user_model.dart';

class ErrorMsg {
  static const String login = "Wrong email or password";
  static SnackbarController loginError = Get.snackbar('Oops!', login, backgroundColor: AppColors.main3, borderWidth: 3, borderColor: Colors.black26);
  static const String register = "Registration not completed";
  static SnackbarController registerError = Get.snackbar('Oops!', register, backgroundColor: AppColors.main3, borderWidth: 3, borderColor: Colors.black26);
}