// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:trip_tales/src/constants/color.dart';
// import 'package:trip_tales/src/widgets/memory_card.dart';
//
// class ContainerMovementHandler extends StatefulWidget {
//   @override
//   _ContainerMovementHandlerState createState() =>
//       _ContainerMovementHandlerState();
// }
//
// class _ContainerMovementHandlerState extends State<ContainerMovementHandler>
//     with TickerProviderStateMixin {
//   final List<GlobalKey> _widgetKeyList = List.generate(
//       numOfContainerSpaces + numOfContainers,
//       (index) => GlobalObjectKey<FormState>(index));
//   double targetTop = 0.0;
//   double targetLeft = 0.0;
//   double containerTop = 0.0;
//   double containerLeft = 0.0;
//   double safeAreaSpace = 70.0 - 2;
//   bool isContainerInTarget = false;
//   late final AnimationController _controller;
//   late final AnimationController _controller_place_here;
//
//   Size containerSize = Size(100, 100);
//   Size containerSpaceSize = Size(200, 200);
//
//   // Top Left position
//   List<Offset> containerSpacesPosition =
//       List.generate(numOfContainerSpaces, (index) => Offset(0, 0));
//   static const int numOfContainerSpaces = 12;
//   static const int numOfColumns = 2;
//   static const int numOfContainers = 1;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = AnimationController(vsync: this);
//     _controller_place_here = AnimationController(vsync: this);
//     for (int i = 0; i < numOfContainerSpaces; i++) {
//       WidgetsBinding.instance.addPostFrameCallback((_) => _getWidgetInfo(i));
//     }
//   }
//
//   void _getWidgetInfo(int widgetId) {
//     print("------------$widgetId------------");
//     GlobalKey widgetKey = _widgetKeyList[widgetId];
//     final RenderBox renderBox =
//         widgetKey.currentContext?.findRenderObject() as RenderBox;
//     widgetKey.currentContext?.size;
//
//     final Size size = renderBox.size;
//     print('Size: ${size.width}, ${size.height}');
//
//     final Offset offset = renderBox.localToGlobal(Offset.zero);
//     print('Offset: ${offset.dx}, ${offset.dy}');
//     print(
//         'Position: ${(offset.dx + size.width) / 2}, ${(offset.dy + size.height) / 2}');
//
//     containerSpaceSize = size;
//     containerSpacesPosition[widgetId] = Offset((offset.dy), (offset.dx));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         minimum: EdgeInsets.only(top: safeAreaSpace),
//         child: Stack(
//           children: [
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 for (int i = 0; i < numOfContainerSpaces / numOfColumns; i++)
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       for (int j = 0; j < numOfColumns!; j++)
//                         Flexible(
//                           flex: 1,
//                           child: Container(
//                             key: _widgetKeyList[i * numOfColumns + j],
//                             margin: EdgeInsets.all(40),
//                             width: 120,
//                             height: 120,
//                             child: Center(
//                               child: Stack(children: [
//                                 Lottie.asset(
//                                   "assets/animations/placeholder.json",
//                                   controller: _controller,
//                                   width: 100,
//                                   height: 100,
//                                   onLoaded: (composition) {
//                                     _controller
//                                       ..duration = Duration(milliseconds: 2000)
//                                       ..repeat();
//                                   },
//                                 ),
//                                 Lottie.asset(
//                                   "assets/animations/place_here.json",
//                                   controller: _controller_place_here,
//                                   width: 100,
//                                   height: 100,
//                                   onLoaded: (composition) {
//                                     _controller_place_here
//                                       ..duration = Duration(milliseconds: 4000)
//                                       ..repeat();
//                                   },
//                                 ),
//                               ]),
//                             ),
//                           ),
//                         )
//                     ],
//                   ),
//               ],
//             ),
//             Positioned(
//               top: containerTop,
//               left: containerLeft,
//               child: GestureDetector(
//                 onPanUpdate: (details) {
//                   setState(() {
//                     containerTop += details.delta.dy;
//                     containerLeft += details.delta.dx;
//
//                     isContainerInTarget = isContainerInsideTarget();
//                   });
//                 },
//                 onPanEnd: (details) {
//                   // Snap the container to the target when dragging ends
//                   if (isContainerInTarget) {
//                     setState(() {
//                       containerTop = targetTop;
//                       containerLeft = targetLeft;
//                     });
//                   }
//                 },
//                 child: MemoryCard(containerSize: containerSize, isContainerInTarget: isContainerInTarget),
//               ),
//             ),
//           ],
//         ));
//   }
//
//   bool isContainerInsideTarget() {
//     Offset containerTopLeft = Offset(containerTop + containerSize.height / 2, containerLeft + containerSize.width / 2);
//     bool result = true;
//     for (int i = 0; i < numOfContainerSpaces; i++) {
//       if (containerTopLeft.dx >= safeAreaSpace + containerSpacesPosition[i].dx - containerSpaceSize.height &&
//           containerTopLeft.dx <= safeAreaSpace + containerSpacesPosition[i].dx &&
//           containerTopLeft.dy >= containerSpacesPosition[i].dy &&
//           containerTopLeft.dy <= containerSpacesPosition[i].dy + containerSpaceSize.width) {
//         targetLeft = containerSpacesPosition[i].dy + containerSpaceSize.width / (numOfColumns * 2);
//         targetTop = containerSpacesPosition[i].dx - containerSpaceSize.height / (numOfContainerSpaces);
//         print("+++++++++++$i");
//         print("--------$targetTop");
//         print("--------$targetLeft");
//         return true;
//       }
//     }
//     return false;
//     return containerTop >= targetTop &&
//         containerTop <= targetTop + 100.0 &&
//         containerLeft >= targetLeft &&
//         containerLeft <= targetLeft + 100.0;
//   }
// }
