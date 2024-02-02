import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
import 'package:geocoding/geocoding.dart';
import 'package:trip_tales/src/utils/app_manager.dart';

import '../constants/color.dart';
import 'button.dart';

class MapScreen extends StatefulWidget {
  final bool multipleLoc;
  final bool isReadonly;
  Set<Marker>? markers;

  MapScreen(
      {super.key,
      this.multipleLoc = false,
      this.isReadonly = false,
      this.markers});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  Set<Marker> markers = HashSet<Marker>();
  final AppManager _appManager = Get.put(AppManager());
  late LatLng currentLocation = LatLng(37.7749, -122.4194);
  late LatLng? zoomLocation;

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
    _getCurrentLocation();
    // _startLocationUpdates();
    _initMarker();
  }

  @override
  void dispose() {
    super.dispose();
    _disposeLocationUpdates();
    mapController.dispose();
    searchController.dispose();
    // _appManager.dispose();
  }

  void _disposeLocationUpdates() {
    var location = loc.Location();
    location.onLocationChanged.listen(null)?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(5),
      contentPadding: const EdgeInsets.all(0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      content: SingleChildScrollView(
        child: Container(
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
                        decoration: const InputDecoration(
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
                        markers: widget.isReadonly ? widget.markers! : markers,
                        initialCameraPosition: CameraPosition(
                          target: widget.isReadonly ? widget.markers!.first.position : currentLocation,
                          zoom: 12.0,
                        ),
                        onTap: widget.isReadonly ? null : _onMapTap,
                        myLocationButtonEnabled: true,
                        myLocationEnabled: true,
                      ),
                    ),
                  ),
                ],
              ),
              widget.isReadonly ? Container() : SizedBox(height: 16),
              widget.isReadonly
                  ? Container()
                  : const Text(
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
      ),
      actions: <Widget>[
        widget.isReadonly
            ? Container()
            : CustomButton(
                height: 5,
                width: 20,
                padding: 10,
                fontSize: 12,
                backgroundColor: AppColors.main2,
                text: "choose",
                textColor: Colors.white,
                onPressed: () => {
                  _appManager.setChosenLocation(markers.first.position),
                  // print("#########################################################################################################################################################################################${_appManager.getChosenLocation()!.item1}"),
                  Navigator.of(context).pop(true),
                },
              ),
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
      _getCurrentLocation();
      _zoomToCurrentLocation();
    });
  }

  void _initMarker() {
    var chosenLoc = _appManager.getChosenLocation();
    print(
        "================================================================================================================================================================================================================$chosenLoc");
    if (chosenLoc != null) {
      print(
          "=============================================================================================================================================================================================================================$chosenLoc");
      LatLng chosenLocLatLng = LatLng(
        chosenLoc!.item1 ?? 0,
        chosenLoc!.item2 ?? 0,
      );
      setState(() {
        if (!markers.isEmpty) {
          markers.clear();
        }
        markers.add(Marker(
          markerId: MarkerId(chosenLocLatLng.toString()),
          position: chosenLocLatLng,
          infoWindow: const InfoWindow(
            title: 'Marker',
            snippet: 'This is a custom marker',
          ),
        ));
      });
    }
  }

  void _onMapTap(LatLng tappedPoint) {
    if (widget.multipleLoc) {
      setState(() {
        markers.add(Marker(
          markerId: MarkerId(tappedPoint.toString()),
          position: tappedPoint,
          infoWindow: const InfoWindow(
            title: 'Marker',
            snippet: 'This is a custom marker',
          ),
        ));
      });
    } else {
      setState(() {
        if (!markers.isEmpty) {
          markers.clear();
        }
        markers.add(Marker(
          markerId: MarkerId(tappedPoint.toString()),
          position: tappedPoint,
          infoWindow: const InfoWindow(
            title: 'Marker',
            snippet: 'This is a custom marker',
          ),
        ));
      });
    }
  }

  void _zoomToCurrentLocation() {
    if (zoomLocation != null) {
      print("------------------------$zoomLocation");
      mapController.animateCamera(
        CameraUpdate.newLatLngZoom(
          zoomLocation!,
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
    if (mounted) {
      var chosenLoc = _appManager.getChosenLocation();
      if (chosenLoc == null) {
        var location = loc.Location();
        try {
          var currentLocationData = await location.getLocation();
          setState(() {
            currentLocation = LatLng(
              currentLocationData.latitude!,
              currentLocationData.longitude!,
            );
            zoomLocation = currentLocation;
          });
        } catch (e) {
          print('Error getting location: $e');
        }
      } else {
        setState(() {
          zoomLocation = LatLng(
            chosenLoc.item1 ?? 0,
            chosenLoc.item2 ?? 0,
          );
        });
      }
    }
  }

  // void _startLocationUpdates() {
  //   var location = loc.Location();
  //   location.onLocationChanged.listen((loc.LocationData locationData) {
  //     setState(() {
  //       currentLocation = LatLng(
  //         locationData.latitude!,
  //         locationData.longitude!,
  //       );
  //     });
  //   });
  // }

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
