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
import 'package:trip_tales/src/widgets/reset_position_dialog.dart';
import '../constants/color.dart';
import '../controllers/media_controller.dart';
import '../utils/device_info.dart';
import '../widgets/button.dart';
import '../widgets/delete_item_dialog.dart';
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
  List<CardModel?> newCardsOrder = [];
  bool canClose = true;

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
            isDisabled: !canClose,
            text: "close",
            textColor: Colors.white,
            onPressed: () => Navigator.of(context).pop(true))
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
                trailing:
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    resetPositionButton(cardsOrder[i]!.name),
                    SizedBox(width: 2), // Adjust the spacing between buttons
                    deleteButton(cardsOrder[i]!.name),
                  ],
                ),
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

  Widget resetPositionButton(String name) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return ResetPositionDialog(name: name);
            });
      },
      child: Container(
        padding: EdgeInsets.all(1),
        child:
        const Icon(Icons.restart_alt, size: 22, color: AppColors.main1),
      ),
    );
  }

  Widget deleteButton(String name) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return DeleteItemDialog(name: name);
            }).then((value) => setState(() {
              if(value) {
                cardsOrder.removeAt(
                  cardsOrder.indexWhere((element) => element!.name == name));
              }
            }));
      },
      child: Container(
        padding: EdgeInsets.all(1),
        child:
            const Icon(Icons.delete_rounded, size: 22, color: AppColors.main3),
      ),
    );
  }

  void reorderCards() {
    canClose = false;
    newCardsOrder = [];
    for (int i = 0; i < cardsOrder.length!; i++) {
      // print('------------__________${cardsOrder[i]!.name} ===== ${cardsOrder[i]!.order}');
      if (cardsOrder[i]!.type == MemoryCardType.image ||
          cardsOrder[i]!.type == MemoryCardType.video) {
        newCardsOrder.add(CardModel(
          // id: cardsOrder[i]!.id,
          order: i,
          type: cardsOrder[i]!.type,
          transform: cardsOrder[i]!.transform,
          path: cardsOrder[i]!.path,
          name: cardsOrder[i]!.name,
          locationLatitude: cardsOrder[i]!.locationLatitude,
          locationLongitude: cardsOrder[i]!.locationLongitude,
          // text: cardsOrder[i]!.text,
          // textColor: cardsOrder[i]!.textColor,
          // textBackgroundColor: cardsOrder[i]!.textBackgroundColor,
          // textDecoration: cardsOrder[i]!.textDecoration,
          // fontStyle: cardsOrder[i]!.fontStyle,
          // fontWeight: cardsOrder[i]!.fontWeight,
          // fontSize: cardsOrder[i]!.fontSize,
        ));
      } else if (cardsOrder[i]!.type == MemoryCardType.text) {
        newCardsOrder.add(CardModel(
          // id: cardsOrder[i]!.id,
          order: i,
          type: cardsOrder[i]!.type,
          transform: cardsOrder[i]!.transform,
          // path: cardsOrder[i]!.path,
          name: cardsOrder[i]!.name,
          text: cardsOrder[i]!.text,
          textColor: cardsOrder[i]!.textColor,
          textBackgroundColor: cardsOrder[i]!.textBackgroundColor,
          textDecoration: cardsOrder[i]!.textDecoration,
          fontStyle: cardsOrder[i]!.fontStyle,
          fontWeight: cardsOrder[i]!.fontWeight,
          fontSize: cardsOrder[i]!.fontSize,
          locationLatitude: cardsOrder[i]!.locationLatitude,
          locationLongitude: cardsOrder[i]!.locationLongitude,
        ));
      }

      // print('__________------------${newCardsOrder[i]!.name} ===== ${newCardsOrder[i]!.order}');
    }
    for (int i = 0; i < newCardsOrder.length!; i++) {
      _cardService
          .updateCard(_appManager.getCurrentTaleId(), newCardsOrder[i]!)
          .then((value) {
        if (i == newCardsOrder.length! - 1) {
          setState(() {
            canClose = true;
          });
        }
      });
    }
    _appManager.setCards(newCardsOrder);
  }
}
