import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_tales/src/constants/color.dart';
import 'package:trip_tales/src/constants/error_messages.dart';
import '../constants/firestore_collections.dart';
import '../models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../utils/app_manager.dart';

class AuthService extends GetxService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final AppManager _appManager = Get.put(AppManager());
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Rx<User?> user = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    user.bindStream(_auth.authStateChanges());
  }


  Future<User?> signInWithFacebook() async {
    try {
      print("0");
      final LoginResult result = await FacebookAuth.instance.login();
      print("1");
      final facebookAuthCredential = FacebookAuthProvider.credential(result.accessToken!.token);
      print("2");
      final UserCredential authResult = await _auth.signInWithCredential(facebookAuthCredential);
      final User? fbUser = authResult.user;

      if (fbUser != null) {
        await _createUserDocument(fbUser.email!, _getFirstName(fbUser?.displayName), _getLastName(fbUser?.displayName));
      }
      print(fbUser);

      return fbUser;
    } catch (error) {
      ErrorController.showSnackBarError(ErrorController.loginFacebook);
      return null;
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult = await _auth.signInWithCredential(credential);
      final User? googleUser = authResult.user;

      if (googleUser != null) {
        await _createUserDocument(googleUser.email!, _getFirstName(googleUser?.displayName), _getLastName(googleUser?.displayName));
      }

      return googleUser;
    } catch (error) {
      ErrorController.showSnackBarError(ErrorController.loginGmail);
      return null;
    }
  }

  String _getFirstName(String? displayName) {
    List<String> nameParts = displayName!.split(" ");
    return nameParts.isNotEmpty ? nameParts.first : "";
  }

  String _getLastName(String? displayName) {
    List<String> nameParts = displayName!.split(" ");
    return nameParts.length > 1 ? nameParts.last : "";
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
      ErrorController.showSnackBarError(ErrorController.login);
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
        await _createUserDocument(email, name, surname, birthDate: birthDate);
      }
      return registeredUser;
    } catch (e) {
      ErrorController.showSnackBarError(ErrorController.register);
      return null;
    }
  }

  Future<int?> updateUser(
      String uid, UserModel userData) async {
    try {
      UserModel? user = await getUserById("1");
      // UserModel newUser = UserModel(
      //   id: uid,
      //   email: userData.email,
      //   name: userData.name,
      //   surname: userData.surname,
      //   birthDate: userData.birthDate,
      //   phoneNumber: userData.phoneNumber,
      //   bio: userData.bio,
      //   gender: userData.gender,
      // );
      await _firestore.collection('users').doc("1").update({
        'email': userData.email,
        'name': userData.name,
        'surname': userData.surname,
        'birthDate': userData.birthDate,
        'phoneNumber': userData.phoneNumber,
        'bio': userData.bio,
        'gender': userData.gender,
        'profileImage': "1" + ".png",
      });
      print(user!.profileImage);
      print('User updated successfully.');
      return 200;
    } catch (e) {
      ErrorController.showSnackBarError(ErrorController.updateUser);
      return null;
    }
  }

  Future<bool> updateUserImage(File imageFile, String imagePath) async {
    try {
      await _storage.ref().child(imagePath).putFile(imageFile);
      await _firestore.collection('users').doc("1").update(
          {'profileImage': imagePath});
      print('Image uploaded successfully.');
      return Future.value(true);
    } on FirebaseException catch (e) {
      ErrorController.showSnackBarError(ErrorController.updateUserImage);
      return Future.value(false);
    }
  }

  Future<bool> updatePassword(String password) async {
    try {
      await _firestore.collection('users').doc("1").update(
          {'password': password});
      print('Password updated successfully.');
      return Future.value(true);
    } on FirebaseException catch (e) {
      ErrorController.showSnackBarError(ErrorController.updateUserPass);
      return Future.value(false);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> _createUserDocument(String email, String name,
      String surname, {String? birthDate}) async {
    CollectionReference users = _firestore.collection('users');
    UserModel newUser = UserModel(
      id: '',
      email: email,
      name: name,
      surname: surname,
      birthDate: birthDate!,
      phoneNumber: '',
      bio: '',
      gender: '',
      profileImage: '',
    );
    DocumentReference documentReference = await users.add(newUser.toJson());
    String firebaseGeneratedId = documentReference.id;
    await users.doc(firebaseGeneratedId).update({
      'id': firebaseGeneratedId,
    });
  }

  Future<UserModel?> getUserById(String uid) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> userDoc =
          await _firestore.collection('users').doc(uid).get();
      final userData = userDoc.data();
      if (userData != null) {
        String downloadURL = '';
        print("_____________${userData.containsKey('profileImage')}");
        if(userData.containsKey('profileImage')){
          downloadURL = await _storage.ref().child(userData['profileImage']).getDownloadURL();
          _appManager.setProfileImage(downloadURL);
          print(downloadURL);
        }
        UserModel user = UserModel.fromJson(userData, downloadURL);
        return user;
        //   id: uid,
        //   email: userData['email'],
        //   name: userData['name'],
        //   surname: userData['surname'],
        //   birthDate: userData['birthDate'],
        //   bio: userData['bio'],
        //   gender: userData['gender'],
        //   phoneNumber: userData['phoneNumber'],
        //   profileImage: userData['profileImage'],
        //   talesFK: userData['profileImage'],
        // );
      }
    } catch (e) {
      // Get.snackbar('Error', e.toString());
      return null;
    }
  }

  String? get currentUserId {
    return FirebaseAuth.instance.currentUser?.uid;
  }

}
