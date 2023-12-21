import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_tales/src/constants/color.dart';
import 'package:trip_tales/src/constants/error_messages.dart';
import '../constants/firestore_collections.dart';
import '../models/user_model.dart';

class AuthService extends GetxService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Rx<User?> user = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    user.bindStream(_auth.authStateChanges());
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? signedInUser = authResult.user;
      return signedInUser;
    } catch (e) {
      ErrorMsg.loginError;
      return null;
    }
  }

  Future<User?> registerWithEmailAndPassword(
      String email, String password,String name, String surname, String birthDate) async {
    try {
      final UserCredential authResult =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? registeredUser = authResult.user;
      if (registeredUser != null) {
        await _createUserDocument(registeredUser.uid, email, name, surname, birthDate);
      }
      return registeredUser;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> _createUserDocument(String uid, String email, String name,
      String surname, String birthDate) async {
    await _firestore.collection(FirestoreCollections.users).doc(uid).set({
      'email': email,
      'name': name,
      'surname': surname,
      'birthDate': birthDate,
    });
  }

  Future<UserModel?> getUserById(String uid) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> userDoc =
          await _firestore.collection('users').doc(uid).get();
      final userData = userDoc.data();
      if (userData != null) {
        return UserModel(
            uid: uid,
            email: userData['email'],
            name: userData['name'],
            surname: userData['surname'],
            birthDate: userData['birth_date']);
      }
      return null;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return null;
    }
  }
}
