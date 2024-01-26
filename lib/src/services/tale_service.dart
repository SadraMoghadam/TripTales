import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:trip_tales/src/constants/memory_card_type.dart';
import 'package:trip_tales/src/models/card_model.dart';
import 'package:trip_tales/src/models/tale_model.dart';

class TaleService extends GetxService {
  // final AuthService _authService = Get.find<AuthService>();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final CollectionReference _talesCollection =
      FirebaseFirestore.instance.collection('tales');
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Rx<TaleModel?> card = Rx<TaleModel?>(null);

  @override
  void onInit() {
    super.onInit();
  }

  Future<int> addTale(TaleModel taleData, File imageFile) async {
    try {
      // String? currentUserId = _authService.currentUserId;
      List<TaleModel?> currentTales = await getTales("1");
      var contain =
        currentTales.where((element) => element!.name == taleData.name);
      if (!contain.isEmpty) {
        return 400;
      }
      Future<bool> isUploaded = _uploadImage(imageFile, taleData.imagePath);
      print("___________________________---${await isUploaded}");
      DocumentReference taleReference = await _talesCollection.add(
          taleData.toJson()
      );

      await FirebaseFirestore.instance.collection('users').doc("1").update({
        'talesFK': FieldValue.arrayUnion([taleReference.id]),
      });

      print('tale added successfully.');
      return 200;
    } catch (e) {
      print('Error adding tale: $e');
      return 401;
    }
  }

  // Future<int> updateCard(CardModel cardData) async {
  //   try {
  //     // String? currentUserId = _authService.currentUserId;
  //     List<CardModel?> currentCards = await getCards("1");
  //     final DocumentSnapshot<Map<String, dynamic>> userDoc =
  //     await _firestore.collection('users').doc('1').get();
  //     final userData = userDoc.data();
  //     print(userData);
  //     var contain =
  //         currentCards.where((element) => element!.name == cardData.name);
  //     if (!contain.isEmpty) {
  //       String cardId = await getCardId(contain.first!.name);
  //       // print('(((((((((((((${cardId}');
  //       if(contain.first!.type == MemoryCardType.image || contain.first!.type == MemoryCardType.video){
  //         await FirebaseFirestore.instance.collection('cards').doc(cardId).update(
  //             cardData.toJson()
  //         );
  //         // print('+++++++++++++++${cardId}');
  //       }
  //       else if(contain.first!.type == MemoryCardType.text){
  //         await FirebaseFirestore.instance.collection('cards').doc(cardId).update(
  //             cardData.toJsonTextCard()
  //         );
  //         // print('=====================${cardId}');
  //       }
  //
  //       print('Card updated successfully.');
  //       return 200;
  //     }
  //     return 401;
  //   }
  //   // print("__________________${cardData.toJsonTextCard()}");
  //   catch (e) {
  //     print('Error updated card: $e');
  //     return 401;
  //   }
  // }

  Future<int> deleteTaleByName(String name) async {
    try {
      // String? currentUserId = _authService.currentUserId;
      List<TaleModel?> currentTales = await getTales("1");
      final DocumentSnapshot<Map<String, dynamic>> userDoc =
      await _firestore.collection('users').doc('1').get();
      final userData = userDoc.data();
      print(userData);
      var contain =
      currentTales.where((element) => element!.name == name);
      if (!contain.isEmpty) {
        String taleId = await getTaleId(contain.first!.name);
        await FirebaseFirestore.instance.collection('tales').doc(taleId).delete();
        await FirebaseFirestore.instance.collection('users').doc("1").update({
          'talesFK': FieldValue.arrayRemove([taleId]),
        });

        print('Card deleted successfully.');
        return 200;
      }
      return 401;
    }
    // print("__________________${cardData.toJsonTextCard()}");
    catch (e) {
      print('Error delete card: $e');
      return 401;
    }
  }

  Future<List<TaleModel?>> getTales(String uid) async {
    try {
      List<TaleModel> tales = [];
      final DocumentSnapshot<Map<String, dynamic>> userDoc =
          await _firestore.collection('users').doc(uid).get();
      final userData = userDoc.data();
      for (int i = 0; i < userData?['talesFK'].length; i++) {
        final DocumentSnapshot<Map<String, dynamic>> taleDoc = await _firestore
            .collection('tales')
            .doc(userData?['talesFK'][i])
            .get();
        final taleData = taleDoc.data()!;

        if (taleData != null) {
            String downloadURL =
                await _storage.ref().child(taleData['name']).getDownloadURL();
            // print("video:      ${downloadURL}");
            TaleModel taleModel = TaleModel(
              name: taleData['name'],
              imagePath: downloadURL,
              canvas: taleData['canvas'],
              cardsFK: List<String>.empty(),
            );
            tales.add(taleModel);
          }
        }
      return tales;
    } catch (e) {
      // Get.snackbar('Error', e.toString());
      return List.empty();
    }
  }

  Future<bool> _uploadImage(File imageFile, String imageName) async {
    try {
      await _storage.ref().child(imageName).putFile(imageFile);
      print('Image uploaded successfully.');
      return Future.value(true);
    } on FirebaseException catch (e) {
      print('Error uploading image: $e');
      return Future.value(false);
    }
  }

  Future<String> getTaleId(String name) async {
    List<TaleModel?> currentTales = await getTales("1");
    final DocumentSnapshot<Map<String, dynamic>> userDoc =
        await _firestore.collection('users').doc('1').get();
    final userData = userDoc.data();
    print(userData);
    for (int i = 0; i < currentTales.length; i++){
      if(name == currentTales[i]!.name){
        return userData!['talesFK'][i];
      }
    }
    return "";
  }
}
