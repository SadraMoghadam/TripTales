import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trip_tales/src/utils/device_info.dart';
import '../constants/color.dart';

class CustomTale extends StatefulWidget {
  final String imagePath;
  final String text;

  CustomTale({
    Key? key,
    required this.imagePath,
    required this.text,
  }) : super(key: key);

  @override
  _CustomTaleState createState() => _CustomTaleState();
}

class _CustomTaleState extends State<CustomTale> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 300,
        height: 80,
        child: Stack(
          // alignment: Alignment.topLeft,
          children: [
            Container(
              //   alignment: Alignment.topLeft,
              margin: const EdgeInsets.all(1),
              // padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                border: Border.all(color: ctext1),
                borderRadius: BorderRadius.all(Radius.circular(
                        1.0) //                 <--- border radius here
                    ),
              ),
              child: Image.asset(
                widget.imagePath,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Container(
                //      alignment: Alignment.bottomCenter,
                child: Text(
              widget.text,
              style: TextStyle(
                  color: cmain2, fontWeight: FontWeight.bold, fontSize: 22.0),
            )),
          ],
        ));
  }
}
    
    
    /*
    SizedBox(
        width: 250,
        height: 1,
        child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: ctext2, // Border color
                width: 1,
                // Border width
              ),
            ),
            child: Column(children: <Widget>[
              Image.asset(
                widget.imagePath,
                // height: 2000,
                // width: 100.0,
                fit: BoxFit.cover,
              ),
              Positioned(
                  bottom: 1,
                  left: 1,
                  child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text(widget.text,
                          style: TextStyle(
                            color: ctext2,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ))))
            ])));

    
            SizedBox(height: 10.0),
            Text(
              widget.text,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: cmain2,
              ),
            ),
          ],
        ));
        
  }
}
*/