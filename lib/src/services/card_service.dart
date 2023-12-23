import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trip_tales/src/constants/firestore_collections.dart';
import 'package:trip_tales/src/constants/memory_card_type.dart';
import 'package:trip_tales/src/models/card_model.dart';
import 'package:trip_tales/src/utils/text_utils.dart';
import '../utils/matrix_utils.dart';
import 'auth_service.dart';

class CardService extends GetxService {
  // final AuthService _authService = Get.find<AuthService>();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final CollectionReference _cardsCollection =
      FirebaseFirestore.instance.collection('cards');
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<CardModel> cards = [];

  Rx<CardModel?> card = Rx<CardModel?>(null);

  @override
  void onInit() {
    super.onInit();
  }

  Future<int> addImageCard(CardModel cardData, File imageFile) async {
    try {
      // String? currentUserId = _authService.currentUserId;
      List<CardModel?> currentCards = await getCards("1");
      var contain =
          currentCards.where((element) => element!.name == cardData.name);
      if (!contain.isEmpty) {
        return 400;
      }
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

  Future<int> addVideoCard(CardModel cardData, XFile videoFile) async {
    try {
      // String? currentUserId = _authService.currentUserId;
      // List<ImageCardModel?> currentCards = await getImageCards("1");
      // var contain = currentCards.where((element) => element!.name == cardData.name);
      // if(!contain.isEmpty){
      //   return 400;
      // }
      Future<bool> isUploaded = _uploadVideo(videoFile, cardData.name);
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

  Future<int> addTextCard(CardModel cardData) async {
    try {
      // String? currentUserId = _authService.currentUserId;
      List<CardModel?> currentCards = await getCards("1");
      var contain =
      currentCards.where((element) => element!.name == cardData.name);
      if (!contain.isEmpty) {
        return 400;
      }
      // print("__________________${cardData.toJsonTextCard()}");
      DocumentReference cardReference = await _cardsCollection.add({
        'userId': '1',
        'cardData': cardData.toJsonTextCard(),
      });
      print("__________________$cardReference");
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

  Future<List<CardModel?>> getCards(String uid) async {
    try {
      List<CardModel> cards = [];
      final DocumentSnapshot<Map<String, dynamic>> userDoc =
          await _firestore.collection('users').doc(uid).get();
      final userData = userDoc.data();
      // print("__________________$userData");
      for (int i = 0; i < userData?['cards'].length; i++) {
        final DocumentSnapshot<Map<String, dynamic>> cardDoc = await _firestore
            .collection('cards')
            .doc(userData?['cards'][i])
            .get();
        final cardData = cardDoc.data()!['cardData'];
        Reference ref = _storage.ref().child('your_image_path');

        if (cardData != null) {
          // print("----------------------${cardData['order']}");
          // print(
          //     "----------------------${MemoryCardType.values.byName(cardData['type'])}");
          // print(
          //     "----------------------${CustomMatrixUtils.jsonToMatrix4(cardData['transform'])}");
          // print("----------------------${cardData['path']}");
          // print("----------------------${cardData['name']}");
          MemoryCardType type = MemoryCardType.values.byName(cardData['type']);
          if (type == MemoryCardType.image || type == MemoryCardType.video) {
            String downloadURL =
            await _storage.ref().child(cardData['name']).getDownloadURL();
            CardModel cardModel = CardModel(
              id: '1',
              order: cardData['order'],
              type: type,
              transform: CustomMatrixUtils.jsonToMatrix4(cardData['transform']),
              path: downloadURL,
              name: cardData['name'],
            );
            cards.add(cardModel);
          }
          else if(type == MemoryCardType.text){
            // print("----------------------${cardData['fontSize']}");
            // print(
            //     "----------------------${MemoryCardType.values.byName(cardData['type'])}");
            // print(
            //     "----------------------${CustomMatrixUtils.jsonToMatrix4(cardData['transform'])}");
            // print("----------------------${cardData['path']}");
            // print("----------------------${cardData['name']}");
            CardModel cardModel = CardModel(
              id: '1',
              order: cardData['order'],
              type: type,
              transform: CustomMatrixUtils.jsonToMatrix4(cardData['transform']),
              name: cardData['name'],
              text: cardData['text'],
              textColor: TextUtils.textToColor(cardData['textColor']),
              textBackgroundColor: TextUtils.textToColor(cardData['textBackgroundColor']),
              textDecoration: TextUtils.textToDecoration(cardData['textDecoration']),
              fontStyle: TextUtils.textToFontStyle(cardData['fontStyle']),
              fontWeight: TextUtils.textToFontWeight(cardData['fontWeight']),
              fontSize: cardData['fontSize'],
            );
            cards.add(cardModel);
          }
        }
      }
      print('%%%%%%%%%%%%%%%%%%${cards.length}');
      return cards;
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



  Future<bool> _uploadVideo(XFile videoFile, String videoName) async {
    try {
      await _storage.ref().child(videoName).putFile(File(videoFile.path));
      print('Image uploaded successfully.');
      return Future.value(true);
    } on FirebaseException catch (e) {
      print('Error uploading image: $e');
      return Future.value(false);
    }
  }
}
