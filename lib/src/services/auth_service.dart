import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
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

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? signedInUser = authResult.user;
      return signedInUser;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return null;
    }
  }

  Future<User?> registerWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? registeredUser = authResult.user;
      return registeredUser;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<UserModel?> getUserById(String uid) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> userDoc =
      await _firestore.collection('users').doc(uid).get();
      final userData = userDoc.data();
      if (userData != null) {
        return UserModel(uid: uid, email: userData['email']);
      }
      return null;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return null;
    }
  }
}