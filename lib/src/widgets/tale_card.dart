import 'package:flutter/material.dart';
import '../constants/color.dart';

class CustomTale extends StatefulWidget {
  final String talePath;
  final String taleName;
  final bool talePos;
  final int index;
  bool isFavorited; // Include isFavorited in CustomTale

  CustomTale({
    Key? key,
    required this.talePath,
    required this.taleName,
    required this.talePos,
    required this.index,
    this.isFavorited = false, // Set default to false
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
        onTap: () {
          Navigator.of(context).pushNamed('/createTalePage');
          /*
          setState(() {
            widget.isFavorited = !widget.isFavorited;
          });
          */
        },
        child: SizedBox(
          width: 280,
          height: 200,
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(
                    bottom: 12, top: 5, left: 5, right: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(widget.talePath),
                  ),
                ),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  margin: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    widget.taleName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                    ),
                  ),
                ),
              ),
              if (widget.index != 0)
                Positioned(
                  top: 2,
                  right: 10,
                  child: IconButton(
                    icon: Icon(
                      widget.isFavorited
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      color: widget.isFavorited ? AppColors.main1 : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        widget.isFavorited = !widget.isFavorited;
                      });
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
