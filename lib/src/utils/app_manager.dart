import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trip_tales/src/models/card_model.dart';

class AppManager extends GetxController {
  Rx<List<CardModel?>?> userCards = Rx<List<CardModel?>?>(null);

  void setCards(List<CardModel?>? cards) {
    userCards.value = cards;
  }

  // void setCardByName(CardModel? card) {
  //   userCards.value![userCards.value!.indexWhere((element) => element!.name == card!.name)] = card!;
  // }


  List<CardModel?>? getCards() {
    if(userCards == Rx<List<CardModel?>?>(null))
      return [];
    userCards.value!.sort((a, b) => a!.order.compareTo(b!.order));
    return userCards.value;
  }

  int getCardsNum(){
    if(userCards == Rx<List<CardModel?>?>(null))
      return 0;
    return userCards.value!.length;
  }
}