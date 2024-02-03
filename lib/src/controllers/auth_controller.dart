import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:trip_tales/src/models/card_model.dart';
import 'package:trip_tales/src/services/card_service.dart';
import 'package:trip_tales/src/services/tale_service.dart';
import '../models/tale_model.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';

class AuthController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  // final TaleService _taleService = Get.find<TaleService>();
  // final CardService _cardService = Get.find<CardService>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    ever<User?>(_authService.user, _handleAuthStateChanged);
  }

  void _handleAuthStateChanged(User? user) async {
    if (user == null) {
      currentUser.value = null;
    } else {
      final UserModel? userModel = await _authService.getUserById(user.uid);
      currentUser.value = userModel;
    }
  }

  Future<int> signInWithFacebook() async {
    final User? signedInUser = await _authService.signInWithFacebook();
    if (signedInUser != null) {
      print("logged in");
      return 200;
    } else {
      print("error in login");
      return 401;
    }
  }

  Future<int> signInWithGoogle() async {
    final User? signedInUser = await _authService.signInWithGoogle();
    if (signedInUser != null) {
      print("logged in");
      return 200;
    } else {
      print("error in login");
      return 401;
    }
  }

  Future<int> signInWithEmailAndPassword(String email, String password) async {
    final User? signedInUser =
        await _authService.signInWithEmailAndPassword(email, password);
    if (signedInUser != null) {
      print("logged in");
      return 200;
    } else {
      print("error in login");
      return 401;
    }
  }

  Future<int> registerWithEmailAndPassword(String email, String password,
      String name, String surname, String birthDate) async {
    final User? registeredUser =
        await _authService.registerWithEmailAndPassword(
            email, password, name, surname, birthDate);
    if (registeredUser != null) {
      return 200;
    } else {
      return 401;
    }
  }

  Future<bool> deleteUser(String uid) async {
    try {
      UserModel? user = await _authService.getUserById(uid);
      // List<TaleModel?> tales = await _taleService.getTales(uid);
      // for(int i = 0; i < tales.length; i++) {
      //   String taleId = await _taleService.getTaleId(tales[i]!.name!);
      //   List<CardModel?> cards = await _cardService.getCards(taleId);
      //   for(int j = 0; j < cards.length; j++) {
      //     String cardId = await _cardService.getCardId(tales[i]!.id!, cards[j]!.name!);
      //     await _firestore.collection('cards').doc(cardId).delete();
      //   }
      //   await _firestore.collection('tales').doc(taleId).delete();
      // }
      await _firestore.collection('users').doc(user!.id).delete();
      await _storage.refFromURL(user!.profileImage).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }
}
