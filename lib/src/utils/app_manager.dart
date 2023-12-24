import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trip_tales/src/models/card_model.dart';

class AppManager extends GetxController {
  Rx<List<CardModel?>?> userCards = Rx<List<CardModel?>?>(null);

  void setCards(List<CardModel?>? cards) {
    userCards.value = cards;
  }

  List<CardModel?>? getCards() {
    if(userCards == Rx<List<CardModel?>?>(null))
      return [];
    userCards.value!.sort((a, b) => a!.order.compareTo(b!.order));
    return userCards.value;
  }

  int getCardsNum(){
    return userCards.value!.length;
  }
}