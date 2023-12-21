import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';

class AuthController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  Rx<UserModel?> currentUser = Rx<UserModel?>(null);

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

  Future<int> registerWithEmailAndPassword(
      String email, String password, String name, String surname, String birthDate) async {
    final User? registeredUser =
        await _authService.registerWithEmailAndPassword(email, password, name, surname, birthDate);
    if (registeredUser != null) {
      return 200;
    } else {
      return 401;
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }
}
