import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trip_tales/src/utils/device_info.dart';
import '../constants/color.dart';

class CustomCanvas extends StatefulWidget {
  final String talePath;
  final String taleName;
//  final bool talePos;

  CustomCanvas({
    Key? key,
    required this.talePath,
    required this.taleName,
    //  required this.talePos,
  }) : super(key: key);

  @override
  _CustomCanvasState createState() => _CustomCanvasState();
}

class _CustomCanvasState extends State<CustomCanvas> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushReplacementNamed(context, '/myTalesPage'),
      child: SizedBox(
        width: 180,
        height: 270,
        child: Container(
          alignment: Alignment.bottomCenter,
          margin: const EdgeInsets.only(bottom: 5, top: 5, left: 5, right: 5),
          decoration: BoxDecoration(
              border: Border.all(color: cmain1),
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  widget.talePath,
                ),
              )),
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
                      offset: Offset(0, 0), // Specify shadow offset
                      blurRadius: 10.0, // Specify shadow blur radius
                      color: ctext1, // Specify shadow color
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      //  ),
    );
  }
}
