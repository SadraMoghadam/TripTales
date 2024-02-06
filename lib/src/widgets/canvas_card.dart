import 'package:flutter/material.dart';
import 'package:trip_tales/src/utils/device_info.dart';
import '../constants/color.dart';

class CustomCanvas extends StatefulWidget {
  final String talePath;
  final String taleName;
  final VoidCallback onTap;
  final bool
  isSelected; // New parameter to determine if this widget is selected

  const CustomCanvas({
    required this.talePath,
    required this.taleName,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  _CustomCanvasState createState() => _CustomCanvasState();
}

class _CustomCanvasState extends State<CustomCanvas> {
  @override
  Widget build(BuildContext context) {
    DeviceInfo device = DeviceInfo();
    device.computeDeviceInfo(context);
    bool isTablet = device.isTablet;
    return GestureDetector(
      onTap: widget.onTap,
      child: SizedBox(
        width: isTablet ? 230 : 180,
        height: isTablet ? 350 : 270,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 15),
          margin: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            // borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                widget.talePath,
              ),
            ),
            border: Border.all(
              color: widget.isSelected ? AppColors.main2 : AppColors.main1,
              width: widget.isSelected ? 3.0 : 2.0,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Container(
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.only(bottom: 5),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                widget.taleName,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  shadows: [
                    Shadow(
                      offset: Offset(1, 1),
                      blurRadius: 15.0,
                      color: AppColors.text1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
