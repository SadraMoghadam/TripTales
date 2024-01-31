import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../constants/color.dart';
import 'button.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  Set<Marker> markers = HashSet<Marker>();
  late LatLng center =
      LatLng(37.7749, -122.4194); // Default center (San Francisco)

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        insetPadding: const EdgeInsets.all(5),
        contentPadding: const EdgeInsets.all(0),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
      content: Container(
          height: 600,
          width: 600,

        child: Column(
          children: [
            Container(
              height: 530,
              width: 600,
              margin: EdgeInsets.all(0),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.main2),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  markers: markers,
                  initialCameraPosition: CameraPosition(
                    target: center,
                    zoom: 12,
                  ),
                  onTap: _onMapTap,
                ),
              ),
            ),
            SizedBox(height: 16),
            const Text(
              'Tap on the map to add a marker',
              style: TextStyle(
                  color: AppColors.main1, fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        CustomButton(
            height: 5,
            width: 30,
            fontSize: 12,
            backgroundColor: AppColors.main3,
            text: "close",
            textColor: Colors.white,
            onPressed: () => Navigator.of(context).pop())
      ],
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  void _onMapTap(LatLng tappedPoint) {
    setState(() {
      markers.add(Marker(
        markerId: MarkerId(tappedPoint.toString()),
        position: tappedPoint,
        infoWindow: InfoWindow(
          title: 'Marker',
          snippet: 'This is a custom marker',
        ),
      ));
    });
  }
}
