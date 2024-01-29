import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:trip_tales/src/models/tale_model.dart';

class TaleService extends GetxService {
  // final AuthService _authService = Get.find<AuthService>();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final CollectionReference _talesCollection =
      FirebaseFirestore.instance.collection('tales');
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
      DocumentReference taleReference =
          await _talesCollection.add(taleData.toJson());

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

  Future<int> updateTale(TaleModel taleData) async {
    try {
      // String? currentUserId = _authService.currentUserId;
      List<TaleModel?> currentTales = await getTales("1");
      final DocumentSnapshot<Map<String, dynamic>> userDoc =
          await _firestore.collection('users').doc('1').get();
      final userData = userDoc.data();
      print(userData);
      var contain =
          currentTales.where((element) => element!.name == taleData.name);
      if (!contain.isEmpty) {
        String taleId = await getTaleId(contain.first!.name);
        await FirebaseFirestore.instance
            .collection('tales')
            .doc(taleId)
            .update(taleData.toJson());
        print('Tale updated successfully.');
        return 200;
      }
      return 401;
    }
    // print("__________________${cardData.toJsonTextTale()}");
    catch (e) {
      print('Error updated tale: $e');
      return 401;
    }
  }

  Future<int> updateTaleLikeByName(String name, bool liked) async {
    try {
      // String? currentUserId = _authService.currentUserId;
      List<TaleModel?> currentTales = await getTales("1");
      final DocumentSnapshot<Map<String, dynamic>> userDoc =
          await _firestore.collection('users').doc('1').get();
      final userData = userDoc.data();
      print(userData);
      var contain = currentTales.where((element) => element!.name == name);
      if (!contain.isEmpty) {
        String taleId = await getTaleId(contain.first!.name);
        await FirebaseFirestore.instance
            .collection('tales')
            .doc(taleId)
            .update({
          'liked': liked,
        });
        print('Tale updated successfully.');
        return 200;
      }
      return 401;
    }
    // print("__________________${cardData.toJsonTextTale()}");
    catch (e) {
      print('Error updated tale: $e');
      return 401;
    }
  }

  Future<int> deleteTaleByName(String name) async {
    try {
      // String? currentUserId = _authService.currentUserId;
      List<TaleModel?> currentTales = await getTales("1");
      final DocumentSnapshot<Map<String, dynamic>> userDoc =
          await _firestore.collection('users').doc('1').get();
      final userData = userDoc.data();
      print(userData);
      var contain = currentTales.where((element) => element!.name == name);
      if (!contain.isEmpty) {
        String taleId = await getTaleId(contain.first!.name);
        await FirebaseFirestore.instance
            .collection('tales')
            .doc(taleId)
            .delete();
        await FirebaseFirestore.instance.collection('users').doc("1").update({
          'talesFK': FieldValue.arrayRemove([taleId]),
        });

        print('Tale deleted successfully.');
        return 200;
      }
      return 401;
    }
    // print("__________________${taleData.toJsonTextTale()}");
    catch (e) {
      print('Error delete tale: $e');
      return 401;
    }
  }

  Future<List<TaleModel?>> getTales(String uid) async {
    try {
      List<TaleModel> tales = [];
      final DocumentSnapshot<Map<String, dynamic>> userDoc =
          await _firestore.collection('users').doc(uid).get();
      final userData = userDoc.data();
      // print("=+=========${userData}");
      for (int i = 0; i < userData?['talesFK'].length; i++) {
        final DocumentSnapshot<Map<String, dynamic>> taleDoc = await _firestore
            .collection('tales')
            .doc(userData?['talesFK'][i])
            .get();
        final taleData = taleDoc.data()!;

        if (taleData != null) {
          // print("=+=========${taleData['imagePath']}");
          String downloadURL = await _storage
              .ref()
              .child(taleData['imagePath'])
              .getDownloadURL();
          // print("video:      ${downloadURL}");
          TaleModel taleModel = TaleModel(
            name: taleData['name'],
            imagePath: downloadURL,
            canvas: taleData['canvas'],
            liked: taleData['liked'],
            cardsFK: taleData['cardsFK'] != null
                ? List<String>.from(taleData['cardsFK'])
                : null,
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

  Future<List<TaleModel?>> getFavoriteTales(String uid) async {
    try {
      List<TaleModel> tales = [];
      final DocumentSnapshot<Map<String, dynamic>> userDoc =
          await _firestore.collection('users').doc(uid).get();
      final userData = userDoc.data();
      print("=+=========${userData}");
      for (int i = 0; i < userData?['talesFK'].length; i++) {
        final DocumentSnapshot<Map<String, dynamic>> taleDoc = await _firestore
            .collection('tales')
            .doc(userData?['talesFK'][i])
            .get();
        final taleData = taleDoc.data()!;

        if (taleData != null && taleData['liked'] == true) {
          print("=+=========${taleData['imagePath']}");
          String downloadURL = await _storage
              .ref()
              .child(taleData['imagePath'])
              .getDownloadURL();
          // print("video:      ${downloadURL}");
          TaleModel taleModel = TaleModel(
            name: taleData['name'],
            imagePath: downloadURL,
            canvas: taleData['canvas'],
            liked: taleData['liked'],
            cardsFK: taleData['cardsFK'] != null
                ? List<String>.from(taleData['cardsFK'])
                : null,
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

  Future<TaleModel?> getTaleById(String taleId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> taleDoc =
          await _firestore.collection('tales').doc(taleId).get();
      final taleData = taleDoc.data();
      if (taleData != null) {
        String downloadURL =
            await _storage.ref().child(taleData['imagePath']).getDownloadURL();
        TaleModel taleModel = TaleModel(
          name: taleData['name'],
          imagePath: downloadURL,
          canvas: taleData['canvas'],
          liked: taleData['liked'],
          cardsFK: taleData['cardsFK'] != null
              ? List<String>.from(taleData['cardsFK'])
              : null,
        );
        return taleModel;
      }
      return null;
    } catch (e) {
      // Get.snackbar('Error', e.toString());
      return null;
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
    for (int i = 0; i < currentTales.length; i++) {
      if (name == currentTales[i]!.name) {
        return userData!['talesFK'][i];
      }
    }
    return "";
  }
}
