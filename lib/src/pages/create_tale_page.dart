import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trip_tales/src/constants/tale_background.dart';
import 'package:trip_tales/src/models/tale_model.dart';
import 'package:trip_tales/src/screen/set_photo_screen.dart';
import 'package:trip_tales/src/services/tale_service.dart';
import 'package:trip_tales/src/widgets/canvas_card.dart';
import 'package:trip_tales/src/widgets/map.dart';
import '../constants/color.dart';
import '../constants/error_messages.dart';
import '../controllers/media_controller.dart';
import '../utils/app_manager.dart';
import '../utils/device_info.dart';
import '../utils/validator.dart';
import '../widgets/button.dart';
import '../widgets/text_field.dart';
import '../widgets/app_bar_tale.dart';

class CreateTalePage extends StatefulWidget {
  @override
  _CreateTalePage createState() => _CreateTalePage();
}

class _CreateTalePage extends State<CreateTalePage> {
  late final TextEditingController _taleNameController;
  final MediaController mediaController = Get.put(MediaController());
  final TaleService _taleService = Get.find<TaleService>();
  final AppManager _appManager = Get.put(AppManager());
  final SetPhotoScreen setPhotoScreen = SetPhotoScreen();
  final Validator _validator = Validator();
  bool _isScrollingDisabled = false;
  final _formKey = GlobalKey<FormState>();
  GoogleMapController? _mapController;
  Set<Marker> _markers = HashSet<Marker>();
  LatLng? _selectedLocation;
  int selectedIndex = 0;

  void _submit() async {
    final isValid = _formKey.currentState?.validate();
    if (isValid == null || !isValid) {
      return;
    }
    print(selectedIndex.toString());
    TaleModel taleData = TaleModel(
        name: _taleNameController.text,
        imagePath: '${_taleNameController.text}_TALE.png',
        canvas: selectedIndex.toString());
    File? imageFile = mediaController.getImage();
    int result = 400;
    if (imageFile != null) {
      result = await _taleService.addTale(taleData, imageFile!);
    }
    if (result == 200) {
      _formKey.currentState?.save();
      String taleId = await _taleService.getTaleId(_taleNameController.text);
      _appManager.setCurrentTaleId(taleId);
      _appManager.setCurrentTale(taleData);
      Navigator.of(context).pushNamed('/talePage');
    } else {
      ErrorController.showSnackBarError(ErrorController.createTale);
      return;
    }
  }

  @override
  void initState() {
    _taleNameController = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _taleNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DeviceInfo device = DeviceInfo();
    device.computeDeviceInfo(context);
    return Scaffold(
      body: CustomAppBar(
        bodyTale: buildBody(),
        showIcon: true,
        navigationPath: '/customMenu',
      ),
    );
  }

  Widget buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Flexible(
          fit: FlexFit.tight,
          flex: 11,
          child: buildScreen(),
        ),
      ],
    );
  }

  Widget buildScreen() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 320,
              child: SetPhotoScreen(isImage: true),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 60,
              width: 330,
              child: CustomTextField(
                key: const Key('taleNameCustomTextFieldKey'),
                controller: _taleNameController,
                labelText: 'Tale Name',
                hintText: 'Enter your Tale Name',
                prefixIcon: Icons.abc,
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: _validator.nameValidator,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            //SizedBox(
            // height: 305,
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    '  Choose your canvas:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.main1,
                      fontSize: 20,
                    ),
                  ),
                  buildCanvasList(),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            buildGoogleMap(),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              child: CustomButton(
                key: const Key('startCreatingCustomButtonKey'),
                fontSize: 18,
                padding: 2,
                backgroundColor: AppColors.main2,
                textColor: Colors.white,
                text: "Start Creating",
                onPressed: _submit,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  // Widget buildGoogleMap() {
  //   return Container(
  //     height: 400, // Adjust the height as needed
  //     width: 400,  // Adjust the width as needed
  //     child: ClipRRect(
  //       borderRadius: BorderRadius.circular(16.0),
  //       child: InteractiveViewer(
  //         boundaryMargin: EdgeInsets.all(double.infinity),
  //         child: GoogleMap(
  //           onMapCreated: _onMapCreated,
  //           markers: _markers,
  //           initialCameraPosition: CameraPosition(
  //             target: LatLng(37.7749, -122.4194),
  //             zoom: 12,
  //           ),
  //           onTap: _onMapTap,
  //         ),
  //       ),
  //     ),
  //   );
  // }
  //
  // void _onMapCreated(GoogleMapController controller) {
  //   setState(() {
  //     _mapController = controller;
  //   });
  // }
  //
  // void _onMapTap(LatLng tappedPoint) {
  //   setState(() {
  //     _markers.add(
  //       Marker(
  //         markerId: MarkerId(tappedPoint.toString()),
  //         position: tappedPoint,
  //         infoWindow: InfoWindow(
  //           title: 'Marker',
  //           snippet: 'This is a custom marker',
  //         ),
  //       ),
  //     );
  //   });
  // }

  Widget buildGoogleMap() {
    return Container(
      height: 400,
      width: 400,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.main2),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          height: 400,
          child: GoogleMap(
            onMapCreated: _onMapCreated,
            markers: _markers,
            initialCameraPosition: CameraPosition(
              target: LatLng(37.7749, -122.4194),
              zoom: 12,
            ),
            onTap: _onMapTap,
          ),
        ),
        // GoogleMap(
        // onMapCreated: (controller) {
        //   setState(() {
        //     _mapController = controller;
        //   });
        // },
        // onCameraMove: (CameraPosition position) {
        //   // Update the selected location based on camera movement
        //   setState(() {
        //     _selectedLocation = position.target;
        //   });
        // },
        // onTap: (latLng) {
        //   // Handle the tapped location
        //   setState(() {
        //     _selectedLocation = latLng;
        //   });
        // },
        //
        //   onTap: (latLng) {
        //     print("Map tapped at: $latLng");
        //     showDialog(
        //       context: context,
        //       builder: (context) {
        //         return MapScreen();
        //       },
        //     );
        //   },
        //   initialCameraPosition: CameraPosition(
        //     target: LatLng(37.7749, -122.4194),
        //     zoom: 15,
        //   ),
        //   markers: _selectedLocation != null
        //       ? {
        //           Marker(
        //             markerId: MarkerId('selected'),
        //             position: _selectedLocation!,
        //             draggable: true,
        //             onDragEnd: (dragEndPosition) {
        //               setState(() {
        //                 _selectedLocation = dragEndPosition;
        //               });
        //             },
        //           ),
        //         }
        //       : {},
        // ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
    });
  }

  void _onMapTap(LatLng tappedPoint) {
    showDialog(
      context: context,
      builder: (context) {
        return MapScreen();
      },
    );
    // setState(() {
    //   _markers.add(Marker(
    //     markerId: MarkerId(tappedPoint.toString()),
    //     position: tappedPoint,
    //     infoWindow: InfoWindow(
    //       title: 'Marker',
    //       snippet: 'This is a custom marker',
    //     ),
    //   ));
    // });
  }

  Widget buildCanvasList() {
    return SizedBox(
      height: 280,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (int i = 0; i < TaleBackground.totalNum; i++)
              CustomCanvas(
                talePath: TaleBackground.paths[i],
                taleName: TaleBackground.names[i],
                onTap: () {
                  setState(() {
                    selectedIndex = i; // Mark this item as selected
                  });
                },
                isSelected:
                    selectedIndex == i, // Check if this item is selected
              ),
          ],
        ),
      ),
    );
  }
}
