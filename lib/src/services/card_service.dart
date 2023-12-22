import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_tales/src/constants/firestore_collections.dart';
import 'package:trip_tales/src/constants/memory_card_type.dart';
import 'package:trip_tales/src/models/card_model.dart';
import '../utils/matrix_utils.dart';
import 'auth_service.dart';

class CardService extends GetxService {
  // final AuthService _authService = Get.find<AuthService>();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final CollectionReference _cardsCollection =
      FirebaseFirestore.instance.collection('cards');
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<ImageCardModel> imageCards = [];

  Rx<CardModel?> card = Rx<CardModel?>(null);

  @override
  void onInit() {
    super.onInit();
  }

  Future<int> addImageCard(ImageCardModel cardData, File imageFile) async {
    try {
      // String? currentUserId = _authService.currentUserId;
      Future<bool> isUploaded = _uploadImage(imageFile, cardData.name);
      DocumentReference cardReference = await _cardsCollection.add({
        'userId': '1',
        'cardData': cardData.toJson(),
      });
      await FirebaseFirestore.instance.collection('users').doc("1").update({
        'cards': FieldValue.arrayUnion([cardReference.id]),
      });

      print('Card added successfully.');
      return 200;
    } catch (e) {
      print('Error adding card: $e');
      return 401;
    }
  }

  Future<List<ImageCardModel?>> getImageCards(String uid) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> userDoc =
          await _firestore.collection('users').doc(uid).get();
      final userData = userDoc.data();
      print("__________________$userData");
      for (int i = 0; i < userData?['cards'].length; i++) {
        final DocumentSnapshot<Map<String, dynamic>> cardDoc = await _firestore
            .collection('cards')
            .doc(userData?['cards'][i])
            .get();
        final cardData = cardDoc.data()!['cardData'];
        Reference ref = _storage.ref().child('your_image_path');

        if (cardData != null) {

          print("----------------------${cardData['order']}");
          print("----------------------${MemoryCardType.values.byName(cardData['type'])}");
          print("----------------------${CustomMatrixUtils.jsonToMatrix4(cardData['transform'])}");
          print("----------------------${cardData['path']}");
          print("----------------------${cardData['name']}");
          ImageCardModel cardModel = ImageCardModel(
            id: '1',
            order: cardData['order'],
            type: MemoryCardType.values.byName(cardData['type']),
            transform: CustomMatrixUtils.jsonToMatrix4(cardData['transform']),
            path: await _storage.ref().child(cardData['name']).getDownloadURL(),
            name: cardData['name'],
          );
          imageCards.add(cardModel);
        }
      }
      print('%%%%%%%%%%%%%%%%%%${imageCards[0].order}');
      return imageCards;
    } catch (e) {
      Get.snackbar('Error', e.toString());
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
}
