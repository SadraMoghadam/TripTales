import 'package:flutter/material.dart';

class ContainerMovementHandler extends StatefulWidget {
  @override
  _ContainerMovementHandlerState createState() =>
      _ContainerMovementHandlerState();
}

class _ContainerMovementHandlerState extends State<ContainerMovementHandler> {
  final List<GlobalKey> _widgetKeyList = List.generate(numOfContainerSpaces + numOfContainers, (index) => GlobalObjectKey<FormState>(index));
  double targetTop = 50.0;
  double targetLeft = 20.0;
  double containerTop = 50.0;
  double containerLeft = 20.0;
  double safeAreaSpace = 70.0;
  bool isContainerInTarget = false;

  Size containersSize = Size(100, 100);
  Size containerSpacesSize = Size(200, 200);
  // Top Left position
  List<Offset> containerSpacesPosition = List.generate(numOfContainerSpaces, (index) => Offset(0, 0));
  static const int numOfContainerSpaces = 12;
  static const int numOfColumns = 2;
  static const int numOfContainers = 1;

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < numOfContainerSpaces; i++) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _getWidgetInfo(i));
    }
  }

  void _getWidgetInfo(int widgetId) {
    print("------------$widgetId------------");
    GlobalKey widgetKey = _widgetKeyList[widgetId];
    final RenderBox renderBox = widgetKey.currentContext?.findRenderObject() as RenderBox;
    widgetKey.currentContext?.size;

    final Size size = renderBox.size;
    print('Size: ${size.width}, ${size.height}');

    final Offset offset = renderBox.localToGlobal(Offset.zero);
    print('Offset: ${offset.dx}, ${offset.dy}');
    print('Position: ${(offset.dx + size.width) / 2}, ${(offset.dy + size.height) / 2}');

    containerSpacesSize = size;
    containerSpacesPosition[widgetId] = Offset((offset.dy), (offset.dx));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.only(top: safeAreaSpace),
        child: Stack(
      children: [
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for (int i = 0; i < numOfContainerSpaces / numOfColumns; i++)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    for (int j = 0; j < numOfColumns!; j++)
                      Flexible(
                        flex: 1,
                        child: Container(
                          key: _widgetKeyList[i * numOfColumns + j],
                          margin: EdgeInsets.all(40),
                          width: 120,
                          height: 120,
                          color: Colors.red,
                          child: const Center(
                            child: Text(
                              'Target',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                  ],
                ),
            ],
          ),
        Positioned(
          top: containerTop,
          left: containerLeft,
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                containerTop += details.delta.dy;
                containerLeft += details.delta.dx;

                isContainerInTarget = isContainerInsideTarget();
              });
            },
            onPanEnd: (details) {
              // Snap the container to the target when dragging ends
              if (isContainerInTarget) {
                setState(() {
                  containerTop = targetTop;
                  containerLeft = targetLeft;
                });
              }
            },
            child: Container(
              width: containersSize.width,
              height: containersSize.height,
              color: isContainerInTarget ? Colors.green : Colors.blue,
              child: const Center(
                child: Text(
                  'Drag me!',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }


  bool isContainerInsideTarget() {
    Offset containerTopLeft = Offset(containerTop, containerLeft);
    bool result = true;
    for (int i = 0; i < numOfContainerSpaces; i++){
      if (containerTopLeft.dx >= safeAreaSpace + containerSpacesPosition[i].dx - containerSpacesSize.height &&
          containerTopLeft.dx <= safeAreaSpace + containerSpacesPosition[i].dx &&
          containerTopLeft.dy >= containerSpacesPosition[i].dy - containerSpacesSize.width / numOfColumns &&
          containerTopLeft.dy <= containerSpacesPosition[i].dy + containerSpacesSize.width / numOfColumns) {
        targetLeft = containerSpacesPosition[i].dy + containerSpacesSize.width / (numOfColumns * 2);
        targetTop = containerSpacesPosition[i].dx - containerSpacesSize.height / (numOfContainerSpaces);
        print("+++++++++++$i");
        print("--------$targetTop");
        print("--------$targetLeft");
        return true;
      }
    }
    return false;
    return containerTop >= targetTop &&
        containerTop <= targetTop + 100.0 &&
        containerLeft >= targetLeft &&
        containerLeft <= targetLeft + 100.0;
  }
}
