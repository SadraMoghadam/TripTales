import 'package:flutter/material.dart';
import 'package:trip_tales/src/constants/color.dart';


class MemoryCard extends StatelessWidget {

  final Size containerSize;
  final bool isContainerInTarget;

  const MemoryCard({
    super.key,
    required this.containerSize,
    required this.isContainerInTarget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: containerSize.width,
      height: containerSize.height,
      decoration: BoxDecoration(
          color: AppColors.main2,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.black26, width: 5)
      ),
      child: const Center(
        child: Text(
          'Memory',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
