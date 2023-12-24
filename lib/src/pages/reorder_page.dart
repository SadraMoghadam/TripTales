import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:trip_tales/src/constants/error_messages.dart';
import 'package:trip_tales/src/constants/memory_card_type.dart';
import 'package:trip_tales/src/controllers/card_controller.dart';
import 'package:trip_tales/src/models/card_model.dart';
import 'package:trip_tales/src/screen/set_photo_screen.dart';
import 'package:trip_tales/src/services/card_service.dart';
import 'package:trip_tales/src/utils/app_manager.dart';
import 'package:trip_tales/src/utils/validator.dart';
import '../constants/color.dart';
import '../controllers/media_controller.dart';
import '../utils/device_info.dart';
import '../widgets/button.dart';
import '../widgets/text_field.dart';

class ReorderPage extends StatefulWidget {
  @override
  _ReorderPageState createState() => _ReorderPageState();
}

class _ReorderPageState extends State<ReorderPage> {
  final AppManager _appManager = Get.put(AppManager());
  final CardService _cardService = Get.find<CardService>();
  final SetPhotoScreen setPhotoScreen = SetPhotoScreen();
  List<CardModel?> cardsOrder = [];

  @override
  void initState() {
    super.initState();
    cardsOrder = _appManager.getCards()!;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DeviceInfo device = DeviceInfo();
    device.computeDeviceInfo(context);
    return AlertDialog(
      elevation: 10,
      shadowColor: Colors.grey,
      title: const Center(
          child: Text(
        'Reorder your memories',
        style: TextStyle(
            color: AppColors.main1, fontSize: 25, fontWeight: FontWeight.w700),
      )),
      insetPadding: const EdgeInsets.all(10),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      content: buildBody(device),
      actions: <Widget>[
        CustomButton(
            height: 5,
            width: 30,
            fontSize: 12,
            backgroundColor: AppColors.main3,
            text: "close",
            textColor: Colors.white,
            onPressed: () => Navigator.of(context).pop())
      ],
    );
  }

  Widget buildBody(DeviceInfo device) {
    final Color draggableItemColor = AppColors.main3;

    Widget proxyDecorator(
        Widget child, int index, Animation<double> animation) {
      return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          final double animValue = Curves.easeInOut.transform(animation.value);
          final double elevation = lerpDouble(0, 6, animValue)!;
          return Material(
            elevation: elevation,
            color: draggableItemColor,
            shadowColor: draggableItemColor,
            child: child,
          );
        },
        child: child,
      );
    }

    return Container(
      height: 400,
      width: 300,
      padding: const EdgeInsets.all(8.0),
      child: ReorderableListView(
        proxyDecorator: proxyDecorator,
        children: [
          for (int i = 0; i < cardsOrder.length; i++)
            Card(
              color: AppColors.main2.shade100,
              key: ValueKey(i),
              elevation: 2.0,
              child: ListTile(
                title: Text(cardsOrder[i]!.name),
                leading:
                    const Icon(Icons.drag_handle_rounded, color: Colors.black),
              ),
            ),
        ],
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) {
              newIndex = newIndex - 1;
            }
          });
          final task = cardsOrder.removeAt(oldIndex);
          cardsOrder.insert(newIndex, task);
          reorderCards();
        },
      ),
    );
  }

  void reorderCards(){
    for(int i = 0; i < cardsOrder.length!; i++){
      // if(cardsOrder[i]!.type == MemoryCardType.image || cardsOrder[i]!.type == MemoryCardType.image){
      //   cardsOrder[i] = CardModel(uid: i, order: order, type: type, transform: transform);
      // }
      // else if(cardsOrder[i]!.type == MemoryCardType.text){
      //   cardsOrder[i] = CardModel(uid: i, order: order, type: type, transform: transform);
      // }
      cardsOrder[i] = CardModel(
        uid: cardsOrder[i]!.uid,
        order: i,
        type: cardsOrder[i]!.type,
        transform: cardsOrder[i]!.transform,
        name: cardsOrder[i]!.name,
        text: cardsOrder[i]!.text,
        textColor: cardsOrder[i]!.textColor,
        textBackgroundColor: cardsOrder[i]!.textBackgroundColor,
        textDecoration: cardsOrder[i]!.textDecoration,
        fontStyle: cardsOrder[i]!.fontStyle,
        fontWeight: cardsOrder[i]!.fontWeight,
        fontSize: cardsOrder[i]!.fontSize,
      );
      _cardService.updateCard(cardsOrder[i]!);
    }
    _appManager.setCards(cardsOrder);
  }

}