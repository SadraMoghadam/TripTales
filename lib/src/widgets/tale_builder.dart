import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:trip_tales/src/constants/color.dart';
import 'package:trip_tales/src/constants/memory_card_info.dart';
import 'package:trip_tales/src/constants/memory_card_type.dart';
import 'package:trip_tales/src/utils/dynamic_stack.dart';
import 'package:trip_tales/src/widgets/memory_card.dart';

import '../utils/device_info.dart';

class TaleBuilder extends StatefulWidget {
  @override
  _TaleBuilderState createState() => _TaleBuilderState();
}

class _TaleBuilderState extends State<TaleBuilder>
    with TickerProviderStateMixin {
  final List<GlobalKey> _widgetKeyList = List.generate(
      numOfContainers, (index) => GlobalObjectKey<FormState>(index));
  double containerTop = 0.0;
  double containerLeft = 0.0;
  double safeAreaSpace = 70.0 - 2;
  late final AnimationController _controller;
  late final AnimationController _controller_place_here;

  List<Size> containersSize = [Size(100, 100), Size(300, 300), Size(200, 200)];

  static const int numOfContainers = 3;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
    _controller_place_here = AnimationController(vsync: this);
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
      return Container(
        height: device.height * 10,
          width: device.width,
          child: DynamicStack(
              children: [
            // for (int i = 0; i < numOfContainers; i++)
            //   MemoryCard(cardKey: _widgetKeyList[i], type: MemoryCardType.image,)

                MemoryCard(cardKey: _widgetKeyList[0], type: MemoryCardType.image, imagePath: "assets/images/london_tale.jpg", size: containersSize[0], onSizeChanged: (newSize) {containersSize[0] = newSize;}, ),
                MemoryCard(cardKey: _widgetKeyList[1], type: MemoryCardType.image, imagePath: "assets/images/winter_tale.jpg", size: containersSize[1], onSizeChanged: (newSize) {containersSize[1] = newSize;}, ),
                MemoryCard(cardKey: _widgetKeyList[2], type: MemoryCardType.video, size: containersSize[2], onSizeChanged: (newSize) {containersSize[2] = newSize;}, ),
                // MemoryCard(cardKey: _widgetKeyList[3], type: MemoryCardType.text,),
          ],
          )
      );
  }
}
