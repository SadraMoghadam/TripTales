import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:trip_tales/src/constants/color.dart';
import 'package:trip_tales/src/constants/memory_card_info.dart';
import 'package:trip_tales/src/constants/memory_card_type.dart';
import 'package:trip_tales/src/pages/tale.dart';
import 'package:trip_tales/src/utils/dynamic_stack.dart';
import 'package:trip_tales/src/utils/text_utils.dart';
import 'package:trip_tales/src/widgets/memory_card.dart';

import '../models/card_model.dart';
import '../services/card_service.dart';
import '../utils/device_info.dart';

class TaleBuilder extends StatefulWidget {
  final Function callback;

  const TaleBuilder({super.key, required this.callback});

  @override
  _TaleBuilderState createState() => _TaleBuilderState();
}

class _TaleBuilderState extends State<TaleBuilder>
    with TickerProviderStateMixin {
  final CardService _cardService = Get.find<CardService>();
  late List<GlobalKey> _widgetKeyList;
  double containerTop = 0.0;
  double containerLeft = 0.0;
  late final AnimationController _controller;
  late final AnimationController _controller_place_here;
  late Future<List<CardModel?>> cards;

  Size containersSize = Size(300, 300);

  static int numOfCards = 0;

  @override
  void didUpdateWidget(covariant TaleBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);

    print("sadawdwadawwdafdw HHHHHHHHHHHEEEEEEEEEEEE");
    setState(() {
      cards = _cardService.getCards("1");
      print(cards.then((value) => print(value.length)));
    });
  }

  @override
  void initState() {
    super.initState();
    print("YYYYYYYYYYYYYYYYYYYYYYYYYYYY HHHHHHHHHHHEEEEEEEEEEEE");
    cards = _cardService.getCards("1");
    // _controller = AnimationController(vsync: this);
    // _controller_place_here = AnimationController(vsync: this);
    // for (int i = 0; i < numOfCards; i++) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) => _getWidgetInfo(i));
    // }
  }

  void _getWidgetInfo(int widgetId) {
    print("------------$widgetId------------");
    GlobalKey widgetKey = _widgetKeyList[widgetId];
    final RenderBox renderBox =
        widgetKey.currentContext?.findRenderObject() as RenderBox;
    widgetKey.currentContext?.size;

    final Size size = renderBox.size;
    print('Size: ${size.width}, ${size.height}');

    final Offset offset = renderBox.localToGlobal(Offset.zero);
    print('Offset: ${offset.dx}, ${offset.dy}');
    print(
        'Position: ${(offset.dx + size.width) / 2}, ${(offset.dy + size.height) / 2}');
  }

  @override
  Widget build(BuildContext context) {
    DeviceInfo device = DeviceInfo();
    device.computeDeviceInfo(context);
    return FutureBuilder<List<CardModel?>>(
      future: cards,
      builder:
          (BuildContext context, AsyncSnapshot<List<CardModel?>> snapshot) {
        if (snapshot.hasData) {
          numOfCards = snapshot.data!.length;
          _widgetKeyList = List.generate(
              numOfCards, (index) => GlobalObjectKey<FormState>(index));
          return Container(
            height: device.height * 10,
            width: device.width,
            child: DynamicStack(
              children: [
                for (int i = 0; i < numOfCards; i++)
                  if (snapshot.data![i]!.type == MemoryCardType.image)
                    MemoryCard(
                        cardKey: _widgetKeyList[i],
                        order: snapshot.data![i]!.order,
                        type: MemoryCardType.image,
                        initTransform: snapshot.data![i]!.transform,
                        imagePath: snapshot.data![i]!.path)
                  else if (snapshot.data![i]!.type == MemoryCardType.video)
                    MemoryCard(
                        cardKey: _widgetKeyList[i],
                        order: snapshot.data![i]!.order,
                        type: MemoryCardType.video,
                        initTransform: snapshot.data![i]!.transform,
                        videoPath: snapshot.data![i]!.path)
                  else if (snapshot.data![i]!.type == MemoryCardType.text)
                    MemoryCard(
                      cardKey: _widgetKeyList[i],
                      order: snapshot.data![i]!.order,
                      type: MemoryCardType.text,
                      initTransform: snapshot.data![i]!.transform,
                      text: snapshot.data![i]!.text,
                      textColor: snapshot.data![i]!.textColor,
                      textBackgroundColor: snapshot.data![i]!.textBackgroundColor,
                      textDecoration: snapshot.data![i]!.textDecoration,
                      fontStyle: snapshot.data![i]!.fontStyle,
                      fontWeight: snapshot.data![i]!.fontWeight,
                      fontSize: snapshot.data![i]!.fontSize,
                    )

                // MemoryCard(cardKey: _widgetKeyList[0], order: 1, type: MemoryCardType.image, initTransform: Matrix4.identity(), imagePath: "https://picsum.photos/200/300", size: containersSize[0]),
                // MemoryCard(cardKey: _widgetKeyList[1], order: 3, type: MemoryCardType.image, initTransform: Matrix4.identity(), imagePath: "https://picsum.photos/900/500", size: containersSize[1]),
                // MemoryCard(cardKey: _widgetKeyList[2], order: 2, type: MemoryCardType.video, initTransform: Matrix4.identity(), size: containersSize[2]),
                // MemoryCard(cardKey: _widgetKeyList[3], order: 0, type: MemoryCardType.text, initTransform: Matrix4.identity(), size: containersSize[2]),
                // MemoryCard(cardKey: _widgetKeyList[3], type: MemoryCardType.text,),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return Text("Error: ${snapshot.error}");
        }
        return Container();
      },
    );
  }
}
