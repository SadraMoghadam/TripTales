// import 'dart:io';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:trip_tales/src/models/card_model.dart';
// import 'package:trip_tales/src/services/card_service.dart';
// import '../services/auth_service.dart';
// import '../models/user_model.dart';
//
// class CardController extends GetxController {
//   final CardService _cardService = Get.find<CardService>();
//   Rx<UserModel?> currentUser = Rx<UserModel?>(null);
//
//   @override
//   void onInit() {
//     super.onInit();
//   }
//
//   int addImageCard(ImageCardModel cardData, File imageFile) async {
//     int result = await _cardService.addImageCard(cardData, imageFile);
//     if (signedInUser != null) {
//       print("logged in");
//       return 200;
//     } else {
//       print("error in login");
//       return 401;
//     }
//   }
// }
