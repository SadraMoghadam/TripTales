import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trip_tales/src/utils/device_info.dart';
import '../constants/color.dart';

class CustomTale extends StatefulWidget {
  final String talePath;
  final String taleName;
  final bool talePos;

  CustomTale({
    Key? key,
    required this.talePath,
    required this.taleName,
    required this.talePos,
  }) : super(key: key);

  @override
  _CustomTaleState createState() => _CustomTaleState();
}

class _CustomTaleState extends State<CustomTale> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: widget.talePos
          ? AlignmentDirectional.topStart
          : AlignmentDirectional.topEnd,
      child: GestureDetector(
        onTap: () => Navigator.pushReplacementNamed(context, '/myTalesPage'),
        child: SizedBox(
          width: 280,
          height: 200,
          child: Container(
            margin: EdgeInsets.only(bottom: 12, top: 5, left: 5, right: 5),
            decoration: BoxDecoration(
                border: Border.all(color: ctext1),
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    widget.talePath,
                  ),
                )),
            child: Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(bottom: 5),
              child: Text(
                widget.taleName,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
