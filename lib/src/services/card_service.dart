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
import '../utils/app_manager.dart';
import '../utils/matrix_utils.dart';
import 'auth_service.dart';

class CardService extends GetxService {
  // final AuthService _authService = Get.find<AuthService>();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final AppManager _appManager = Get.put(AppManager());
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
      // cardData.order = currentCards.length;
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
      List<CardModel?> currentCards = await getCards("1");
      var contain =
          currentCards.where((element) => element!.name == cardData.name);
      if (!contain.isEmpty) {
        return 400;
      }
      // cardData.order = currentCards.length;
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
      // print("__________________$cardReference");
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

  Future<int> updateCard(CardModel cardData) async {
    try {
      // String? currentUserId = _authService.currentUserId;
      List<CardModel?> currentCards = await getCards("1");
      final DocumentSnapshot<Map<String, dynamic>> userDoc =
      await _firestore.collection('users').doc('1').get();
      final userData = userDoc.data();
      print(userData);
      var contain =
          currentCards.where((element) => element!.name == cardData.name);
      if (!contain.isEmpty) {
        String cardId = await getCardId(contain.first!.name);
        // print('(((((((((((((${cardId}');
        if(contain.first!.type == MemoryCardType.image || contain.first!.type == MemoryCardType.video){
          await FirebaseFirestore.instance.collection('cards').doc(cardId).update({
            'userId': '1',
            'cardData': cardData.toJson(),
          });
          // print('+++++++++++++++${cardId}');
        }
        else if(contain.first!.type == MemoryCardType.text){
          await FirebaseFirestore.instance.collection('cards').doc(cardId).update({
            'userId': '1',
            'cardData': cardData.toJsonTextCard(),
          });
          // print('=====================${cardId}');
        }

        print('Card updated successfully.');
        return 200;
      }
      return 401;
    }
    // print("__________________${cardData.toJsonTextCard()}");
    catch (e) {
      print('Error updated card: $e');
      return 401;
    }
  }

  Future<int> updateCardTransform(String name, Matrix4 transform) async {
    try {
      // String? currentUserId = _authService.currentUserId;
      List<CardModel?> currentCards = await getCards("1");
      final DocumentSnapshot<Map<String, dynamic>> userDoc =
      await _firestore.collection('users').doc('1').get();
      final userData = userDoc.data();
      print(userData);
      var contain = currentCards.where((element) => element!.name == name);
      if (!contain.isEmpty) {
        CardModel newCard;
        CardModel currentCard = contain.first!;
        String cardId = await getCardId(currentCard.name);
        if(currentCard.type == MemoryCardType.image || currentCard.type == MemoryCardType.video){
          newCard = CardModel(
            uid: currentCard.uid,
            order: currentCard.order,
            type: currentCard.type,
            transform: transform,
            // path: currentCard.path,
            name: currentCard.name,
            text: currentCard.text,
            textColor: currentCard.textColor,
            textBackgroundColor: currentCard.textBackgroundColor,
            textDecoration: currentCard.textDecoration,
            fontStyle: currentCard.fontStyle,
            fontWeight: currentCard.fontWeight,
            fontSize: currentCard.fontSize,
          );
          await FirebaseFirestore.instance.collection('cards').doc(cardId).update({
            'userId': '1',
            'cardData': newCard.toJson(),
          });
        }
        // else if(currentCard.type == MemoryCardType.text){
        else{
          newCard = CardModel(
            uid: currentCard.uid,
            order: currentCard.order,
            type: currentCard.type,
            transform: transform,
            path: currentCard.path,
            name: currentCard.name,
            // text: currentCard.text,
            // textColor: currentCard.textColor,
            // textBackgroundColor: currentCard.textBackgroundColor,
            // textDecoration: currentCard.textDecoration,
            // fontStyle: currentCard.fontStyle,
            // fontWeight: currentCard.fontWeight,
            // fontSize: currentCard.fontSize,
          );
          await FirebaseFirestore.instance.collection('cards').doc(cardId).update({
            'userId': '1',
            'cardData': newCard.toJsonTextCard(),
          });
        }
        // _appManager.setCardByName(newCard);

        print('Card transform updated successfully.');
        return 200;
      }
      return 401;
    }
    // print("__________________${cardData.toJsonTextCard()}");
    catch (e) {
      print('Error transform updated card: $e');
      return 401;
    }
  }

  Future<int> deleteCardByName(String name) async {
    try {
      // String? currentUserId = _authService.currentUserId;
      List<CardModel?> currentCards = await getCards("1");
      final DocumentSnapshot<Map<String, dynamic>> userDoc =
      await _firestore.collection('users').doc('1').get();
      final userData = userDoc.data();
      print(userData);
      var contain =
      currentCards.where((element) => element!.name == name);
      if (!contain.isEmpty) {
        String cardId = await getCardId(contain.first!.name);
        await FirebaseFirestore.instance.collection('cards').doc(cardId).delete();
        await FirebaseFirestore.instance.collection('users').doc("1").update({
          'cards': FieldValue.arrayRemove([cardId]),
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

  Future<List<CardModel?>> getCards(String uid) async {
    try {
      List<CardModel> cards = [];
      final DocumentSnapshot<Map<String, dynamic>> userDoc =
          await _firestore.collection('users').doc(uid).get();
      final userData = userDoc.data();
      // print("__________________${userData?['cards'].length}");
      for (int i = 0; i < userData?['cards'].length; i++) {
        final DocumentSnapshot<Map<String, dynamic>> cardDoc = await _firestore
            .collection('cards')
            .doc(userData?['cards'][i])
            .get();
        final cardData = cardDoc.data()!['cardData'];

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
            print("video:      ${downloadURL}");
            CardModel cardModel = CardModel(
              uid: '1',
              order: cardData['order'],
              type: type,
              transform: CustomMatrixUtils.jsonToMatrix4(cardData['transform']),
              path: downloadURL,
              name: cardData['name'],
              size: Size(cardData['size'], cardData['size']),
              // text: '',
              // textColor: Colors.white,
              // textBackgroundColor: Colors.white,
              // textDecoration: TextDecoration.none,
              // fontStyle: FontStyle.normal,
              // fontWeight: FontWeight.normal,
              fontSize: 0,
            );
            cards.add(cardModel);
          } else if (type == MemoryCardType.text) {
            // print("----------------------${cardData['fontSize']}");
            // print(
            //     "----------------------${MemoryCardType.values.byName(cardData['type'])}");
            // print(
            //     "----------------------${CustomMatrixUtils.jsonToMatrix4(cardData['transform'])}");
            // print("----------------------${cardData['path']}");
            // print("----------------------${cardData['name']}");
            CardModel cardModel = CardModel(
              uid: '1',
              order: cardData['order'],
              type: type,
              transform: CustomMatrixUtils.jsonToMatrix4(cardData['transform']),
              name: cardData['name'],
              // path: '',
              // size: Size(0, 0),
              text: cardData['text'],
              textColor: TextUtils.textToColor(cardData['textColor']),
              textBackgroundColor:
                  TextUtils.textToColor(cardData['textBackgroundColor']),
              textDecoration:
                  TextUtils.textToDecoration(cardData['textDecoration']),
              fontStyle: TextUtils.textToFontStyle(cardData['fontStyle']),
              fontWeight: TextUtils.textToFontWeight(cardData['fontWeight']),
              fontSize: cardData['fontSize'],
            );
            // print("----------------------${cardData['name']}");
            cards.add(cardModel);
          }
        }
      }
      // print('%%%%%%%%%%%%%%%%%%${cards.length}');
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

  Future<String> getCardId(String name) async {
    List<CardModel?> currentCards = await getCards("1");
    final DocumentSnapshot<Map<String, dynamic>> userDoc =
        await _firestore.collection('users').doc('1').get();
    final userData = userDoc.data();
    print(userData);
    for (int i = 0; i < currentCards.length; i++){
      if(name == currentCards[i]!.name){
        return userData!['cards'][i];
      }
    }
    return "";
  }
}
