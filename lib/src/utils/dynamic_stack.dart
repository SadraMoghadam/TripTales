import 'package:flutter/material.dart';
import 'package:trip_tales/src/widgets/memory_card.dart';

class DynamicStack extends StatelessWidget {
  final List<Widget> children;

  DynamicStack({required this.children});

  @override
  Widget build(BuildContext context) {
    // Sort the containers based on size in ascending order
    // children.sort((a, b) {
    //   double sizeA = (a as MemoryCard).size.height;
    //   double sizeB = (b as MemoryCard).size.height;
    //   return sizeB.compareTo(sizeA);
    // });

    children.sort((a, b) {
      int orderA = (a as MemoryCard).order;
      int orderB = (b as MemoryCard).order;
      return orderB.compareTo(orderA);
    });

    return Stack(
      children: children,
    );
  }
}

//
// class DynamicStack extends StatelessWidget {
//   final List<MemoryCard> children;
//
//   const DynamicStack({super.key, required this.children});
//
//   @override
//   Widget build(BuildContext context) {
//     // Sort the children by size (descending order)
//     List<MemoryCard> sortedChildren = List.from(children)
//       ..sort((a, b) {
//         double sizeA = a.size.width * a.size.height;
//         double sizeB = b.size.width * b.size.height;
//         return sizeB.compareTo(sizeA);
//       });
//
//     return Stack(
//       children: sortedChildren.map((info) => MemoryCard(cardKey:info.cardKey, type:info.type, size:info.size, onSizeChanged: info.onSizeChanged, imagePath: info.imagePath, videoPath: info.videoPath, position: info.position, rotation: info.rotation,)).toList(),
//     );
//     return IndexedStack(
//       children: sortedChildren,
//     );
//   }
// }