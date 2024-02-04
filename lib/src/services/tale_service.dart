import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trip_tales/src/models/tale_model.dart';
import 'package:trip_tales/src/utils/tuple.dart';

import '../utils/app_manager.dart';

class TaleService extends GetxService {
  // final AuthService _authService = Get.find<AuthService>();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final CollectionReference _talesCollection =
      FirebaseFirestore.instance.collection('tales');
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AppManager _appManager = Get.put(AppManager());

  @override
  void onInit() {
    super.onInit();
  }

  Future<int> addTale(TaleModel taleData, File imageFile) async {
    try {
      List<TaleModel?> currentTales = await getTales(_appManager.getCurrentUser());
      var contain = currentTales.where((element) => element!.name == taleData.name);
      if (!contain.isEmpty) {
        return 400;
      }
      DocumentReference taleReference = await _talesCollection.add(taleData.toJson());

      await _firestore
          .collection('users')
          .doc(_appManager.getCurrentUser())
          .update({
        'talesFK': FieldValue.arrayUnion([taleReference.id]),
      });

      String imagePath = '${taleReference.id}_TALE.png';
      await _firestore
          .collection('tales')
          .doc(taleReference.id)
          .update({
        'id': taleReference.id,
        'imagePath': imagePath,
      });

      Future<bool> isUploaded = _uploadImage(imageFile, imagePath);

      print('tale added successfully.');
      return 200;
    } catch (e) {
      print('Error adding tale: $e');
      return 401;
    }
  }

  Future<int> updateTale(TaleModel taleData, File imageFile) async {
    try {
      // String? currentUserId = _authService.currentUserId;
      List<TaleModel?> currentTales =
          await getTales(_appManager.getCurrentUser());
      final DocumentSnapshot<Map<String, dynamic>> userDoc = await _firestore
          .collection('users')
          .doc(_appManager.getCurrentUser())
          .get();
      final userData = userDoc.data();
      print("__________________${userData}");

      // print(userData);
      var currentTale = _appManager.getCurrentTale();
      print("__________________${currentTale}");
      // renameStorageObject(currentTale.imagePath, "${currentTale.name}_TALE", taleData.imagePath);
      Future<bool> isUploaded = _uploadImage(imageFile, taleData.imagePath);
      var contain =
          currentTales.where((element) => element!.id == taleData.id);
      if (!contain.isEmpty || (contain.isEmpty && taleData.name != '')) {
        await _firestore
            .collection('tales')
            .doc(taleData.id)
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

  Future<int> updateTaleLikeById(String id, bool liked) async {
    try {
      // String? currentUserId = _authService.currentUserId;
      List<TaleModel?> currentTales =
          await getTales(_appManager.getCurrentUser());
      final DocumentSnapshot<Map<String, dynamic>> userDoc = await _firestore
          .collection('users')
          .doc(_appManager.getCurrentUser())
          .get();
      final userData = userDoc.data();
      print(userData);
      var contain = currentTales.where((element) => element!.id == id);
      if (!contain.isEmpty) {
        await FirebaseFirestore.instance
            .collection('tales')
            .doc(id)
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

  Future<int> deleteTaleById(String id) async {
    try {
      List<TaleModel?> currentTales =
          await getTales(_appManager.getCurrentUser());
      final DocumentSnapshot<Map<String, dynamic>> userDoc = await _firestore
          .collection('users')
          .doc(_appManager.getCurrentUser())
          .get();
      final userData = userDoc.data();
      print(userData);
      var contain = currentTales.where((element) => element!.id == id);
      if (!contain.isEmpty) {
        await FirebaseFirestore.instance
            .collection('tales')
            .doc(id)
            .delete();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(_appManager.getCurrentUser())
            .update({
          'talesFK': FieldValue.arrayRemove([id]),
        });
        await FirebaseStorage.instance.refFromURL(contain.first!.imagePath).delete();

        print('Tale deleted successfully.');
        return 200;
      }
      return 401;
    }
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
      for (int i = 0; i < userData?['talesFK'].length; i++) {
        final DocumentSnapshot<Map<String, dynamic>> taleDoc = await _firestore
            .collection('tales')
            .doc(userData?['talesFK'][i])
            .get();
        final taleData = taleDoc.data()!;
        // print("=+=========${userData}");

        if (taleData != null) {
          // print("=+=========${taleData['imagePath']}");
          String downloadURL = await _storage
              .ref()
              .child(taleData['imagePath'])
              .getDownloadURL();
          TaleModel taleModel = TaleModel(
            id: taleData['id'],
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

  // Future<void> renameStorageObject(String path, String oldObjectName, String newObjectName) async {
  //   Reference storageRef = FirebaseStorage.instance.ref().child(path);
  //
  //   try {
  //     print("=+=========+++++++++++++++++++++++++${await storageRef.child(path).getDownloadURL()}");
  //     String oldObjectDownloadURL = await storageRef.getDownloadURL();
  //     print("=+=========+++++++++++++++++++++++++${oldObjectDownloadURL}");
  //     var data = await storageRef.child(oldObjectName).getData();
  //     print("=+=========+++++++++++++++++++++++++${data}");
  //     await storageRef.child(newObjectName).putData(data!);
  //
  //     await storageRef.child(oldObjectName).delete();
  //
  //     print('Object renamed successfully.');
  //   } catch (e) {
  //     print('Error renaming the object: $e');
  //   }
  // }

  Future<List<Tuple<String, LatLng>>> getTaleLocations(String id) async {
    String taleId = id;
    List<Tuple<String, LatLng>> cardsloc = [];
    final DocumentSnapshot<Map<String, dynamic>> taleDoc =
        await _firestore.collection('tales').doc(taleId).get();
    final taleData = taleDoc.data();
    // print("=+=========${userData}");
    if(taleData?['cardsFK'] != null){
      for (int i = 0; i < taleData?['cardsFK'].length; i++) {
        final DocumentSnapshot<Map<String, dynamic>> cardDoc = await _firestore
            .collection('cards')
            .doc(taleData?['cardsFK'][i])
            .get();
        final cardData = cardDoc.data()!;

        if (cardData != null &&
            cardData['locationLatitude'] != null &&
            cardData['locationLongitude'] != null) {
          cardsloc.add(Tuple(cardData['name'],
              LatLng(cardData['locationLatitude'], cardData['locationLongitude'])));
        }
      }
    }

    return cardsloc;
  }

  Future<List<TaleModel?>> getFavoriteTales(String uid) async {
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

        if (taleData != null && taleData['liked'] == true) {
          // print("=+=========${taleData['imagePath']}");
          String downloadURL = await _storage
              .ref()
              .child(taleData['imagePath'])
              .getDownloadURL();
          // print("video:      ${downloadURL}");
          TaleModel taleModel = TaleModel(
            id: taleData['id'],
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
        String downloadURL = '';
        try {
          downloadURL = await _storage.ref().child(taleData['imagePath']).getDownloadURL();
        } catch (e) {
          print(e);
          downloadURL = '';
        }
        TaleModel taleModel = TaleModel(
          id: taleData['id'],
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
      // print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&$imageName,,,,,,,,,$imageFile");
      await FirebaseStorage.instance.ref().child(imageName).putFile(imageFile);
      print('Image uploaded successfully.');
      return Future.value(true);
    } on FirebaseException catch (e) {
      print('Error uploading image: $e');
      return Future.value(false);
    }
  }

  Future<String> getTaleId(String name) async {
    List<TaleModel?> currentTales =
        await getTales(_appManager.getCurrentUser());
    final DocumentSnapshot<Map<String, dynamic>> userDoc = await _firestore
        .collection('users')
        .doc(_appManager.getCurrentUser())
        .get();
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
