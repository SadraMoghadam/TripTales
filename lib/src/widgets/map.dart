import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
import 'package:geocoding/geocoding.dart';

import '../constants/color.dart';
import 'button.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  Set<Marker> markers = HashSet<Marker>();
  late LatLng currentLocation = LatLng(37.7749, -122.4194); // Default center (San Francisco)

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
    _getCurrentLocation();
    _startLocationUpdates();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(5),
      contentPadding: const EdgeInsets.all(0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      content: Container(
        height: 650,
        width: 600,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      controller: searchController,
                      onChanged: (value) {
                        // Implement search suggestions here if needed
                      },
                      onFieldSubmitted: (value) {
                        _searchLocation(value);
                      },
                      decoration: InputDecoration(
                        hintText: 'Search location...',
                        suffixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Stack(
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
                        target: currentLocation,
                        zoom: 12.0,
                      ),
                      onTap: _onMapTap,
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            const Text(
              'Tap on the map to add a marker',
              style: TextStyle(
                color: AppColors.main2,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        CustomButton(
            height: 5,
            width: 20,
            padding: 10,
            fontSize: 12,
            backgroundColor: AppColors.main3,
            text: "close",
            textColor: Colors.white,
            onPressed: () => Navigator.of(context).pop(false)),
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

  void _zoomToCurrentLocation() {
    if (currentLocation != null) {
      mapController.animateCamera(
        CameraUpdate.newLatLngZoom(
          currentLocation,
          15.0,
        ),
      );
    }
  }

  void _requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isDenied) {
      print('Location permission denied');
    }
  }

  void _getCurrentLocation() async {
    var location = loc.Location();
    try {
      var currentLocationData = await location.getLocation();
      setState(() {
        currentLocation = LatLng(
          currentLocationData.latitude!,
          currentLocationData.longitude!,
        );
      });
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  void _startLocationUpdates() {
    var location = loc.Location();
    location.onLocationChanged.listen((loc.LocationData locationData) {
      setState(() {
        currentLocation = LatLng(
          locationData.latitude!,
          locationData.longitude!,
        );
      });
    });
  }

  Future<void> _searchLocation(String locationName) async {
    try {
      List<Location> locations = await locationFromAddress(locationName);
      if (locations.isNotEmpty) {
        var location = locations.first;
        mapController.animateCamera(
          CameraUpdate.newLatLngZoom(
            LatLng(location.latitude, location.longitude),
            15.0,
          ),
        );
      }
    } catch (e) {
      print('Error searching location: $e');
    }
  }
}
