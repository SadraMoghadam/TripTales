import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:trip_tales/src/constants/color.dart';
import 'package:trip_tales/src/constants/memory_card_info.dart';
import 'package:trip_tales/src/constants/memory_card_type.dart';
import 'package:trip_tales/src/utils/dynamic_stack.dart';
import 'package:trip_tales/src/widgets/memory_card.dart';

import '../models/card_model.dart';
import '../services/card_service.dart';
import '../utils/device_info.dart';

class TaleBuilder extends StatefulWidget {
  @override
  _TaleBuilderState createState() => _TaleBuilderState();
}

class _TaleBuilderState extends State<TaleBuilder>
    with TickerProviderStateMixin {
  final CardService _cardService = Get.find<CardService>();
  final List<GlobalKey> _widgetKeyList = List.generate(
      numOfContainers, (index) => GlobalObjectKey<FormState>(index));
  double containerTop = 0.0;
  double containerLeft = 0.0;
  late final AnimationController _controller;
  late final AnimationController _controller_place_here;
  late Future<List<ImageCardModel?>> imageCards;

  List<Size> containersSize = [Size(300, 300), Size(300, 300), Size(300, 300)];

  static const int numOfContainers = 3;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
    _controller_place_here = AnimationController(vsync: this);
    imageCards = _cardService.getImageCards("1");
    // for (int i = 0; i < numOfContainers; i++) {
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
      return FutureBuilder<List<ImageCardModel?>>(
          future: imageCards,
          builder: (BuildContext context, AsyncSnapshot<List<ImageCardModel?>> snapshot) {
            if(snapshot.hasData) {
              print(snapshot.data);
              return Container(
                height: device.height * 10,
                width: device.width,
                child: DynamicStack(
                  children: [
                    for (int i = 0; i < numOfContainers; i++)
                      MemoryCard(cardKey: _widgetKeyList[i], order: snapshot.data![i]!.order, type: snapshot.data![i]!.type, initTransform: snapshot.data![i]!.transform, imagePath: snapshot.data![i]!.path, size: containersSize[0])

                    // MemoryCard(cardKey: _widgetKeyList[0], order: 1, type: MemoryCardType.image, initTransform: Matrix4.identity(), imagePath: "https://picsum.photos/200/300", size: containersSize[0]),
                    // MemoryCard(cardKey: _widgetKeyList[1], order: 3, type: MemoryCardType.image, initTransform: Matrix4.identity(), imagePath: "https://picsum.photos/900/500", size: containersSize[1]),
                    // MemoryCard(cardKey: _widgetKeyList[2], order: 2, type: MemoryCardType.video, initTransform: Matrix4.identity(), size: containersSize[2]),
                    // MemoryCard(cardKey: _widgetKeyList[3], order: 0, type: MemoryCardType.text, initTransform: Matrix4.identity(), size: containersSize[2]),
                    // MemoryCard(cardKey: _widgetKeyList[3], type: MemoryCardType.text,),
                  ],
                ),
              );
            }
            else if(snapshot.hasError){
              print(snapshot.error);
              return Text("Error: ${snapshot.error}");
            }
            return Container();

          },
      );
  }
}
