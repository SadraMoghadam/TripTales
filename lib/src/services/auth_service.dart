import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_tales/src/constants/color.dart';
import 'package:trip_tales/src/constants/error_messages.dart';
import 'package:trip_tales/src/models/tale_model.dart';
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


  Future<User?> signInWithGoogle() async {
    try {
      signOut();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      print("++++++++++++++++++++++++++++++++++++++++++++++++0");

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      print("++++++++++++++++++++++++++++++++++++++++++++++++1");

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User? googleUser = authResult.user;

      print("++++++++++++++++++++++++++++++++++++++++++++++++$googleUser");
      // print("++++++++++++++++++++++++++++++++++++++++++++++++${await getUserByEmail(googleUser!.email!)}");
      if (googleUser != null && await getUserByEmail(googleUser!.email!) == null) {
        print("++++++++++++++++++++++++++++++++++++++++++++++++2");
        await _createUserDocument(
            googleUser.uid,
            googleUser.email!,
            _getFirstName(googleUser?.displayName),
            _getLastName(googleUser?.displayName));
      }
      setUserDataOnLogin(googleUser!.uid);
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
      signOut();
      final UserCredential authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? signedInUser = authResult.user;
      // print("----------${signedInUser!.uid}");
      setUserDataOnLogin(signedInUser!.uid);
      return signedInUser;
    } catch (e) {
      ErrorController.showSnackBarError(ErrorController.login);
      return null;
    }
  }

  Future<User?> registerWithEmailAndPassword(String email, String password,
      String name, String surname, String birthDate) async {
    try {
      signOut();
      final UserCredential authResult =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? registeredUser = authResult.user;
      // print("aaaaaa");
      if (registeredUser != null) {
        await _createUserDocument(registeredUser.uid, email, name, surname,
            birthDate: birthDate);
      }
      // print("aaaaaa");
      return registeredUser;
    } catch (e) {
      ErrorController.showSnackBarError(ErrorController.register);
      return null;
    }
  }

  Future<int?> updateUser(String uid, UserModel userData) async {
    try {
      UserModel? user = await getUserById(_appManager.getCurrentUser());
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
      await _firestore
          .collection('users')
          .doc(_appManager.getCurrentUser())
          .update({
        'email': userData.email,
        'name': userData.name,
        'surname': userData.surname,
        'birthDate': userData.birthDate,
        'phoneNumber': userData.phoneNumber,
        'bio': userData.bio,
        'gender': userData.gender,
        'profileImage': _appManager.getCurrentUser() + ".png",
      });
      // print(user!.profileImage);
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
      await _firestore
          .collection('users')
          .doc(_appManager.getCurrentUser())
          .update({'profileImage': imagePath});
      print('Image uploaded successfully.');
      return Future.value(true);
    } on FirebaseException catch (e) {
      ErrorController.showSnackBarError(ErrorController.updateUserImage);
      return Future.value(false);
    }
  }

  Future<bool> updatePassword(String password) async {
    try {
      await _firestore
          .collection('users')
          .doc(_appManager.getCurrentUser())
          .update({'password': password});
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

  Future<void> _createUserDocument(
      String id, String email, String name, String surname,
      {String? birthDate}) async {
    CollectionReference users = _firestore.collection('users');
    // print("bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb${id}");
    UserModel newUser = UserModel(
      id: id,
      email: email,
      name: name,
      surname: surname,
      birthDate: birthDate ?? '',
      phoneNumber: '',
      bio: '',
      gender: '',
      profileImage: '',
    );
    // print("bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb${id}");
    DocumentReference documentReference = users.doc(id);
    await documentReference.set(newUser.toJson());
    // await users.doc(id).update({
    //   'id': id,
    // });
    setUserDataOnLogin(id);
  }

  Future<UserModel?> getUserById(String uid) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> userDoc =
          await _firestore.collection('users').doc(uid).get();
      final userData = userDoc.data();
      if (userData != null) {
        String? downloadURL = '';

        if (userData.containsKey('profileImage') &&
            userData['profileImage'] != '') {
          Reference ref = _storage.ref().child(userData['profileImage']);

          try {
            downloadURL = await ref.getDownloadURL();
            _appManager.setProfileImage(downloadURL);
            // print(downloadURL);
          } catch (error) {
            print('Error retrieving download URL: $error');
          }
        }

        // Ensure 'downloadURL' is not null before using it in the UserModel constructor
        UserModel user = UserModel.fromJson(userData, downloadURL ?? '');
        return user;
      }
    } catch (e) {
      print('Error get user: $e');
      return UserModel(
        id: '1',
        email: '',
        name: '',
        surname: '',
        birthDate: '',
        phoneNumber: '',
        bio: '',
        gender: '',
        profileImage: '',
        talesFK: null,
      );
    }
  }

  Future<UserModel?> getUserByEmail(String email) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> usersSnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (usersSnapshot.docs.isNotEmpty) {
        final userData = usersSnapshot.docs.first.data();
        String downloadURL = '';

        try {
          if (userData.containsKey('profileImage')) {
            downloadURL = await _storage
                .ref()
                .child(userData['profileImage'])
                .getDownloadURL();
            _appManager.setProfileImage(downloadURL);
          }
        } catch (e) {
          print(e);
          downloadURL = '';
        }
        UserModel user = UserModel.fromJson(userData, downloadURL);
        return user;
      } else {
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<List<UserModel>> getAllUsers() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> usersSnapshot =
          await _firestore.collection('users').get();

      final List<UserModel> users = [];

      for (final userDoc in usersSnapshot.docs) {
        final userData = userDoc.data();

        UserModel user = UserModel.fromJson(userData, '');
        users.add(user);
      }

      return users;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  void setUserDataOnLogin(String uid) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> userDoc =
          await _firestore.collection('users').doc(uid).get();
      final userData = userDoc.data();
      if (userData != null) {
        // print("=====================${uid}");
        _appManager.setCurrentUser(uid);
        String downloadURL = '';
        if (userData.containsKey('profileImage') &&
            userData['profileImage'] != '') {
          downloadURL = await _storage
              .ref()
              .child(userData['profileImage'])
              .getDownloadURL();
          _appManager.setProfileImage(downloadURL);
        }
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  String? get currentUserId {
    print(_auth.currentUser?.uid);
    return _auth.currentUser?.uid;
  }


  Future<User?> signInWithFacebook() async {
    try {
      signOut();
      print("0");
      final LoginResult result = await FacebookAuth.instance.login();
      print(_appManager.getCurrentUser());
      final facebookAuthCredential =
      FacebookAuthProvider.credential(result.accessToken!.token);
      print("2");
      final UserCredential authResult =
      await _auth.signInWithCredential(facebookAuthCredential);
      final User? fbUser = authResult.user;

      if (fbUser != null) {
        await _createUserDocument(
            fbUser.uid,
            fbUser.email!,
            _getFirstName(fbUser?.displayName),
            _getLastName(fbUser?.displayName));
      }
      print(fbUser);

      return fbUser;
    } catch (error) {
      ErrorController.showSnackBarError(ErrorController.loginFacebook);
      return null;
    }
  }

}
